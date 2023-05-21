import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CompletedOrderAdminScreen extends StatefulWidget {
  const CompletedOrderAdminScreen({super.key});

  @override
  State<CompletedOrderAdminScreen> createState() =>
      _CompletedOrderAdminScreenState();
}

class _CompletedOrderAdminScreenState extends State<CompletedOrderAdminScreen> {
  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime endDate = DateTime.now();
  TextEditingController tanggal = TextEditingController();
  int currentPage = 1;
  int perPage = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderProductProvider>(context, listen: false)
        .fetchOrderProductByDeliveryStatus(
      deliveryStatus: 'delivered',
      page: currentPage,
      perpage: perPage,
      startDate: startDate.toString(),
      endDate: endDate.toString(),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final intialDateRange = DateTimeRange(start: startDate, end: endDate);

    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDateRange != null) {
      setState(() {
        startDate = newDateRange.start;
        endDate = newDateRange.end;
      });
      Provider.of<OrderProductProvider>(context, listen: false)
          .fetchOrderProductByDeliveryStatus(
        deliveryStatus: 'delivered',
        page: currentPage,
        perpage: perPage,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(startDate);
    print(endDate);
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);
    print(
        "OrderProductList: ${orderProductProvider.orderProductsPage.totalPages}");
    print(
        "OrderProductdata: ${orderProductProvider.orderProductsPage.data.length}");
    print(currentPage);
    print(perPage);
    print(startDate);
    print(endDate);
    Widget getTableCompletedOrder() {
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
                  'Alamat Tujuan',
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
            rows: orderProductProvider.orderProductsPage.data
                .map((e) => DataRow(cells: [
                      DataCell(
                        Center(
                          child: Text(
                            formatWaktu(e.updatedAt!),
                            style: textColor3.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${e.user!.name}',
                            style: textColor3.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${e.product!.name}',
                            style: textColor3.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${e.quantity}',
                            style: textColor3.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${e.customerAddres}',
                            style: textColor3.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailOrderAdminScreen(
                                  orderProduct: e,
                                ),
                              ),
                            );
                            // Alert(
                            //     context: context,
                            //     // type: AlertType.warning,
                            //     title: "Informasi Order",
                            //     image: Image.network(
                            //         e.product!.urlImage.toString()),
                            //     content: Column(
                            //       children: [
                            //         Column(
                            //           children: [
                            //             Text(
                            //               '"${e.product!.name}", "${e.productPrice}", "${e.quantity}", "${e.totalPrice}"',
                            //             ),
                            //             // Text(
                            //             //   '"${e.cu}", "${e.productPrice}", "${e.quantity}", "${e.totalPrice}"',
                            //             // ),
                            //           ],
                            //         ),
                            //       ],
                            //     )
                            //     // buttons: [
                            //     //   DialogButton(
                            //     //     child: Text(
                            //     //       "Tidak",
                            //     //       style: TextStyle(
                            //     //           color: Colors.white, fontSize: 20),
                            //     //     ),
                            //     //     onPressed: () => Navigator.pop(context),
                            //     //     color: color4,
                            //     //   ),
                            //     //   DialogButton(
                            //     //     child: Text(
                            //     //       "Ya",
                            //     //       style: TextStyle(
                            //     //           color: Colors.white, fontSize: 20),
                            //     //     ),
                            //     //     onPressed: () async {
                            //     //       await Provider.of<RoleProvider>(context,
                            //     //               listen: false)
                            //     //           .deleteRole(
                            //     //               id: int.parse(roleList[index]
                            //     //                   .id
                            //     //                   .toString()));
                            //     //       Navigator.pop(context);
                            //     //     },
                            //     //     color: color5,
                            //     //   )
                            //     // ],
                            //     ).show();
                          },
                          child: Text(
                            'Detail',
                          ),
                        ),
                      ),
                    ]))
                .toList()),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.only(
                top: 20,
                bottom: 24,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completed Order',
                    style: textColor3.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _selectDateRange(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          startDate == endDate
                              ? DateFormat('yyyy-MM-dd').format(startDate)
                              : DateFormat('dd-MM-yyyy').format(startDate) +
                                  ' - ' +
                                  DateFormat('dd-MM-yyyy').format(endDate),
                          style: textColor3.copyWith(
                            fontSize: 12,
                            fontWeight: reguler,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: color5,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  // top: 20,
                  bottom: 24,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: orderProductProvider.orderProductsPage.data.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Range Tanggal',
                              style: textColor3.copyWith(
                                fontSize: 14,
                                fontWeight: reguler,
                                letterSpacing: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${DateFormat('dd-MM-yyyy').format(startDate)}',
                                  style: textColor5.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  ' Sampai ',
                                  style: textColor3.copyWith(
                                    fontSize: 14,
                                    fontWeight: reguler,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('dd-MM-yyyy').format(endDate)}',
                                  style: textColor5.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Data Tidak Tersedia',
                              style: textColor3.copyWith(
                                fontSize: 14,
                                fontWeight: reguler,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          getTableCompletedOrder(),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Pagination(
                              paginateButtonStyles: PaginateButtonStyles(
                                backgroundColor: color6,
                                activeBackgroundColor: color4,
                                activeTextStyle: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                ),
                                textStyle: textColor1.copyWith(
                                  fontSize: 12,
                                  fontWeight: reguler,
                                ),
                              ),
                              prevButtonStyles: PaginateSkipButton(
                                buttonBackgroundColor: color5,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              nextButtonStyles: PaginateSkipButton(
                                buttonBackgroundColor: color5,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              onPageChange: (number) {
                                setState(() {
                                  currentPage = number;
                                  print(currentPage);
                                  orderProductProvider
                                      .fetchOrderProductByDeliveryStatus(
                                    deliveryStatus: 'delivered',
                                    page: currentPage,
                                    perpage: perPage,
                                    startDate: startDate.toString(),
                                    endDate: endDate.toString(),
                                  );
                                  // fungsigetTabelStockOpnameFg(
                                  //     supplier: pilihSupplier.toString(),
                                  //     page: currentPage.toString());
                                });
                              },
                              useGroup: true,
                              totalPage: orderProductProvider
                                  .orderProductsPage.totalPages,
                              show: orderProductProvider
                                          .orderProductsPage.totalPages <
                                      6
                                  ? 1
                                  : 5,
                              currentPage: currentPage,
                            ),
                          )
                        ],
                      )
                // child: Column(
                //   children: orderProductProvider.orderProductsPage.data
                //       .map((e) => Text(e.quantity.toString()))
                //       .toList(),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
