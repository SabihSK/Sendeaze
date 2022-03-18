import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/controllers/delivery-controller.dart';
import 'package:sendeaze/pages/delivery/delivery-details-page.dart';
import 'package:sendeaze/pages/delivery/delivery-history-page.dart';
import 'package:sendeaze/pages/delivery/ongoing-delivery-page.dart';
import 'package:sendeaze/pages/forgot-password-page.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/pages/home/profile.dart';
import 'package:sendeaze/pages/login-page.dart';
import 'package:sendeaze/pages/qr-code-page.dart';
import 'package:sendeaze/pages/scan-details-page.dart';
import 'package:sendeaze/pages/splash-page.dart';
import 'constants/theme-constants.dart';
import 'pages/language-selector-page.dart';
import 'utils/app-translation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
//     name: "Sendeaze",
//     options: FirebaseOptions(
// //        databaseURL: "sendeazedriverlocations-7ce75",
//       databaseURL:
//           "https://sendeazedriverlocations-7ce75.firebaseio.com/drivers",
//       messagingSenderId:
//           '618560044303', // can be found on GoogleService-Info.plist
//       appId:
//           '1:618560044303:android:80f1576ff625460041927a', // can be found on GoogleService-Info.plist
//       apiKey:
//           'AIzaSyAgBYBHxBXIgpZOB5uE2RRjwlReLHb7qhY', //from google service.json file
//       projectId: 'sendeaze-342620', // from google service.json file
//     ),
      );
  Get.put(DeliveriesController());
  FirebaseDatabase.instance.ref().child('drivers').push().set({
    "latitude": 31.552226,
    "longitude": 71.555278,
    "driverId": 299
  }).then((value) {
    print("---- data saved");
  }).catchError((onError) {
    print("---- onError $onError");
  }).whenComplete(
          () => print("complte operation --------------------------"));


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sendeaze',
      theme: AppTheme.coreTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      translations: AppTranslation(),
      fallbackLocale: const Locale("en", "US"),
      locale: const Locale('en', 'US'),
      initialRoute: "/",
//      home: ScanDetails(),
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(
          name: LanguageSelectorPage.route,
          page: () => LanguageSelectorPage(),
        ),
        GetPage(
          name: LoginPage.route,
          page: () => LoginPage(),
        ),
        GetPage(
          name: ScanDetails.routeName,
          page: () => ScanDetails(),
        ),
        GetPage(
          name: ForgotPasswordPage.route,
          page: () => ForgotPasswordPage(),
        ),
        GetPage(
          name: HomePage.route,
          page: () => HomePage(),
        ),
        GetPage(
          name: DeliveryDetailsPage.route,
          page: () => DeliveryDetailsPage(),
        ),
        GetPage(
          name: DeliveryHistoryPage.route,
          page: () => DeliveryHistoryPage(),
        ),
        GetPage(
          name: OnGoingDeliveryPage.route,
          page: () => OnGoingDeliveryPage(),
        ),
        GetPage(
          name: EditProfileScreen.routeName,
          page: () => EditProfileScreen(),
        ),
        GetPage(
          name: QRCodeScreen.routeName,
          page: () => QRCodeScreen(),
        ),
      ],
      builder: (ctx, widget) {
        return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: widget!);
      },
      // home: LanguageSelectorPage(),
    );
  }
}
