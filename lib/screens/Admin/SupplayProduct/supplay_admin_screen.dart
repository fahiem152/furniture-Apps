import 'package:flutter/material.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/supplay_product_provider.dart';
import 'package:furniture/providers/supplier_provider.dart';
import 'package:furniture/screens/Admin/SupplayProduct/edit_supplay_product.dart';
import 'package:furniture/screens/Owner/Manage/Supplier/edit_supplier.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SupplayAdminScreen extends StatefulWidget {
  const SupplayAdminScreen({super.key});

  @override
  State<SupplayAdminScreen> createState() => _SupplayAdminScreenState();
}

class _SupplayAdminScreenState extends State<SupplayAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SupplayProductProvider>(context, listen: false)
        .fetchSupplayProduct();
  }

  @override
  Widget build(BuildContext context) {
    final supplayProductList =
        Provider.of<SupplayProductProvider>(context).supplayProducts;
    print("SupplaProduct: ${supplayProductList.length}");

    Widget getTableSupplay() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(width: 1, color: color1),
          dataRowHeight: 72,
          headingRowHeight: 40,
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => color5,
          ),
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Tanggal',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Supplier',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Product',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Price',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Quantity',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Total Price',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Acition',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: reguler,
                ),
              ),
            ),
          ],
          rows: supplayProductList
              .map((e) => DataRow(cells: [
                    DataCell(
                      Text(
                        formatWaktu(e.updatedAt!),
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e.supplier != null && e.supplier!.name != null
                            ? e.supplier!.name
                            : 'undefined',
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e.product != null && e.supplier!.name != null
                            ? e.product!.name
                            : 'undefined',
                        // e.product!.name,
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e.price.toString(),
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e.quantity.toString(),
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e.totalPrice.toString(),
                        style: textColor3.copyWith(
                          fontSize: 14,
                          fontWeight: reguler,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final productProvider =
                                  Provider.of<ProductProvider>(
                                context,
                                listen: false,
                              );
                              final supplierProvider =
                                  Provider.of<SupplierProvider>(
                                context,
                                listen: false,
                              );
                              productProvider.setValueProduct(e.product!.id);
                              supplierProvider.setValueSupplier(e.supplier!.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditSupplayProduct(
                                    supplayProduct: e,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Edit',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => color4,
                              ),
                            ),
                            onPressed: () {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Hapus Data Supplay Product",
                                desc:
                                    'Apakah Anda Yakin Ingin Menghapus Data Supplay Product "' +
                                        e.product!.name +
                                        '" ' +
                                        "Dari Supplier " +
                                        '"' +
                                        e.supplier!.name +
                                        '" ?',
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Tidak",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: color4,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Ya",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      await Provider.of<SupplayProductProvider>(
                                              context,
                                              listen: false)
                                          .deleteSupplayProduct(
                                              id: int.parse(e.id.toString()));
                                      Navigator.pop(context);
                                    },
                                    color: color5,
                                  )
                                ],
                              ).show();
                            },
                            child: Text(
                              'Delete',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))
              .toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Supplay Admin Screen',
                    style: textColor3.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 16,
                  ),
                  child: supplayProductList.length == 0
                      ? Center(
                          child: Text(
                            'Data Kosong',
                            style: textColor3.copyWith(
                              fontSize: 16,
                              fontWeight: reguler,
                            ),
                          ),
                        )
                      : getTableSupplay(),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/add-supplay-product');
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 12,
                ),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  color: color5,
                ),
                child: Icon(
                  Icons.add,
                  color: color1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
