import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/page/detail_category.dart';
import 'package:furniture/theme.dart';

class CardCategory extends StatelessWidget {
  final CategoryModel category;
  CardCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCategory(
                category: category,
              ),
            ));
      },
      child: Container(
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
              child: Image.network(
                category.category_img.toString(),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name.toString(),
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
                    category.product!.length != 0
                        ? category.product!.length.toString()
                        : 'Data Kosong',
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
