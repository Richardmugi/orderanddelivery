import 'dart:async';

import 'package:active_ecommerce_flutter/custom/aiz_route.dart';
import 'package:active_ecommerce_flutter/helpers/main_helpers.dart';
import 'package:active_ecommerce_flutter/middlewares/auth_middleware.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/presenter/cart_counter.dart';
import 'package:active_ecommerce_flutter/presenter/cart_provider.dart';
import 'package:active_ecommerce_flutter/presenter/currency_presenter.dart';
import 'package:active_ecommerce_flutter/presenter/select_address_provider.dart';
import 'package:active_ecommerce_flutter/presenter/unRead_notification_counter.dart';
import 'package:active_ecommerce_flutter/providers/locale_provider.dart';
import 'package:active_ecommerce_flutter/screens/all_routes.dart';
import 'package:active_ecommerce_flutter/screens/auction/auction_bidded_products.dart';
import 'package:active_ecommerce_flutter/screens/auction/auction_products.dart';
import 'package:active_ecommerce_flutter/screens/auction/auction_products_details.dart';
import 'package:active_ecommerce_flutter/screens/auction/auction_purchase_history.dart';
import 'package:active_ecommerce_flutter/screens/auth/login.dart';
import 'package:active_ecommerce_flutter/screens/auth/registration.dart';
import 'package:active_ecommerce_flutter/screens/brand_products.dart';
import 'package:active_ecommerce_flutter/screens/category_list_n_product/category_list.dart';
import 'package:active_ecommerce_flutter/screens/category_list_n_product/category_products.dart';
import 'package:active_ecommerce_flutter/screens/checkout/cart.dart';
import 'package:active_ecommerce_flutter/screens/coupon/coupons.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/flash_deal/flash_deal_list.dart';
import 'package:active_ecommerce_flutter/screens/flash_deal/flash_deal_products.dart';
import 'package:active_ecommerce_flutter/screens/followed_sellers.dart';
import 'package:active_ecommerce_flutter/screens/index.dart';
import 'package:active_ecommerce_flutter/screens/orders/order_details.dart';
import 'package:active_ecommerce_flutter/screens/orders/order_list.dart';
import 'package:active_ecommerce_flutter/screens/package/packages.dart';
import 'package:active_ecommerce_flutter/screens/product/product_details.dart';
import 'package:active_ecommerce_flutter/screens/product/todays_deal_products.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/seller_details.dart';
import 'package:active_ecommerce_flutter/services/push_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:shared_value/shared_value.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'app_config.dart';
import 'lang_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await FlutterDownloader.initialize(
      debug: true, // optional: set to false in production
    );
  }
  /*await FlutterDownloader.initialize(
    debug: true, // Optional: set to false to disable printing logs to console
    ignoreSsl:
        true, // Optional: set to false to disable working with HTTP links
  );*/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

var routes = GoRouter(
  overridePlatformDefaultLocation: false,
  navigatorKey: OneContext().key,
  initialLocation: "/",
  routes: [
    GoRoute(
        path: '/',
        name: "Home",
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage(child: Index()),
        routes: [
          GoRoute(
              path: "customer_products",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: MyClassifiedAds())),
          GoRoute(
              path: "customer-products",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: ClassifiedAds())),
          GoRoute(
              path: "customer-product/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: ClassifiedAdsDetails(
                    slug: getParameter(state, "slug"),
                  ))),
          GoRoute(
              path: "product/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: ProductDetails(
                    slug: getParameter(state, "slug"),
                  ))),
          GoRoute(
              path: "customer-packages",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: UpdatePackage())),
          GoRoute(
              path: "auction_product_bids",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: AuthMiddleware(AuctionBiddedProducts()).next())),
          GoRoute(
              path: "users/login",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: Login())),
          GoRoute(
              path: "users/registration",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: Registration())),
          GoRoute(
              path: "dashboard",
              name: "Profile",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  AIZRoute.rightTransition(Profile())),
          GoRoute(
              path: "auction-products",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: AuctionProducts())),
          GoRoute(
              path: "auction-product/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: AuctionProductsDetails(
                    slug: getParameter(state, "slug"),
                  ))),
          GoRoute(
              path: "auction/purchase_history",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: AuthMiddleware(AuctionPurchaseHistory()).next())),
          GoRoute(
              path: "brand/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (BrandProducts(
                    slug: getParameter(state, "slug"),
                  )))),
          GoRoute(
              path: "brands",
              name: "Brands",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: Filter(
                    selected_filter: "brands",
                  ))),
          GoRoute(
              path: "cart",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: AuthMiddleware(Cart()).next())),
          GoRoute(
              path: "categories",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (CategoryList(
                    slug: getParameter(state, "slug"),
                  )))),
          GoRoute(
              path: "category/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (CategoryProducts(
                    slug: getParameter(state, "slug"),
                  )))),
          GoRoute(
              path: "flash-deals",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: (FlashDealList()))),
          GoRoute(
              path: "flash-deal/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (FlashDealProducts(
                    slug: getParameter(state, "slug"),
                  )))),
          GoRoute(
              path: "followed-seller",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: (FollowedSellers()))),
          GoRoute(
              path: "purchase_history",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: (OrderList()))),
          GoRoute(
              path: "purchase_history/details/:id",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (OrderDetails(
                    id: int.parse(getParameter(state, "id")),
                  )))),
          GoRoute(
              path: "sellers",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (Filter(
                    selected_filter: "sellers",
                  )))),
          GoRoute(
              path: "shop/:slug",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      child: (SellerDetails(
                    slug: getParameter(state, "slug"),
                  )))),
          GoRoute(
              path: "todays-deal",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: (TodaysDealProducts()))),
          GoRoute(
              path: "coupons",
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(child: (Coupons()))),
        ])
  ],
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Firebase.initializeApp();
      if (OtherConfig.USE_PUSH_NOTIFICATION) {
        PushNotificationService().initialise();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => CartCounter()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SelectAddressProvider()),
        ChangeNotifierProvider(
            create: (context) => UnReadNotificationCounter()),
        ChangeNotifierProvider(create: (context) => CurrencyPresenter()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) {
          return MaterialApp.router(
            routerConfig: routes,
            title: AppConfig.app_name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyTheme.white,
              scaffoldBackgroundColor: MyTheme.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: "PublicSansSerif",
              textTheme: MyTheme.textTheme1,
              fontFamilyFallback: ['NotoSans'],
              scrollbarTheme: ScrollbarThemeData(
                thumbVisibility: MaterialStateProperty.all<bool>(false),
              ),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: LangConfig().supportedLocales(),
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if (AppLocalizations.delegate.isSupported(deviceLocale!)) {
                return deviceLocale;
              }
              return const Locale('en');
            },
          );
        },
      ),
    );
  }
}
