import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/models/user_model.dart';
import 'package:furniture/page/detail_product.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/theme.dart';

class CardProduct extends StatefulWidget {
  final ProductModel product;
  CardProduct({required this.product});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProduct(widget.product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(
          8,
        ),
        padding: EdgeInsets.all(12),
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12,
            ),
            boxShadow: [
              BoxShadow(
                color: color3,
                offset: Offset(1, 1),
                blurRadius: 2.0,
                spreadRadius: 0.5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.product.urlImage.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.product.name.toString(),
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
              'Rp. ${widget.product.price.toString()}',
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: reguler,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
