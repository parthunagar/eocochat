import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/model/MyProductModel.dart';
import 'package:rentors/model/booking/MyBooking.dart' as booking;
import 'package:rentors/model/category/CategoryDetailModel.dart'
    as categoryDetail;
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/screen/AddPersonalDetailScreen.dart';
import 'package:rentors/screen/ChangePasswordScreen.dart';
import 'package:rentors/screen/ComplaintScreen.dart';
import 'package:rentors/screen/CreateProductScreenWidget.dart';
import 'package:rentors/screen/DrawerHomeWidget.dart';
import 'package:rentors/screen/FilterScreen.dart';
import 'package:rentors/screen/ForgotPasswordScreen.dart';
import 'package:rentors/screen/InAppWebViewScreen.dart';
import 'package:rentors/screen/LanguangeScreen.dart';
import 'package:rentors/screen/MapScreen.dart';
import 'package:rentors/screen/NearBySearchScreen.dart';
import 'package:rentors/screen/NotificationScreen.dart';
import 'package:rentors/screen/ReviewListScreen.dart';
import 'package:rentors/screen/SearchScreen.dart';
import 'package:rentors/screen/SettingScreen.dart';
import 'package:rentors/screen/SignWithEmailWidget.dart';
import 'package:rentors/screen/SignWithMobileWidget.dart';
import 'package:rentors/screen/SignupScreen.dart';
import 'package:rentors/screen/SubscriptionListScreen.dart';
import 'package:rentors/screen/UserProfileScreen.dart';
import 'package:rentors/screen/VerifyOTPWidget.dart';
import 'package:rentors/screen/WishListScreen.dart';
import 'package:rentors/screen/booking/BookProductScreen.dart';
import 'package:rentors/screen/booking/BookingDetailScreen.dart';
import 'package:rentors/screen/booking/BookingScreen.dart';
import 'package:rentors/screen/booking/BuyerDetailScreen.dart';
import 'package:rentors/screen/booking/MyBookingRequestScreen.dart';
import 'package:rentors/screen/booking/ProductPreviewScreen.dart';
import 'package:rentors/screen/cateogry/CategoryDetailsScreen.dart';
import 'package:rentors/screen/cateogry/CategoryScreenWidget.dart';
import 'package:rentors/screen/cateogry/SubcategoryDetailScreen.dart';
import 'package:rentors/screen/chat/ChatScreen.dart';
import 'package:rentors/screen/chat/ConversationScreen.dart';
import 'package:rentors/screen/payment/PaymentScreen.dart';
import 'package:rentors/screen/payment/SelectPaymentMethodScreen.dart';
import 'package:rentors/screen/product/AllProductListScreen.dart';
import 'package:rentors/screen/product/MyProductListingScreen.dart';
import 'package:rentors/screen/product/ProductDetailWidget.dart';
import 'package:rentors/screen/product/TopFeatureProductScreen.dart';
import 'package:rentors/screen/splash/PagerViewWidget.dart';
import 'package:rentors/screen/splash/SplashScreenWidget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return CupertinoPageRoute(builder: (_) => SplashScreenWidget());
      case '/pager':
        return CupertinoPageRoute(builder: (_) => PagerViewWidget());
      case '/email':
        return CupertinoPageRoute(builder: (_) => SignWithEmailWidget());
      case '/forgot':
        return CupertinoPageRoute(builder: (_) => ForgotPasswordScreen());
      case '/signup':
        return CupertinoPageRoute(builder: (_) => SignupScreen());
      case '/otp':
        return CupertinoPageRoute(builder: (_) => SignWithMobileWidget());
      case '/verify':
        var map = args as Map;
        return CupertinoPageRoute(
            builder: (_) => VerifyOTPWidget(map["verificationId"],
                map["mobileNumber"], map["number"], map["code"]));
      case '/home':
        return CupertinoPageRoute(builder: (_) => DrawerHomeWidget());
      case '/myproduct':
        return CupertinoPageRoute(builder: (_) => MyProductListingScreen());
      case '/create_product':
        return CupertinoPageRoute(
            builder: (_) => CreateProductScreenWidget(args as MyProduct));
      case '/top_featured':
        return CupertinoPageRoute(
            builder: (_) =>
                TopFeatureProductScreen(args as List<FeaturedProductElement>));
      case '/personal_detail':
        Map map = args;
        return CupertinoPageRoute(
            builder: (_) => AddPersonalDetailScreen(map['new'], map['old']));
      case '/category':
        return CupertinoPageRoute(builder: (_) => CategoryScreenWidget());

      case '/conversation':
        return CupertinoPageRoute(builder: (_) => ConversationScreen());
      case '/chat':
        return CupertinoPageRoute(builder: (_) => ChatScreen(args as String));
      case '/product_details':
        Map map = args;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsWidget(map["name"], map["id"]));
      case '/category_detail':
        return CupertinoPageRoute(
            builder: (_) => CategoryDetailsScreen(args as String));
      case '/booking':
        return CupertinoPageRoute(builder: (_) => BookingScreen());

      case '/booking_request':
        return CupertinoPageRoute(
            builder: (_) => MyBookingRequestScreen(args as String));

      case '/buyer_detail':
        return CupertinoPageRoute(
            builder: (_) => BuyerDetailScreen(args as booking.Datum));
      case '/settings':
        return CupertinoPageRoute(builder: (_) => SettingScreen());
      case '/wishlist':
        return CupertinoPageRoute(builder: (_) => WishListScreen());
      case '/profile':
        return CupertinoPageRoute(builder: (_) => UserProfileScreen());
      case '/complaint':
        return CupertinoPageRoute(builder: (_) => ComplaintScreen());
      case '/booking_details':
        return CupertinoPageRoute(
            builder: (_) => BookingDetailScreen(args as booking.Datum));
      case '/change_password':
        return CupertinoPageRoute(builder: (_) => ChangePasswordScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen(args));
      case '/allproduct':
        return CupertinoPageRoute(
            builder: (_) => AllProductListScreen(args as SubCategory));
      case '/book_product':
        return CupertinoPageRoute(
            builder: (_) => BookProductScreen(args as ProductDetailModel));
      case '/subscription':
        return CupertinoPageRoute(builder: (_) => SubScriptionListScreen());
      case '/preview':
        return CupertinoPageRoute(builder: (_) => ProductPreviewScreen(args));
      case '/notification':
        return CupertinoPageRoute(builder: (_) => NotificationScreen());
      case '/payment_method':
        Map map = args;
        var feature = map["feat"];
        var product = map["prod"];
        return CupertinoPageRoute(
            builder: (_) => SelectPaymentMethodScreen(
                  product,
                  feature: feature,
                ));
      case '/payment_checkout':
        Map map = args;
        var feature = map["feat"];
        var product = map["prod"];
        var type = map["t"];
        return CupertinoPageRoute(
            builder: (_) => PaymentScreen(product, feature, type));
      case '/subcategory_detail':
        return CupertinoPageRoute(
            builder: (_) =>
                SubcategoryDetailScreen(args as categoryDetail.SubCategory));
      case '/webview':
        Map map = args;
        return CupertinoPageRoute(
            builder: (_) => InAppWebViewScreen(map["title"], map["url"]));
      case '/lang':
        return CupertinoPageRoute(builder: (_) => LanguangeScreen());
      case '/map_page':
        return CupertinoPageRoute(builder: (_) => MapScreen());
      case '/nearby_page':
        return CupertinoPageRoute(builder: (_) => NearBySearchScreen(args));
      case '/filter':
        return CupertinoPageRoute(builder: (_) => FilterScreen());
        case '/review_list':
        return CupertinoPageRoute(builder: (_) => ReviewListScreen(args));
//
    }
    return null;
  }
}
