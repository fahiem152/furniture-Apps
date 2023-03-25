import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:furniture/models/product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddOrderProduct extends StatefulWidget {
  const AddOrderProduct({super.key});

  @override
  State<AddOrderProduct> createState() => _AddOrderProductState();
}

class _AddOrderProductState extends State<AddOrderProduct> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerAddresController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _addressDetailController = TextEditingController();
  final _productController = TextEditingController();
  bool isLoading = false;
  String roleId = '0';
  String? productSelected;
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    roleId = await getRole();
    print('roleid: ' + roleId);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);

    handleCreateOrderProduct() async {
      setState(() {
        isLoading = true;
      });
      if (productProvider.valueProduct == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await orderProductProvider.createOrderProduct(
          addressDetails: _addressDetailController.text,
          customerAddres: _customerAddresController.text,
          customerPhone: _customerPhoneController.text,
          customerName: _customerNameController.text,
          productPrice: int.parse(_priceController.text),
          quantity: int.parse(_quantityController.text),
          productId: productProvider.valueProduct!,
          deliveryType: orderProductProvider.valDeliveryType!,
          deliveryStatus: orderProductProvider.valDeliveryStatus)) {
        productProvider.setValueProduct(null);
        orderProductProvider.setDeliveryType('Delivery');
        orderProductProvider.setDeliveryStatus('Pending');
        // await Provider.of<OrderProductProvider>(context, listen: false)
        //     .fetchOrderProduct();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil Menambhakan data  Order Product ',
              style: textColor1.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal Menambhakan data Order Product Stock Tidak Mencukupi ',
              style: textColor1.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    add() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleCreateOrderProduct();
      }
    }

    PreferredSize getAppbar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: color3),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: color1,
          centerTitle: true,
          elevation: 1,
          title: Text(
            "Add Order Product",
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget getBody() {
      return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TypeAheadFormField(
                      noItemsFoundBuilder: (context) => SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('No Item Found'),
                        ),
                      ),
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        elevation: 4.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      debounceDuration: const Duration(milliseconds: 400),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _productController,
                        decoration: InputDecoration(
                          labelText: "Nama Product",
                          hintText: "Cari Product",
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await productProvider.products
                            .where((product) => product.name
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .map((product) =>
                                {'id': product.id, 'name': product.name})
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion['name'].toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        productProvider.setValueProduct(
                            int.parse(suggestion['id'].toString()));

                        _productController.text = suggestion['name'].toString();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _priceController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product Price cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Product Price",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _quantityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product Quantity cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Product Quantity",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      controller: _customerNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Customer Name cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Customer Name",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      controller: _customerAddresController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Customer Address cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Customer Address",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      controller: _customerPhoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Customer Phone cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Customer Phone",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      maxLines: null,
                      controller: _addressDetailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address Detail cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Address Detail",
                        hintStyle: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: color1,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Select Delivery Type"),
                        items: orderProductProvider.deliveryTypes
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        // items: productProvider.products
                        //     .map((e) => DropdownMenuItem(
                        //           child: Text(e.name),
                        //           value: e.id,
                        //         ))
                        //     .toList(),
                        onChanged: (newValue) {
                          orderProductProvider
                              .setDeliveryType(newValue.toString());
                          // productProvider.setValueProduct(
                          //   int.parse(
                          //     newValue.toString(),
                          //   ),
                          // );
                        },
                        value: orderProductProvider.valDeliveryType,
                      ),
                    ),
                  ),
                  roleId == '1'
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: color1,
                            border: Border.all(color: color5, width: 2),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Select Delivery Status"),
                              items: orderProductProvider.deliveryStatuses
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              // items: productProvider.products
                              //     .map((e) => DropdownMenuItem(
                              //           child: Text(e.name),
                              //           value: e.id,
                              //         ))
                              //     .toList(),
                              onChanged: (newValue) {
                                orderProductProvider
                                    .setDeliveryStatus(newValue.toString());
                                // productProvider.setValueProduct(
                                //   int.parse(
                                //     newValue.toString(),
                                //   ),
                                // );
                              },
                              value: orderProductProvider.valDeliveryStatus,
                            ),
                          ),
                        )
                      : SizedBox(),
                  isLoading
                      ? CircularProgressIndicator(
                          color: color4,
                        )
                      : GestureDetector(
                          onTap: add,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: color4,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Add Order Product",
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ));
    }

    return Scaffold(
      backgroundColor: color1,
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}
