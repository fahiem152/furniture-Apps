import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:provider/provider.dart';

class DetailProductAdminScreen extends StatefulWidget {
  const DetailProductAdminScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<DetailProductAdminScreen> createState() =>
      _DetailProductAdminScreenState();
}

class _DetailProductAdminScreenState extends State<DetailProductAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BrandProvider>(context, listen: false).fetchBrand();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    BrandProvider brandProvider = Provider.of<BrandProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    print('Jumlah Brand ${brandProvider.brands.length} ');
    print('Jumlah Category ${categoryProvider.categorys.length} ');
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    widget.product.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 24,
                    color: color5,
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultMargin),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color5,
                    color6,
                  ],
                ),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(
                //     24,
                //   ),
                //   topRight: Radius.circular(
                //     24,
                //   ),
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      color: color1,
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    formatRupiah(widget.product.price),
                    style: TextStyle(
                      color: color1,
                      fontSize: 16,
                      fontWeight: reguler,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: color1,
                      fontSize: 16,
                      fontWeight: light,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'Category',
                          style: TextStyle(
                            color: color1,
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Brand',
                          style: TextStyle(
                            color: color1,
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              widget.product.category!.name,
                              style: TextStyle(
                                color: color1,
                                fontSize: 16,
                                fontWeight: reguler,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              widget.product.brand!.name,
                              style: TextStyle(
                                color: color1,
                                fontSize: 16,
                                fontWeight: reguler,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
