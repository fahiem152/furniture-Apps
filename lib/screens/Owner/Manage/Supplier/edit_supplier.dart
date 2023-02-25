import 'package:flutter/material.dart';
import 'package:furniture/models/supplier_model.dart';
import 'package:furniture/providers/supplier_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditSupplier extends StatefulWidget {
  SupplierModel supplier;
  EditSupplier({super.key, required this.supplier});

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.supplier.name;
    _addressController.text = widget.supplier.address;
    _phoneController.text = widget.supplier.phone;
  }

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);

    handleUpdateSupplier() async {
      setState(() {
        isLoading = true;
      });
      if (await supplierProvider.updateSupplier(
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        id: widget.supplier.id!,
      )) {
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color5,
          content: Text(
            'Gagal Untuk Update Brand',
            style: textColor1.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ));
      }
      setState(() {
        isLoading = false;
      });
    }

    edit() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleUpdateSupplier();
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
            "Edit Supplier",
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
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color1,
                      border: Border.all(color: color5, width: 2),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Supplier Name cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Supplier Name",
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
                      controller: _addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Supllier Address cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Supllier Address",
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
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Supllier Phone cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Supllier Phone",
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
                          onTap: edit,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: color4,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Edit Brand",
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
