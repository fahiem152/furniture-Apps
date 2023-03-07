import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/screens/Admin/detail_product_admin_screen.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailProductAdminScreen(product: product)));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color1.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color3.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Image.network(
                product.urlImage,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              product.name,
              maxLines: 1,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: medium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Stock: ${product.stock}',
              maxLines: 1,
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              formatRupiah(product.price),
              maxLines: 1,
              style: textColor5.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
