import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:provider/provider.dart';

class CompletedMemberScreen extends StatefulWidget {
  const CompletedMemberScreen({super.key});

  @override
  State<CompletedMemberScreen> createState() => _CompletedMemberScreenState();
}

class _CompletedMemberScreenState extends State<CompletedMemberScreen> {
  String roleId = "0";
  String userId = "0";
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    roleId = await getRole();
    userId = await getUserId();
    await Provider.of<OrderProductProvider>(context, listen: false)
        .fetchOrderProductByUser(
      userId: int.parse(userId),
      deliveryStatus: 'delivered',
      perpage: 10,
      page: 1,
    );
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
                  'Alamat',
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
                .toList()),
      );
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: ListView(
          children: [
            Center(
              child: Text(
                'List Completed Order',
                style: textColor3.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Expanded(child: tableProductDelivered())
          ],
        ));
  }
}
