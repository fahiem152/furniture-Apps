import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/screens/Owner/Manage/Category/edit_category.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListCategoryManage extends StatefulWidget {
  const ListCategoryManage({super.key});

  @override
  State<ListCategoryManage> createState() => _ListCategoryManageState();
}

class _ListCategoryManageState extends State<ListCategoryManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<CategoryProvider>(
      context,
    ).categorys;
    return categoryList.length == 0
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
                    children: categoryList
                        .map((category) => CardCategoyOwner(category: category))
                        .toList()),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-category');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
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

class CardCategoyOwner extends StatelessWidget {
  CardCategoyOwner({super.key, required this.category});
  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    print('product : ${category.product!.length}');
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
              category.categoryImg!,
              height: 100,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category.name,
            // brand.name.toString(),
            style: textColor3.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            'Product: ${category.product!.length} ',
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
                            builder: (context) => EditCategory(
                                  category: category,
                                )));
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
                          // brand.name +
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
                            await Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .deleteCategory(
                                    id: int.parse(category.id.toString()));
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
