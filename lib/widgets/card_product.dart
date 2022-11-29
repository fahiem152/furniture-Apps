import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/models/user_model.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/theme.dart';

class CardProduct extends StatelessWidget {
  final ProductModel product;
  CardProduct({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        8,
      ),
      padding: EdgeInsets.all(12),
      height: 200,
      // width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.urlImage.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            product.name.toString(),
            style: textColor3.copyWith(
              fontSize: 20,
              fontWeight: bold,
            ),
            maxLines: 2,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            product.price.toString(),
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: reguler,
            ),
          ),
        ],
      ),
    );
  }
}
