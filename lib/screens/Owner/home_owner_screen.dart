import 'package:flutter/material.dart';
import 'package:furniture/models/chart_model.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/chart_provider.dart';
import 'package:furniture/screens/Owner/Detail/category_detail.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeOwnerScreen extends StatefulWidget {
  const HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
  late DateTime startDate;
  late DateTime endDate;
  String name = '';
  String role = '';
  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = DateTime.now().subtract(const Duration(days: 7));
    _getData();
    loadInfoUser();
  }
  // _getData()

  _getData() async {
    await Provider.of<ChartProvider>(context, listen: false)
        .fetchChartOrderCategories(
      startDate: startDate.toString(),
      endDate: endDate.toString(),
      categoryId: 0,
    );
  }

  loadInfoUser() async {
    name = await getName();
    role = await getRole();
  }

  // List<Color> palette = const <Color>[
  //   Color.fromRGBO(75, 135, 185, 1),
  //   Color.fromRGBO(192, 108, 132, 1),
  //   Color.fromRGBO(246, 114, 128, 1),
  //   Color.fromRGBO(248, 177, 149, 1),
  //   Color.fromRGBO(116, 180, 155, 1),
  //   Color.fromRGBO(0, 168, 181, 1),
  //   Color.fromRGBO(73, 76, 162, 1),
  //   Color.fromRGBO(255, 205, 96, 1),
  //   Color.fromRGBO(255, 240, 219, 1),
  //   Color.fromRGBO(238, 238, 238, 1)
  // ];

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
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    ChartProvider chartProvider = Provider.of<ChartProvider>(context);

    Widget headerAdmin() {
      return Container(
        padding: EdgeInsets.all(16),
        // margin: EdgeInsets.all(-12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color6,
              color5,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // color: color5,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(60, 28),
            bottomRight: Radius.elliptical(60, 28),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color.fromRGBO(103, 80, 164, 0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                'assets/images/logo.jpg',
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: Text(
                    name == '' ? 'Name' : name,
                    style: textColor1.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Text(
                  role == ''
                      ? 'Role'
                      : role == '3'
                          ? 'Owner'
                          : 'Role Unknown',
                  style: textColor1.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                )
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () => AuthService().logout().then(
                    (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    ),
                  ),
              icon: Icon(
                Icons.exit_to_app,
              ),
              color: color4,
              iconSize: 30,
            )
          ],
        ),
      );
    }

    Widget chartByOrder() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color1,
            borderRadius: BorderRadius.circular(
              12,
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(
                    0,
                    4,
                  ),
                  blurRadius: 10,
                  color: Color.fromRGBO(
                    103,
                    80,
                    164,
                    0.1,
                  ))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Order By Category',
                  style: textColor3.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    _selectDateRange(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: color5,
                        // border: Border.all(
                        //   color: color5,
                        //   width: 2,
                        // ),
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Text(
                          startDate == endDate
                              ? DateFormat('yyyy-MM-dd').format(startDate)
                              : DateFormat('dd-MM-yyyy').format(startDate) +
                                  ' - ' +
                                  DateFormat('dd-MM-yyyy').format(endDate),
                          style: textColor1.copyWith(
                            fontSize: 10,
                            fontWeight: reguler,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: color1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            chartProvider.chartOrderCategories.length == 0
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
                          'Tidak Transaksi',
                          style: textColor3.copyWith(
                            fontSize: 14,
                            fontWeight: reguler,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                : SfCircularChart(
                    // title: ChartTitle(text: 'Sales by sales person'),
                    legend: Legend(isVisible: true),
                    series: <PieSeries<ChartOrderCategoriesModel, String>>[
                      PieSeries<ChartOrderCategoriesModel, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: chartProvider.chartOrderCategories,
                        xValueMapper: (ChartOrderCategoriesModel data, _) =>
                            data.name,
                        yValueMapper: (ChartOrderCategoriesModel data, _) =>
                            data.quantity,
                        dataLabelMapper: (ChartOrderCategoriesModel data, _) =>
                            data.persen! + '%',
                        dataLabelSettings: DataLabelSettings(
                          textStyle: textColor3.copyWith(
                            fontSize: 14,
                          ),
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
            // : SfCircularChart(
            //     // title: ChartTitle(text: 'Sales by sales person'),
            //     legend: Legend(isVisible: true),
            //     series: <PieSeries<ChartOrderCategoriesModel, String>>[
            //       PieSeries<ChartOrderCategoriesModel, String>(
            //         explode: true,
            //         explodeIndex: 1,
            //         dataSource: chartProvider.chartOrderCategories,
            //         xValueMapper: (ChartOrderCategoriesModel data, _) =>
            //             data.name,
            //         yValueMapper: (ChartOrderCategoriesModel data, _) =>
            //             data.quantity,
            //         dataLabelMapper: (ChartOrderCategoriesModel data, _) =>
            //             data.persen!.toString(),
            //         dataLabelSettings: DataLabelSettings(
            //           textStyle: textColor3.copyWith(
            //             fontSize: 12,
            //           ),
            //           isVisible: true,
            //         ),
            //       ),
            //     ],
            //   ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  // final categoryProvider =
                  //     Provider.of<CategoryProvider>(context, listen: false);
                  // categoryProvider.setValueCategory(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetail(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color4,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(
                              0,
                              4,
                            ),
                            blurRadius: 10,
                            color: Color.fromRGBO(
                              103,
                              80,
                              164,
                              0.1,
                            ))
                      ]),
                  child: Text('Detail',
                      style: textColor3.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                        letterSpacing: 1,
                      )),
                ),
              ),
            )
            // SingleChildScrollView(
            //   child: DataTable(
            //     border: TableBorder.all(width: 1, color: color1),
            //     dataRowHeight: 50,
            //     headingRowHeight: 40,
            //     headingRowColor: MaterialStateColor.resolveWith(
            //       (states) => color5,
            //     ),
            //     columns: <DataColumn>[
            //       DataColumn(
            //         label: Text(
            //           'Name',
            //           style: textColor1.copyWith(
            //             fontSize: 14,
            //             fontWeight: reguler,
            //           ),
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Quantity',
            //           style: textColor1.copyWith(
            //             fontSize: 14,
            //             fontWeight: reguler,
            //           ),
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           'Orders',
            //           style: textColor1.copyWith(
            //             fontSize: 14,
            //             fontWeight: reguler,
            //           ),
            //         ),
            //       ),
            //     ],
            //     rows: chartProvider.chartOrderCategories
            //         .map((e) => DataRow(cells: [
            //               DataCell(
            //                 Center(
            //                   child: Text(
            //                     e.name,
            //                     style: textColor3.copyWith(
            //                       fontSize: 12,
            //                       fontWeight: reguler,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               DataCell(
            //                 Center(
            //                   child: Text(
            //                     e.quantity.toString(),
            //                     style: textColor3.copyWith(
            //                       fontSize: 12,
            //                       fontWeight: reguler,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               DataCell(
            //                 Center(
            //                   child: Text(
            //                     e.orders!.length.toString(),
            //                     style: textColor3.copyWith(
            //                       fontSize: 12,
            //                       fontWeight: reguler,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ]))
            //         .toList(),
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget conten() {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            chartByOrder(),
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerAdmin(),
            conten(),
          ],
        ),
      ),
    );
  }
}
