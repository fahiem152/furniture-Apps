import 'package:flutter/material.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/order_admin_screen.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_order_widget.dart';

import 'package:provider/provider.dart';

class DeliverKurirScreen extends StatefulWidget {
  const DeliverKurirScreen({super.key});

  @override
  State<DeliverKurirScreen> createState() => _DeliverKurirScreenState();
}

class _DeliverKurirScreenState extends State<DeliverKurirScreen> {
  String roleId = "0";
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProductProvider>(context, listen: false)
        .fetchOrderProductByDeliveryTypeDeliveryStatus(
            deliveryType: 'delivery', deliveryStatus: 'pending');
    getRoleId();
  }

  void getRoleId() async {
    roleId = await getRole();
  }

  @override
  Widget build(BuildContext context) {
    print(" ini adalah role id:   ${roleId}");
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);
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
                  'List Product Delivery',
                  style: textColor3.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
            orderProductProvider.orderProducts.length == 0 && roleId == "0"
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: color5,
                    )),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: orderProductProvider.orderProducts.length,
                    itemBuilder: (context, index) {
                      return CardOrderWidget(
                        roleId: int.parse(roleId),
                        // isDetail: true,
                        // isEdit: false,
                        // isDelete: false,
                        orderProduct: orderProductProvider.orderProducts[index],
                      );
                    },
                  ))
          ],
        ));
  }
}
