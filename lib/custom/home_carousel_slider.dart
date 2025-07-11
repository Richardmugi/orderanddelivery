import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../app_config.dart';
import '../helpers/shimmer_helper.dart';
import '../my_theme.dart';
import '../presenter/home_presenter.dart';
import 'aiz_image.dart';

class HomeCarouselSlider extends StatelessWidget {
  final HomePresenter? homeData;
  final BuildContext? context;

  const HomeCarouselSlider({
    Key? key,
    this.homeData,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeData!.isCarouselInitial && homeData!.carouselImageList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
        child: ShimmerHelper().buildBasicShimmer(height: 140),
      );
    } else if (homeData!.carouselImageList.isNotEmpty) {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 580 / 150, // Try 16/9 or 3/2 if still too tall
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInExpo,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                homeData!.incrementCurrentSlider(index);
              },
            ),
            items: homeData!.carouselImageList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        onTap: () {
                          var url =
                              i.url?.split(AppConfig.DOMAIN_PATH).last ?? "";
                          print(url);
                          GoRouter.of(context).go(url);
                        },
                        child: Container(
                          width: double.infinity,
                          //height: 400,
                          child: AIZImage.radiusImage(i.photo ?? '', 0,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(homeData!.carouselImageList.length, (index) {
              return Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeData!.current_slider == index
                      ? MyTheme.white
                      : Color.fromRGBO(112, 112, 112, 0.3),
                ),
              );
            }),
          ),
        ],
      );
    } else if (!homeData!.isCarouselInitial &&
        homeData!.carouselImageList.isEmpty) {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    } else {
      return Container(height: 100); // fallback
    }
  }
}
