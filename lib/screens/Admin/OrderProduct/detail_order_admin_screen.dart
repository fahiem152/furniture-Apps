import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/edit_order_product.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/utils/formatter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailOrderAdminScreen extends StatelessWidget {
  OrderProductModel orderProduct;
  DetailOrderAdminScreen({super.key, required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color1,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        orderProduct.product!.urlImage,
                        // fit: BoxFit.cover,
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
                Card(
                  color: color4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal Order ',
                          style: textColor3.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          formatWaktu(orderProduct.updatedAt!),
                          style: textColor1.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: color4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Informasi Product',
                            style: textColor3.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderProduct.product!.name,
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Quantity: ${orderProduct.quantity}',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Price: ' +
                                    formatRupiah(orderProduct.productPrice),
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Total Price: ' +
                                    formatRupiah(orderProduct.totalPrice!),
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Status Pemabayaran: Belum Dibayar',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Type Delevery: ${orderProduct.deliveryType}',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Status: ${orderProduct.deliveryStatus}',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: color4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Informasi Penerima',
                            style: textColor3.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderProduct.customerName,
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                orderProduct.customerAddres,
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Phone: ${orderProduct.customerPhone}',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                              Text(
                                'Detail Address: ${orderProduct.customerAddres}',
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: reguler,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultMargin,
                ),
              ],
            ),
          ),
        ));
  }
}
