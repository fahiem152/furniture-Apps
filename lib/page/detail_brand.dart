import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_detail_brand.dart';

class DetailBrand extends StatelessWidget {
  final BrandModel brand;
  DetailBrand({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: ListView(
          children: [
            Row(
              children: [
                Text(
                  'Brand ',
                  style: textColor1.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  brand.name.toString(),
                  style: textColor1.copyWith(fontSize: 24, fontWeight: bold),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Wrap(
                direction: Axis.horizontal,
                children: brand.product!
                    .map(
                      (data) => CardDetailBrand(
                        brand: brand,
                        data: data,
                      ),
                    )
                    .toList())
          ],
        ),
      ),
    );
  }
}
