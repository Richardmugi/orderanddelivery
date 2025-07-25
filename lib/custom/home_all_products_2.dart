import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../helpers/shimmer_helper.dart';
import '../ui_elements/product_card.dart';

class HomeAllProducts2 extends StatelessWidget {
  final BuildContext? context;
  final HomePresenter? homeData;
  const HomeAllProducts2({
    Key? key,
    this.context,
    this.homeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeData!.isAllProductInitial) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: homeData!.allProductScrollController));
    } else if (homeData!.allProductList.length > 0) {
      return GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 14,
  mainAxisSpacing: 14,
  childAspectRatio: 0.4, // Adjust to get desired height/width
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 18, right: 18),
  children: List.generate(homeData!.allProductList.length, (index) {
    var product = homeData!.allProductList[index];
    return ProductCard(
      id: product.id,
      slug: product.slug,
      image: product.thumbnail_image,
      name: product.name,
      main_price: product.main_price,
      stroked_price: product.stroked_price,
      has_discount: product.has_discount,
      discount: product.discount,
      is_wholesale: product.isWholesale,
    );
  }),
);
    } else if (homeData!.totalAllProductData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context)!.no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }
}
