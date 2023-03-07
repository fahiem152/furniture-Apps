import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
import 'package:furniture/screens/Admin/OrderProduct/edit_order_product.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_order_widget.dart';
import 'package:furniture/widgets/order_admin_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderAdminScreen extends StatefulWidget {
  const OrderAdminScreen({super.key});

  @override
  State<OrderAdminScreen> createState() => _OrderAdminScreenState();
}

class _OrderAdminScreenState extends State<OrderAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProductProvider>(context, listen: false)
        .fetchOrderProduct();
  }

  @override
  Widget build(BuildContext context) {
    final orderProductProvider = Provider.of<OrderProductProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Product',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'All',
                    style: TextStyle(
                      color: Color(0xff4169E1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderProductProvider.orderProducts.length,
                  itemBuilder: (context, index) {
                    return CardOrderWidget(
                      roleId: 1,
                      // isDetail: true,
                      // isEdit: true,
                      // isDelete: true,
                      orderProduct: orderProductProvider.orderProducts[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/add-order-product');
            },
            child: Container(
              margin: EdgeInsets.only(
                right: 16,
                bottom: 16,
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
    );
  }
}
