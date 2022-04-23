import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:sendeaze/controllers/change_google_map_polyline_controller.dart';
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
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/map_data_service.dart';
import 'constants/shared-pref-constant.dart';
import 'constants/theme-constants.dart';
import 'pages/language-selector-page.dart';
import 'utils/app-translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wakelock/wakelock.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
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
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  Get.put(DeliveriesController());

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
//   String driverId =
//       await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);

//   final dbrEf = FirebaseDatabase.instance.ref();
//   late Location location = Location();
//   String? lat;
//   String? long;
//   location.onLocationChanged.listen((LocationData cLoc) async {
//     // cLoc contains the lat and long of the
//     // current user's position in real time,
//     // so we're holding on to it
// //      currentLocation = cLoc;
//     lat = cLoc.latitude.toString();
//     lat = cLoc.longitude.toString();

//     await dbrEf
//         .child("driverId/$driverId")
//         .update({"latitude": lat, "longitude": lat});
//   });

  // Timer.periodic(const Duration(minutes: 1), (timer) async {
  //   await dbrEf
  //       .child("driverId/$driverId")
  //       .update({"latitude": 31.552226, "longitude": 70.555278});
  //   // print(timer.tick);
  //   // print("Sabih");
  //   // counter--;
  //   // if (counter == 0) {
  //   //   print('Cancel timer');
  //   //   timer.cancel();
  //   // }
  // });

  // await dbrEf
  //     .child("driverId/30")
  //     .update({"latitude": 31.552226, "longitude": 70.555278});

  // dbrEf.orderByValue(driverId);ref
  // print(dbrEf.orderByValue());
  // dbrEf.child("Posts")
  //           .orderByChild(uid!)
  //           .queryEqualToValue(nil);
  // dbrEf.orderByChild('genre')
  // .startAt('comedy').endAt('comedy')
  // .orderBy('lead')                  // !!! THIS LINE WILL RAISE AN ERROR !!!
  // .startAt('Jack Nicholson').endAt('Jack Nicholson')
  // .on('value', function(snapshot) {
  //     console.log(snapshot.val());
  // });
  // dbrEf
  // .orderByChild('genre')
  // .equalTo('comedy')
  // .once('child_added', function(snapshot) {
  //     var movie = snapshot.val();
  //     if (movie.lead == 'Jack Nicholson') {
  //         console.log(movie);
  //     }
  // });
  // .on('child_added', function(snapshot) {
  //     var movie = snapshot.val();
  //     if (movie.lead == 'Jack Nicholson') {
  //         console.log(movie);
  //     }
  // });

  // String driverId =
  //     await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);

  // final dbrEf = FirebaseDatabase.instance.ref();

  // await dbrEf.child("driverToken/$driverId").update({"driverToken": token});
  // await dbrEf.child('driverToken/$driverId').set({"token"}).then((value) {
  //   print("---- data saved");
  // }).catchError((onError) {
  //   print("---- onError $onError");
  // }).whenComplete(() => print("complte operation --------------------------"));

  // DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

  // await ref.set({
  //   "name": "John",
  //   "age": 18,
  //   "address": {"line1": "100 Mountain View"}
  // });

  // DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
  // MapPolylineApi().getMapPolyline();
  // PolylineController().decode();

  // var counter = 3;
//   Timer.periodic(const Duration(seconds: 1), (timer) {
// ref.
//     print(timer.tick);
//     print("Sabih");
//     // counter--;
//     // if (counter == 0) {
//     //   print('Cancel timer');
//     //   timer.cancel();
//     // }
//   });

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
          page: () => DeliveryDetailsPage(
            width: MediaQuery.of(context).size.width,
          ),
        ),
        GetPage(
          name: DeliveryHistoryPage.route,
          page: () => DeliveryHistoryPage(),
        ),
        GetPage(
          name: OnGoingDeliveryPage.route,
          page: () => OnGoingDeliveryPage(
            width: MediaQuery.of(context).size.width,
          ),
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
