import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import '../helpers/shimmer_helper.dart';
import '../my_theme.dart';
import 'aiz_image.dart';

class HomeBannerOne extends StatelessWidget {
  final HomePresenter? homeData;
  final BuildContext? context;

  const HomeBannerOne({Key? key, this.homeData, this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeData!.isBannerOneInitial &&
        homeData!.bannerOneImageList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (homeData!.bannerOneImageList.length > 0) {
      return Padding(
        padding: app_language_rtl.$!
            ? const EdgeInsets.only(right: 9.0)
            : const EdgeInsets.only(left: 9.0),
        child: CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: .46,
              initialPage: 0,
              padEnds: false,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                // setState(() {
                //   homeData.current_slider = index;
                // });
              }),
          items: homeData!.bannerOneImageList.map((i) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Width that CarouselSlider gives this child
      final double w = constraints.maxWidth;

      // Desired aspect-ratio (16:9) → h = w / (16/9)
      final double h = w / (16 / 9);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            width: w,
            height: h,
            child: InkWell(
              onTap: () {
                final url = i.url?.split(AppConfig.DOMAIN_PATH).last ?? '';
                GoRouter.of(context).go(url);
              },
              child: CachedNetworkImage(
                imageUrl: i.photo!,
                fit: BoxFit.cover,          // fills, crops top/bottom if needed
                placeholder: (_, __) => Container(color: Colors.grey[300]),
                errorWidget: (_, __, ___) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      );
    },
  );
}).toList(),

        ),
      );
    } else if (!homeData!.isBannerOneInitial &&
        homeData!.bannerOneImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }
}
