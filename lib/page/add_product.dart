import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/services/category_services.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController(text: '');
  TextEditingController urlImageController = TextEditingController(text: '');
  TextEditingController categoryIdController = TextEditingController(text: '');
  TextEditingController brandIdController = TextEditingController(text: '');

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<CategoryProvider>(context, listen: false)
  //       .geCategorys(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  // }

  @override
  Widget build(BuildContext context) {
    // CategoryService category = CategoryService();
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    handleAddProduct() async {
      if (await productProvider.addProduct(
        name: nameController.text,
        description: descriptionController.text,
        price: int.parse(priceController.text),
        urlImage: urlImageController.text,
        categoryId: int.parse(categoryIdController.text),
        brandId: int.parse(brandIdController.text),
      )) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Gagal Untuk Register',
            textAlign: TextAlign.center,
          ),
        ));
      }
    }

    return Scaffold(
      backgroundColor: color2,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: color4,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Add New Product',
                    style: textColor4.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: nameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Name Product',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: descriptionController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Description Product',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: priceController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Price Product',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: urlImageController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Url Image Product',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: categoryIdController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Category Id',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  border: Border.all(
                    color: color4,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                  controller: brandIdController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Brand Id',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: handleAddProduct,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color4,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: textColor1.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
