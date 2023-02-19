import 'package:flutter/material.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditBrand extends StatefulWidget {
  BrandModel brand;
  EditBrand({super.key, required this.brand});

  @override
  State<EditBrand> createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imgController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.brand.name;
    _imgController.text = widget.brand.brandImg;
  }

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context);

    handleUpdateBrand() async {
      setState(() {
        isLoading = true;
      });
      if (await brandProvider.updateBrand(
        id: widget.brand.id!,
        name: _nameController.text,
        imgUrl: _imgController.text,
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
        handleUpdateBrand();
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
            "Edit Brand",
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
                        return "Brand Name cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Brand Name",
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
                    controller: _imgController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Brand Image cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Brand image",
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
          ));
    }

    return Scaffold(
      backgroundColor: color1,
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}
