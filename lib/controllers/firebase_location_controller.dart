import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';

class LocationUpdate {
  late Location location = Location();

  void updateLocation() async {
    final dbrEf = FirebaseDatabase.instance.ref();
    location.enableBackgroundMode(enable: true);
    double? lat;
    double? long;
    location.onLocationChanged.listen(
      (LocationData cLoc) async {
        // cLoc contains the lat and long of the
        // current user's position in real time,
        // so we're holding on to it
        //currentLocation = cLoc;
        lat = cLoc.latitude;
        long = cLoc.longitude;

        String driverId =
            await SharedPref().getDataFromLocal(SharedPrefConstants.driver_id);
        bool isLogin = await SharedPref().getBoolFromLocal("rememberMe");

        if (isLogin) {
          await dbrEf
              .child("driverId/$driverId")
              .update({"latitude": lat, "longitude": long});
        }
      },
    );
  }
}
