import 'package:flutter/material.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_category.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    print('Jumlah Category: ${categoryProvider.categorys.length}');
    return Padding(
      padding: EdgeInsets.all(
        defaultMargin,
      ),
      child: ListView(
        children: [
          Text(
            'All Category',
            style: textColor3.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          categoryProvider.categorys.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: categoryProvider.categorys
                      .map(
                        (category) => CardCategory(
                          category: category,
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}
