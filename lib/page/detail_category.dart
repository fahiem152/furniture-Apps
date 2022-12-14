import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_detail_category.dart';

class DetailCategory extends StatelessWidget {
  final CategoryModel category;
  DetailCategory({required this.category});
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
                  'Category ',
                  style: textColor1.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  category.name.toString(),
                  style: textColor1.copyWith(fontSize: 24, fontWeight: bold),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: category.product!
                  .map((data) => CardDetailCategory(
                        category: category,
                        data: data,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
