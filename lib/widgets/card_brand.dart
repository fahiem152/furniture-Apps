import 'package:flutter/material.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/page/detail_brand.dart';
import 'package:furniture/page/detail_category.dart';
import 'package:furniture/theme.dart';

class CardBrand extends StatelessWidget {
  final BrandModel brand;
  CardBrand({required this.brand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailBrand(
                brand: brand,
              ),
            ));
      },
      child: Container(
        height: 75,
        padding: EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.symmetric(
          vertical: 12,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.circular(
            12,
          ),
          boxShadow: [
            BoxShadow(
              color: color3.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  brand.brand_img.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand.name.toString(),
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                ),
                Row(children: [
                  Text(
                    'Products: ',
                    style: textColor3.copyWith(
                      fontSize: 16,
                      fontWeight: reguler,
                    ),
                  ),
                  Text(
                    brand.product!.length != 0
                        ? brand.product!.length.toString()
                        : '0',
                    style: textColor3.copyWith(
                      fontSize: 16,
                      fontWeight: reguler,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
