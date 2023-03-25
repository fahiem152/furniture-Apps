import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
import 'package:furniture/screens/Admin/OrderProduct/edit_order_product.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CardOrderWidget extends StatelessWidget {
  OrderProductModel orderProduct;
  // bool isDelete = true;
  // bool isEdit = true;
  // bool isDetail = true;
  int roleId;

  // getRoleId() async {
  //   String roleId = await getRole();
  //   // String role = await StorageService.getRole();
  //   // if(role == 'admin'){
  //   //   isDelete = true;
  //   //   isEdit = true;
  //   //   isDetail = true;
  //   // }else if(role == 'kurir'){
  //   //   isDelete = false;
  //   //   isEdit = false;
  //   //   isDetail = true;
  //   // }else{
  //   //   isDelete = false;
  //   //   isEdit = false;
  //   //   isDetail = false;
  //   // }
  // }

  CardOrderWidget({
    super.key,
    required this.orderProduct,
    // required this.isDelete,
    // required this.isEdit,
    // required this.isDetail,
    required this.roleId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultMargin, left: 12, right: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color5.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: color2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        orderProduct.product != null
                            // orderProduct.product!.urlImage != null &&
                            //         orderProduct.product!.urlImage != ''
                            ? orderProduct.product!.urlImage
                            : 'https://p-id.ipricegroup.com/uploaded_05c89a7d0eb7e5535bbd31ec7db91d99.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        orderProduct.customerName,
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        orderProduct.customerAddres,
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: reguler,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        orderProduct.product != null
                            ? orderProduct.product!.name
                            : 'Product Name',
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: reguler,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${orderProduct.quantity != null ? orderProduct.quantity : 1.toString()} Produk',
                        style: textColor3.copyWith(
                          fontSize: 16,
                          fontWeight: reguler,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // roleId == 1
              // ?
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color5),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  final productProvider = Provider.of<ProductProvider>(
                    context,
                    listen: false,
                  );
                  final orderProvider = Provider.of<OrderProductProvider>(
                    context,
                    listen: false,
                  );
                  productProvider.setValueProduct(
                    orderProduct.product!.id,
                  );
                  orderProvider.setDeliveryType(
                    orderProduct.deliveryType,
                  );
                  orderProvider.setDeliveryStatus(
                    orderProduct.deliveryStatus!,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditOrderProduct(
                        orderProduct: orderProduct,
                        roleId: roleId,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Center(
                    child: Text(
                      'Edit',
                      style: textColor1.copyWith(
                        fontSize: 16,
                        fontWeight: reguler,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              // : Container(),
              roleId == 1 || roleId == 4
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => color7),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Hapus Order Product",
                          desc:
                              'Apakah Anda Yakin Ingin Menghapus Order Product "' +
                                  orderProduct.product!.name +
                                  '" ' +
                                  "Atas Nama " +
                                  '"' +
                                  orderProduct.customerName +
                                  '" ?',
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Tidak",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: color4,
                            ),
                            DialogButton(
                              child: Text(
                                "Ya",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                await Provider.of<OrderProductProvider>(context,
                                        listen: false)
                                    .deleteOrderProduct(
                                        id: int.parse(
                                            orderProduct.id.toString()));
                                Navigator.pop(context);
                              },
                              color: color5,
                            )
                          ],
                        ).show();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Center(
                          child: Text(
                            'Delete',
                            style: textColor1.copyWith(
                              fontSize: 16,
                              fontWeight: reguler,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              // roleId == 1
              //     ?
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color4),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailOrderAdminScreen(
                                orderProduct: orderProduct,
                              )));
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Center(
                    child: Text(
                      'Detail',
                      style: textColor1.copyWith(
                        fontSize: 16,
                        fontWeight: reguler,
                      ),
                    ),
                  ),
                ),
              )
              // : Container(),
            ],
          )
        ],
      ),
    );
  }
}
