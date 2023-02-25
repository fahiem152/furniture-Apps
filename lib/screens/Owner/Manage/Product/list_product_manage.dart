import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/screens/Owner/Manage/Product/edit_product.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListProductManage extends StatefulWidget {
  const ListProductManage({super.key});

  @override
  State<ListProductManage> createState() => _ListProductManageState();
}

class _ListProductManageState extends State<ListProductManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context).products;
    return productList.length == 0
        ? Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GridView.count(
                    childAspectRatio: 0.6,
                    crossAxisCount: 2,
                    children: productList
                        .map((product) => CardProductOwner(product: product))
                        .toList()),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-product');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: color5,
                    ),
                    child: Icon(
                      Icons.add,
                      color: color1,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class CardProductOwner extends StatelessWidget {
  ProductModel product;
  CardProductOwner({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color1.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color3.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12
                // topLeft: Radius.circular(
                //   12,
                // ),
                // topRight: Radius.circular(
                //   12,
                // ),
                ),
            child: Image.network(
              product.urlImage,
              height: 100,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            product.name,
            maxLines: 2,
            style: textColor3.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
              letterSpacing: 1.5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'Price: ${product.price}',
            // 'Product: ${brand.product!.length} ',
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: reguler,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            'Stock: ${product.stock}',
            // 'Product: ${brand.product!.length} ',
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: reguler,
              letterSpacing: 1.5,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProduct(product: product)));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: color5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Hapus Role",
                        desc: 'Apakah Anda Yakin Ingin Menghapus Role "' +
                            // brand.name +
                            '" ?',
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Tidak",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: color4,
                          ),
                          DialogButton(
                            child: Text(
                              "Ya",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              await Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .deleteProduct(
                                      id: int.parse(product.id.toString()));
                              Navigator.pop(context);
                            },
                            color: color5,
                          )
                        ],
                      ).show();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: color4,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
