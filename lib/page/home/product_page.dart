import 'package:flutter/material.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_product.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // print('Jumlah Product: ${productProvider.products.length}');
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(
        24,
      ),
      child: Stack(
        children: [
          productProvider.products.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridViewCount(),
          // GridViewCount(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/addproduct');
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  color: color4,
                ),
                child: Text(
                  'Add Product',
                  style: textColor1.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GridViewCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 12,
      childAspectRatio: 0.6,
      children: productProvider.products
          .map((product) => CardProduct(
                product: product,
              ))
          .toList(),
    );
  }
}
