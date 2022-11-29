import 'package:flutter/material.dart';
import 'package:furniture/providers/product_provider.dart';
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
    print('Jumlah Product: ${productProvider.products.length}');
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(
        24,
      ),
      child: GridViewCount(),
    );
    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    //   return Container(
    //     width: MediaQuery.of(context).size.width,
    //     margin: EdgeInsets.all(
    //       24,
    //     ),
    //     child: GridViewCount(),
    //   );
    // });
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
