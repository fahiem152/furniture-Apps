import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_order_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class OrderMemberScreen extends StatefulWidget {
  const OrderMemberScreen({super.key});

  @override
  State<OrderMemberScreen> createState() => _OrderMemberScreenState();
}

class _OrderMemberScreenState extends State<OrderMemberScreen> {
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
      deliveryStatus: 'pending',
      perpage: 10,
      page: 1,
    );
    // await Provider.of<OrderProductProvider>(context, listen: false)
    //     .fetchOrderProductByUser(userId: int.parse(userId), );
    // await Provider.of<OrderProductProvider>(context, listen: false)
    // .fetchOrderProductByUser(userId: int.parse(userId), );
  }

  @override
  Widget build(BuildContext context) {
    OrderProductProvider orderProductProvider =
        Provider.of<OrderProductProvider>(context);
    print('userid: ' + userId);
    print('roleid: ' + roleId);
    Widget emptyOrder() {
      return Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.all(defaultMargin),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag,
              size: 50,
              color: color5,
            ),
            Text(
              'Oops! Your Cart is Empty',
              style: textColor3.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            Text(
              'Let\'s find your favorite product',
              style: textColor3.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add-order-product');
              },
              child: Text(
                'Order Now',
                style: textColor1.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                  letterSpacing: 2,
                ),
              ),
            )
          ],
        ),
      );
    }

    return orderProductProvider.orderProducts.length == 0
        ? emptyOrder()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: defaultMargin,
                      bottom: defaultMargin,
                    ),
                    child: Text(
                      'List Order Now',
                      style: textColor3.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/add-order-product');
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                          right: 12,
                          top: defaultMargin,
                          bottom: defaultMargin,
                        ),
                        width: 75,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                          color: color5,
                        ),
                        child: Center(
                          child: Text(
                            'Add Order',
                            style: textColor1.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              // Expanded(
              //     child: PagedListView<int, OrderProductModel>(
              //   pagingController: orderProductProvider.pagingController,
              //   builderDelegate: PagedChildBuilderDelegate<OrderProductModel>(
              //     itemBuilder: (context, item, index) => CardOrderWidget(
              //         orderProduct: item, roleId: int.parse(roleId)),
              //   ),
              // ))
              Expanded(
                  child: ListView.builder(
                      itemCount: orderProductProvider.orderProducts.length,
                      itemBuilder: (context, index) {
                        return CardOrderWidget(
                            orderProduct:
                                orderProductProvider.orderProducts[index],
                            roleId: int.parse(roleId));
                      }))
            ],
          );
  }
}
