import 'package:flutter/material.dart';

import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/search_provider.dart';
import 'package:furniture/screens/Admin/widgets/card_product_admin_widgets.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';

import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  TextEditingController searchTextController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    // Provider.of<CategoryProvider>(context, listen: false).geCategorys();
    // Provider.of<BrandProvider>(context, listen: false).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // final searchProvider = Provider.of<SearchProvider>(context);

    print('jumbalh product: ${productProvider.products.length}');

    Widget headerAdmin() {
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
                    Text(
                      'Reza Adi Syahputra',
                      style: textColor1.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Admin',
                      style: textColor1.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: IconButton(
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
                  ),
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
              childAspectRatio: 0.7,
              children: productProvider.filteredProducts
                  .map((product) => CardProductAdminWidget(product: product))
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
            headerAdmin(),
            conten(),
          ],
        ),
      ),
    );
  }
}
