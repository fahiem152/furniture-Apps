import 'package:flutter/material.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:provider/provider.dart';

class DeliveredKurirScreen extends StatefulWidget {
  const DeliveredKurirScreen({super.key});

  @override
  State<DeliveredKurirScreen> createState() => _DeliveredKurirScreenState();
}

class _DeliveredKurirScreenState extends State<DeliveredKurirScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProductProvider>(context, listen: false)
        .fetchOrderProductByDeliveryTypeDeliveryStatus(
            deliveryType: 'delivery', deliveryStatus: 'delivered');
  }

  @override
  Widget build(BuildContext context) {
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);
    Widget tableProductDelivered() {
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
                  'Nama Pemesan',
                  style: textColor1.copyWith(
                    fontSize: 16,
                    fontWeight: reguler,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Alamat Pemesan',
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
                  'Quantity',
                  style: textColor1.copyWith(
                    fontSize: 16,
                    fontWeight: reguler,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Action',
                  style: textColor1.copyWith(
                    fontSize: 16,
                    fontWeight: reguler,
                  ),
                ),
              ),
            ],
            rows: orderProductProvider.orderProducts
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
                          e.user != null && e.user!.name != null
                              ? e.user!.name
                              : 'undefined',
                          style: textColor3.copyWith(
                            fontSize: 14,
                            fontWeight: reguler,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          e.customerAddres != null
                              ? e.customerAddres
                              : 'undefined',
                          style: textColor3.copyWith(
                            fontSize: 14,
                            fontWeight: reguler,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          e.product != null && e.product!.name != null
                              ? e.product!.name
                              : 'undefined',
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailOrderAdminScreen(
                                orderProduct: e,
                              );
                            }));
                          },
                          child: Text(
                            'Detail',
                            style: textColor1.copyWith(
                              fontSize: 14,
                              fontWeight: reguler,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: color4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ]))
                .toList()
            // rows: supplayProductList
            //     .map((e) => DataRow(cells: [
            //           DataCell(
            //             Text(
            //               formatWaktu(e.updatedAt!),
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Text(
            //               e.supplier != null && e.supplier!.name != null
            //                   ? e.supplier!.name
            //                   : 'undefined',
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Text(
            //               e.product != null && e.supplier!.name != null
            //                   ? e.product!.name
            //                   : 'undefined',
            //               // e.product!.name,
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Text(
            //               e.price.toString(),
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Text(
            //               e.quantity.toString(),
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Text(
            //               e.totalPrice.toString(),
            //               style: textColor3.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: reguler,
            //               ),
            //             ),
            //           ),
            //           DataCell(
            //             Row(
            //               children: [
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     final productProvider =
            //                         Provider.of<ProductProvider>(
            //                       context,
            //                       listen: false,
            //                     );
            //                     final supplierProvider =
            //                         Provider.of<SupplierProvider>(
            //                       context,
            //                       listen: false,
            //                     );
            //                     productProvider.setValueProduct(e.product!.id);
            //                     supplierProvider.setValueSupplier(e.supplier!.id);
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => EditSupplayProduct(
            //                           supplayProduct: e,
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                   child: Text(
            //                     'Edit',
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 8,
            //                 ),
            //                 ElevatedButton(
            //                   style: ButtonStyle(
            //                     backgroundColor:
            //                         MaterialStateProperty.resolveWith(
            //                       (states) => color4,
            //                     ),
            //                   ),
            //                   onPressed: () {
            //                     Alert(
            //                       context: context,
            //                       type: AlertType.warning,
            //                       title: "Hapus Data Supplay Product",
            //                       desc:
            //                           'Apakah Anda Yakin Ingin Menghapus Data Supplay Product "' +
            //                               e.product!.name +
            //                               '" ' +
            //                               "Dari Supplier " +
            //                               '"' +
            //                               e.supplier!.name +
            //                               '" ?',
            //                       buttons: [
            //                         DialogButton(
            //                           child: Text(
            //                             "Tidak",
            //                             style: TextStyle(
            //                                 color: Colors.white, fontSize: 20),
            //                           ),
            //                           onPressed: () => Navigator.pop(context),
            //                           color: color4,
            //                         ),
            //                         DialogButton(
            //                           child: Text(
            //                             "Ya",
            //                             style: TextStyle(
            //                                 color: Colors.white, fontSize: 20),
            //                           ),
            //                           onPressed: () async {
            //                             await Provider.of<SupplayProductProvider>(
            //                                     context,
            //                                     listen: false)
            //                                 .deleteSupplayProduct(
            //                                     id: int.parse(e.id.toString()));
            //                             Navigator.pop(context);
            //                           },
            //                           color: color5,
            //                         )
            //                       ],
            //                     ).show();
            //                   },
            //                   child: Text(
            //                     'Delete',
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ]))
            //     .toList(),
            ),
      );
    }

    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: defaultMargin,
              ),
              child: Center(
                child: Text(
                  'Table Product Delivered',
                  style: textColor3.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
            Expanded(child: tableProductDelivered()),
            // orderProductProvider.orderProducts.length == 0 && roleId == "0"
            //     ? Expanded(
            //         child: Center(
            //             child: CircularProgressIndicator(
            //           color: color5,
            //         )),
            //       )
            //     : Expanded(
            //         child: ListView.builder(
            //         itemCount: orderProductProvider.orderProducts.length,
            //         itemBuilder: (context, index) {
            //           return CardOrderWidget(
            //             roleId: int.parse(roleId),
            //             // isDetail: true,
            //             // isEdit: false,
            //             // isDelete: false,
            //             orderProduct: orderProductProvider.orderProducts[index],
            //           );
            //         },
            //       ))
          ],
        ));
  }
}
