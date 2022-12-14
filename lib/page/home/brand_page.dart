import 'package:flutter/material.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_brand.dart';
import 'package:provider/provider.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    BrandProvider brandProvider = Provider.of<BrandProvider>(context);
    print('Jumlah Brand: ${brandProvider.brands.length}');
    return Padding(
      padding: EdgeInsets.all(
        defaultMargin,
      ),
      child: ListView(
        children: [
          Text(
            'All Brand',
            style: textColor3.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          brandProvider.brands.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: brandProvider.brands
                      .map(
                        (brand) => CardBrand(brand: brand),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}
