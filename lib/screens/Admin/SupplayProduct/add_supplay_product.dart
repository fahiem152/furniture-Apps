import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/supplay_product_provider.dart';
import 'package:furniture/providers/supplier_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddSupplayProduct extends StatefulWidget {
  const AddSupplayProduct({super.key});

  @override
  State<AddSupplayProduct> createState() => _AddSupplayProductState();
}

class _AddSupplayProductState extends State<AddSupplayProduct> {
  final _formKey = GlobalKey<FormState>();
  // final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _productController = TextEditingController();
  final _supplierController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<SupplierProvider>(context, listen: false).fetchSupplier();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    SupplierProvider supplierProvider = Provider.of<SupplierProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    SupplayProductProvider supplayProductProvider =
        Provider.of<SupplayProductProvider>(context);

    print("Product :  ${productProvider.products.length}");
    print("Supplier :  ${supplierProvider.suppliers.length}");

    // getInt() async {
    //   await Provider.of<SupplayProductProvider>(context, listen: false)
    //       .fetchSupplayProduct();
    //   Navigator.pop(context);
    // }

    handleCreateSupplayProduct() async {
      setState(() {
        isLoading = true;
      });
      if (productProvider.valueProduct == null &&
          supplierProvider.valueSupplier == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await supplayProductProvider.createSupplayProduct(
        price: int.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        productId: productProvider.valueProduct!,
        supplierId: supplierProvider.valueSupplier!,
      )) {
        productProvider.setValueProduct(null);
        supplierProvider.setValueSupplier(null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil Menambhakan data  Supplay Product ',
              style: textColor1.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        await Provider.of<SupplayProductProvider>(context, listen: false)
            .fetchSupplayProduct();

        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal Menambhakan data  Supplay Product ',
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
        handleCreateSupplayProduct();
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
            "Add Supplay Product",
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
                        controller: _supplierController,
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

                        _supplierController.text =
                            suggestion['name'].toString();
                      },
                    ),
                  ),
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
                          child: Text('No Supplier Found'),
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
                          labelText: "Nama Supplier",
                          hintText: "Cari Supplier",
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await supplierProvider.suppliers
                            .where((supplier) => supplier.name
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .map((supplier) =>
                                {'id': supplier.id, 'name': supplier.name})
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion['name'].toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        supplierProvider.setValueSupplier(
                            int.parse(suggestion['id'].toString()));

                        _productController.text = suggestion['name'].toString();
                      },
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(bottom: 16),
                  //   padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: color1,
                  //     border: Border.all(color: color5, width: 2),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton(
                  //       hint: Text("Select Product"),
                  //       items: productProvider.products
                  //           .map((e) => DropdownMenuItem(
                  //                 child: Text(e.name!),
                  //                 value: e.id,
                  //               ))
                  //           .toList(),
                  //       onChanged: (newValue) {
                  //         productProvider.setValueProduct(
                  //           int.parse(
                  //             newValue.toString(),
                  //           ),
                  //         );
                  //       },
                  //       value: productProvider.valueProduct,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(bottom: 16),
                  //   padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: color1,
                  //     border: Border.all(color: color5, width: 2),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton(
                  //       hint: Text("Select Supplier"),
                  //       items: supplierProvider.suppliers
                  //           .map((e) => DropdownMenuItem(
                  //                 child: Text(e.name),
                  //                 value: e.id,
                  //               ))
                  //           .toList(),
                  //       onChanged: (newValue) {
                  //         supplierProvider.setValueSupplier(
                  //           int.parse(
                  //             newValue.toString(),
                  //           ),
                  //         );
                  //       },
                  //       value: supplierProvider.valueSupplier,
                  //     ),
                  //   ),
                  // ),
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
                    margin: EdgeInsets.only(bottom: defaultMargin),
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
                                "Add Supplay Product",
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
