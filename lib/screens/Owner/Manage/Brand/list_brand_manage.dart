import 'package:flutter/material.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/screens/Owner/Manage/Brand/edit-brand.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListBrandManage extends StatefulWidget {
  const ListBrandManage({super.key});

  @override
  State<ListBrandManage> createState() => _ListBrandManageState();
}

class _ListBrandManageState extends State<ListBrandManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BrandProvider>(context, listen: false).fetchBrand();
  }

  @override
  Widget build(BuildContext context) {
    final brandList = Provider.of<BrandProvider>(context).brands;
    print(brandList.length.toString());
    return brandList.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GridView.count(
                    childAspectRatio: 0.75,
                    crossAxisCount: 2,
                    children: brandList
                        .map((brand) => CardBrandOwner(brand: brand))
                        .toList()),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-brand');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
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
              )
            ],
          );
  }
}

class CardBrandOwner extends StatelessWidget {
  BrandModel brand;
  CardBrandOwner({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    // final brandProvider = Provider.of<BrandProvider>(context);
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color1.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12
                // topLeft: Radius.circular(
                //   12,
                // ),
                // topRight: Radius.circular(
                //   12,
                // ),
                ),
            child: Image.network(
              brand.brandImg,
              height: 100,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            brand.name.toString(),
            style: textColor3.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            'Product: ${brand.product!.length} ',
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: reguler,
              letterSpacing: 1.5,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBrand(brand: brand)));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: color5,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Hapus Role",
                      desc: 'Apakah Anda Yakin Ingin Menghapus Role "' +
                          brand.name +
                          '" ?',
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Tidak",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: color4,
                        ),
                        DialogButton(
                          child: Text(
                            "Ya",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            await Provider.of<BrandProvider>(context,
                                    listen: false)
                                .deleteBrand(
                                    id: int.parse(brand.id.toString()));
                            Navigator.pop(context);
                          },
                          color: color5,
                        )
                      ],
                    ).show();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: color4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
