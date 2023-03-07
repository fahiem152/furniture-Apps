import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditOrderProduct extends StatefulWidget {
  OrderProductModel orderProduct;
  int roleId;
  EditOrderProduct({
    super.key,
    required this.orderProduct,
    required this.roleId,
  });

  @override
  State<EditOrderProduct> createState() => _EditOrderProductState();
}

class _EditOrderProductState extends State<EditOrderProduct> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerAddresController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _addressDetailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    _priceController.text = widget.orderProduct.productPrice.toString();
    _quantityController.text = widget.orderProduct.quantity.toString();
    _customerNameController.text = widget.orderProduct.customerName;
    _customerAddresController.text = widget.orderProduct.customerAddres;
    _customerPhoneController.text = widget.orderProduct.customerPhone;
    _addressDetailController.text = widget.orderProduct.addressDetails;
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);

    handleUpdateOrderProduct() async {
      setState(() {
        isLoading = true;
      });
      if (productProvider.valueProduct == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await orderProductProvider.updateOrderProduct(
        productId: productProvider.valueProduct!,
        quantity: int.parse(_quantityController.text),
        productPrice: int.parse(_priceController.text),
        customerName: _customerNameController.text,
        customerAddres: _customerAddresController.text,
        customerPhone: _customerPhoneController.text,
        addressDetails: _addressDetailController.text,
        deliveryType: orderProductProvider.valDeliveryType!,
        deliveryStatus: orderProductProvider.valDeliveryStatus!,
        id: widget.orderProduct.id!,
      )) {
        await Provider.of<OrderProductProvider>(context, listen: false)
            .fetchOrderProduct();

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
        productProvider.setValueProduct(null);
        orderProductProvider.setDeliveryType(null);
        orderProductProvider.setDeliveryStatus(null);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal Edit data  Order Product ',
              style: textColor1.copyWith(
                fontSize: 16,
                fontWeight: reguler,
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

    edit() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleUpdateOrderProduct();
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
            "Edit Order Product",
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget editFormAdmin() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                hint: Text("Select Product"),
                style: textColor3.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
                items: productProvider.products
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e.id,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  productProvider.setValueProduct(
                    int.parse(
                      newValue.toString(),
                    ),
                  );
                },
                value: productProvider.valueProduct,
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
                  fontWeight: reguler,
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
                  fontWeight: reguler,
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
                  fontWeight: reguler,
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
                  fontWeight: reguler,
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
                  fontWeight: reguler,
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
                  fontWeight: reguler,
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
                style: textColor3.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
                items: orderProductProvider.deliveryTypes
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  orderProductProvider.setDeliveryType(newValue.toString());
                },
                value: orderProductProvider.valDeliveryType,
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
                hint: Text("Select Delivery Status"),
                style: textColor3.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
                items: orderProductProvider.deliveryStatuses
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  orderProductProvider.setDeliveryStatus(newValue.toString());
                },
                value: orderProductProvider.valDeliveryStatus,
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator(
                  color: color4,
                )
              : GestureDetector(
                  onTap: edit,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Edit Order Product",
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    Widget editFormKurir() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.product!.name,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.productPrice.toString(),
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.quantity.toString(),
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.customerName,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.customerAddres,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.customerPhone,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.addressDetails,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(12, 18, 12, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color1,
              border: Border.all(color: color5, width: 2),
            ),
            child: Text(
              widget.orderProduct.deliveryType!,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
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
                hint: Text("Select Delivery Status"),
                style: textColor3.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
                items: orderProductProvider.deliveryStatuses
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  orderProductProvider.setDeliveryStatus(newValue.toString());
                },
                value: orderProductProvider.valDeliveryStatus,
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator(
                  color: color4,
                )
              : GestureDetector(
                  onTap: edit,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Edit Order Product",
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    Widget getBody() {
      return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: widget.roleId == 1 ? editFormAdmin() : editFormKurir(),
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
