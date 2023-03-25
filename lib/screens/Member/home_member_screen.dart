import 'package:flutter/material.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:furniture/widgets/card_product_widget.dart';
import 'package:provider/provider.dart';

class HomeMemberScreen extends StatefulWidget {
  const HomeMemberScreen({super.key});

  @override
  State<HomeMemberScreen> createState() => _HomeMemberScreenState();
}

class _HomeMemberScreenState extends State<HomeMemberScreen> {
  String name = '';
  String role = '';
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    loadInfoUser();
  }

  loadInfoUser() async {
    name = await getName();
    role = await getRole();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    Widget headerScreen() {
      return Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/images/logo.jpg',
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Text(
                        name == '' ? 'Name' : name,
                        style: textColor1.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    Text(
                      role == ''
                          ? 'Role'
                          : role == '4'
                              ? 'Member'
                              : 'Role Unknown',
                      style: textColor1.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => AuthService().logout().then(
                        (value) => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false,
                        ),
                      ),
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                  color: color4,
                  iconSize: 30,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: color1.withOpacity(
                  0.5,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: color5,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      style: textColor3.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      // controller: searchTextController,
                      onChanged: (value) {
                        productProvider.searchText = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Name Product',
                        hintStyle: textColor1.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget conten() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color1,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              12,
            ),
            topRight: Radius.circular(
              12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              "Products",
              style: textColor3.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.6,
              children: productProvider.filteredProducts
                  .map((product) => CardProductWidget(product: product))
                  .toList(),
            )
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color5,
            color6,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerScreen(),
            conten(),
          ],
        ),
      ),
    );
  }
}
