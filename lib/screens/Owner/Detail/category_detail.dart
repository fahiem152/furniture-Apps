import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/models/chart_model.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/chart_provider.dart';
import 'package:furniture/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  late DateTime startDate;
  late DateTime endDate;

  late int categoryId;
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = DateTime.now().subtract(const Duration(days: 7));

    categoryId = 0;

    _getData();
  }

  _getData() async {
    await Provider.of<ChartProvider>(context, listen: false)
        .fetchChartOrderCategories(
      startDate: startDate.toString(),
      endDate: endDate.toString(),
      categoryId: categoryId,
    );
    await Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    ChartProvider chartProvider = Provider.of<ChartProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    print(' Category List : ${categoryProvider.categorys}');
    List<CategoryModel> _categories = [
      CategoryModel(
        id: 0,
        name: 'All Category',
      ),
      ...categoryProvider.categorys,
    ];
    // print('categories baru ${_categories / [2].id} + ${_categories[2].name}');
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: Text(
                        'Category',
                        style: textColor3.copyWith(
                          fontSize: 12,
                          fontWeight: reguler,
                        ),
                      ),
                      items: _categories
                          .map((item) => DropdownMenuItem(
                                value: item.id,
                                child: Text(item.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          categoryId = newValue!;
                        });
                        print('category seteleh select: $categoryId');
                      },
                      value: categoryId),
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
                InkWell(
                  onTap: () async {
                    print('category: ${categoryId}');
                    print('startDate: ${startDate}');
                    print('endDate: ${endDate}');
                    if (categoryId != null &&
                        startDate != null &&
                        endDate != null) {
                      _getData();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please Select Category and Date',
                            style: textColor1.copyWith(
                              fontSize: 12,
                              fontWeight: reguler,
                            ),
                          ),
                          backgroundColor: color5,
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color5,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Filter',
                      style: textColor1.copyWith(
                        fontSize: 14,
                        fontWeight: reguler,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
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
                  ),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Chart',
                    style: textColor3.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Divider(
                  color: color5,
                  thickness: 2,
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
                    : categoryId == 0
                        ? SfCircularChart(
                            legend: Legend(isVisible: true),
                            series: <
                                PieSeries<ChartOrderCategoriesModel, String>>[
                              PieSeries<ChartOrderCategoriesModel, String>(
                                explode: true,
                                explodeIndex: 0,
                                dataSource: chartProvider.chartOrderCategories,
                                xValueMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        data.name,
                                yValueMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        data.quantity,
                                dataLabelMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        data.persen! + '%',
                                dataLabelSettings: DataLabelSettings(
                                  textStyle: textColor3.copyWith(
                                    fontSize: 14,
                                  ),
                                  isVisible: true,
                                ),
                              ),
                            ],
                          )
                        : SfCircularChart(
                            legend: Legend(isVisible: true),
                            series: <
                                PieSeries<ChartOrderCategoriesModel, String>>[
                              PieSeries<ChartOrderCategoriesModel, String>(
                                explode: true,
                                explodeIndex: 0,
                                dataSource: chartProvider.chartOrderCategories,
                                xValueMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        data.productId.toString(),
                                yValueMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        data.quantity,
                                dataLabelMapper:
                                    (ChartOrderCategoriesModel data, _) =>
                                        '100%',
                                dataLabelSettings: DataLabelSettings(
                                  textStyle: textColor3.copyWith(
                                    fontSize: 14,
                                  ),
                                  isVisible: true,
                                ),
                              ),
                            ],
                          )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
