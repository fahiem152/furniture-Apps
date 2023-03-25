import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  CategoryModel category;
  EditCategory({super.key, required this.category});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imgController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category.name;
    _imgController.text = widget.category.categoryImg!;
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    handleUpdateCategory() async {
      setState(() {
        isLoading = true;
      });
      if (await categoryProvider.updateCategory(
        id: widget.category.id!,
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
            'Gagal Untuk Update Category',
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
        handleUpdateCategory();
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
            "Edit Category",
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
                        return "Category Name cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Category Name",
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
                        return "Category Image cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Category image",
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
                              "Edit Category",
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
