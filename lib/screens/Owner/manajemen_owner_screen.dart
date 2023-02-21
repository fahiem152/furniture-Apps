import 'package:flutter/material.dart';
import 'package:furniture/screens/Owner/Manage/Brand/list_brand_manage.dart';
import 'package:furniture/screens/Owner/Manage/Category/list_category_manage.dart';
import 'package:furniture/screens/Owner/Manage/Role/list_role_manage.dart';
import 'package:furniture/screens/Owner/Manage/User/list_user_manage.dart';
import 'package:furniture/screens/Owner/Manage/UserRole/list_user_role_manage.dart';
import 'package:furniture/screens/Owner/Manage/list_product_manage.dart';
import 'package:furniture/theme.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class ManajemenOwnerScreen extends StatelessWidget {
  const ManajemenOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getBody() {
      return SingleChildScrollView(
          child: Container(
        color: color1,
        padding: EdgeInsets.all(defaultMargin),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listBodyManageOwner.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 14,
          ),
          itemBuilder: (context, index) => BodyManageOwner(
            tap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailManageOwner(
                    listBodyManageOwner: listBodyManageOwner[index],
                    index: index,
                  ),
                ),
              );
              print(index);
            },
            listBodyManageOwner: listBodyManageOwner[index],
          ),
        ),
      ));
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text(
              "Manage Furniture Apps",
              style: textColor3.copyWith(fontSize: 20, fontWeight: semiBold),
            ),
          ),
          Expanded(child: getBody())
        ],
      ),
    );
  }
}

class BodyManageOwner extends StatelessWidget {
  final ListBodyManageOwner listBodyManageOwner;
  final VoidCallback tap;
  const BodyManageOwner({
    super.key,
    required this.listBodyManageOwner,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color1,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  listBodyManageOwner.title,
                  style: textColor3.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  listBodyManageOwner.image,
                  width: 90,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListBodyManageOwner {
  final String title;
  final String image;
  ListBodyManageOwner({
    required this.title,
    required this.image,
  });
}

List<ListBodyManageOwner> listBodyManageOwner = [
  ListBodyManageOwner(
    title: "Manage Users",
    image: 'assets/images/logo-user.png',
  ),
  ListBodyManageOwner(
    title: "Manage Roles",
    image: 'assets/images/logo-role.png',
  ),
  ListBodyManageOwner(
    title: "Manage Users Roles ",
    image: 'assets/images/logo-user-role.png',
  ),
  ListBodyManageOwner(
    title: "Manage Brands",
    image: 'assets/images/logo-brand.png',
  ),
  ListBodyManageOwner(
    title: "Manage Categories",
    image: 'assets/images/logo-category.png',
  ),
  ListBodyManageOwner(
    title: "Manage products",
    image: 'assets/images/logo-product.png',
  ),
];

class DetailManageOwner extends StatefulWidget {
  final ListBodyManageOwner listBodyManageOwner;
  final int index;
  const DetailManageOwner({
    super.key,
    required this.listBodyManageOwner,
    required this.index,
  });

  @override
  State<DetailManageOwner> createState() => _DetailManageOwnerState();
}

class _DetailManageOwnerState extends State<DetailManageOwner> {
  // Appbar
  PreferredSize getAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: color3),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: color1,
        centerTitle: true,
        elevation: 1,
        title: Text(
          widget.listBodyManageOwner.title,
          style: textColor3.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  // Body
  Widget getBody() {
    return LazyLoadIndexedStack(
      index: widget.index,
      children: const [
        ListUserManage(),
        ListRoleManage(),
        ListUserRoleManage(),
        ListBrandManage(),
        ListCategoryManage(),
        ListProductManage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}
