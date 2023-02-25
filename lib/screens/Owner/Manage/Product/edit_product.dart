import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  ProductModel product;
  EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _imgController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<BrandProvider>(context, listen: false).fetchBrand();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
    _nameController.text = widget.product.name;
    _descController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _imgController.text = widget.product.urlImage;
  }

  @override
  Widget build(BuildContext context) {
    final brandList = Provider.of<BrandProvider>(context).brands;
    final categoryList = Provider.of<CategoryProvider>(context).categorys;
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    BrandProvider brandProvider = Provider.of<BrandProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleUpdateProduct() async {
      setState(() {
        isLoading = true;
      });
      if (brandProvider.valueBrand == null &&
          categoryProvider.valueCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await productProvider.updateProduct(
        id: widget.product.id!,
        name: _nameController.text,
        description: _descController.text,
        price: int.parse(_priceController.text),
        urlImage: _imgController.text,
        brandId: brandProvider.valueBrand!,
        categoryId: categoryProvider.valueCategory!,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil Update Product'),
          ),
        );

        Navigator.pop(context);
        brandProvider.setValueBrand(null);
        categoryProvider.setValueCategory(null);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color5,
          content: Text(
            'Gagal Untuk Update Product',
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
        handleUpdateProduct();
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
            "Edit Product",
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
                          return "Product Name cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Product Name",
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
                      controller: _descController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product Description cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Product Description",
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
                      controller: _imgController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product Image cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Product image",
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
                        hint: Text("Select Brand"),
                        items: brandList
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e.id,
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          brandProvider.setValueBrand(
                            int.parse(
                              newValue.toString(),
                            ),
                          );
                        },
                        value: brandProvider.valueBrand,
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
                        hint: Text("Select Category"),
                        items: categoryList
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e.id,
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          categoryProvider.setValueCategory(
                            int.parse(
                              newValue.toString(),
                            ),
                          );
                        },
                        value: categoryProvider.valueCategory,
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
                                "Edit Product",
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
