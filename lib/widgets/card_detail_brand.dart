import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/theme.dart';

class CardDetailBrand extends StatelessWidget {
  final BrandModel brand;
  final ListProductModel data;
  CardDetailBrand({
    required this.brand,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => DetailProduct(product)));
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.39,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  data.urlImage.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  data.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textColor3.copyWith(
                    fontSize: 12,
                    fontWeight: reguler,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                  top: 4,
                  bottom: 4,
                ),
                child: Text(
                  data.price.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textColor3.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
