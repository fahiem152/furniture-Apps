import 'package:flutter/material.dart';
import 'package:furniture/theme.dart';

class SupplayAdminScreen extends StatelessWidget {
  const SupplayAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getTableSupplay() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(width: 1, color: color1),
          dataRowHeight: 72,
          headingRowHeight: 30,
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => color5,
          ),
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'ID',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Supplier',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Tanggal',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Product',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Price',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Quantity',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Total Price',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Acition',
                style: textColor1.copyWith(
                  fontSize: 12,
                  fontWeight: reguler,
                ),
              ),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text("1"),
                ),
                DataCell(
                  Text("Atlanta"),
                ),
                DataCell(
                  Text("20-05-2022"),
                ),
                DataCell(
                  Text("Central 180"),
                ),
                DataCell(
                  Text("Rp. 1.250.000"),
                ),
                DataCell(
                  Text("2"),
                ),
                DataCell(
                  Text("Rp. 2.500.000"),
                ),
                DataCell(
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => color4,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(
                  Text("1"),
                ),
                DataCell(
                  Text("Atlanta"),
                ),
                DataCell(
                  Text("20-05-2022"),
                ),
                DataCell(
                  Text("Central 180"),
                ),
                DataCell(
                  Text("Rp. 1.250.000"),
                ),
                DataCell(
                  Text("2"),
                ),
                DataCell(
                  Text("Rp. 2.500.000"),
                ),
                DataCell(
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => color4,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
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
            child: getTableSupplay(),
          )
        ],
      ),
    );
  }
}
