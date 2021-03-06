import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sendeaze/constants/assets-constants.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:sendeaze/models/profile_model.dart';
import 'package:sendeaze/services/common/shared-preference-service.dart';
import 'package:sendeaze/services/user/user-service.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/text-field-widget.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/pages/profile";
  final bool isOpenFromTab;

  const EditProfileScreen({Key? key, this.isOpenFromTab = false})
      : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    getProfileImage();
    super.initState();
  }

  getProfileImage() async {
    profilePic = await SharedPref()
        .getDataFromLocal(SharedPrefConstants.USER_PROFILE_IMAGE);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  bool isCurrentPasswordChange = false,
      isNewPasswordChange = false,
      isConfirmPasswordChange = false;
  int currentPage = 0;
  File? fileUrl;
  String firstName = "", lastName = "", phoneNumber = "", role = "";
  String? profilePic;
  bool isImageLoaded = true;

  bool showLoader = false;
  late final Future<ProfileModel>? myProfile = UserService().getProfile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: FutureBuilder<ProfileModel>(
          future: myProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [_form(snapshot.data!.data), _changePAssworod()],
            );
          }),
    );
  }

  Widget _form(Data? data) {
    String? name = data?.name;
    String? lastName = "";
    String? firstName = "";
    if (name != null && name.split("\\w+").length > 0) {
      try {
        firstName = name.substring(0, name.lastIndexOf(' '));
      } catch (e) {
        firstName = "";
      }
      lastName = name.substring(name.lastIndexOf(' ') + 1);
    } else {
      firstName = name;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (!widget.isOpenFromTab) AppBackButton(isTransparent: true),
                SizedBox(width: 15),
                Padding(
                  padding: EdgeInsets.only(top: widget.isOpenFromTab ? 40 : 25),
                  child: Text(
                    "profile".tr,
                    style: Get.textTheme.headline6,
                  ),
                )
              ],
            ),
            buildProfilePic(data?.profileImg),
            SizedBox(height: 30),
            TextFieldWidget(
              icon: AssetConstants.PROFILE_ICON,
              hintText: "first_name".tr, enabled: false,
              initialValue: firstName,
              //        controller: _firstNameController,
            ),
            TextFieldWidget(
              enabled: false,
              hintText: "last_name".tr,
              //          controller: _lastNameController,
              icon: AssetConstants.PROFILE_ICON,
              initialValue: lastName,
            ),
            TextFieldWidget(
              enabled: false,
              hintText: "username".tr,
              //            controller: _usernameController,
              icon: AssetConstants.PROFILE_ICON,
              initialValue: name,
            ),
            TextFieldWidget(
              enabled: false,
              hintText: "mobile_number".tr,
//              controller: _mobileNumberController,
              icon: AssetConstants.MOBILE_ICON,
              initialValue: data?.mobileNum,
            ),
            // TextFieldWidget(
            //   hintText: "address".tr,
            //   icon: AssetConstants.LOCATION_ICON,
            //   initialValue: data?.address,
            // ),
            // TextFieldWidget(
            //   hintText: "account_number".tr,
            //   icon: AssetConstants.CREDIT_CARD_ICON,
            // ),
            TextFieldWidget(
              enabled: false,
              hintText: "vehicle_number".tr,
              controller: _vehicleNumberController,
              // initialValue: data.mobileNum,
              icon: AssetConstants.CAR_ICON,
            ),
            // SizedBox(height: 20),
            // ButtonWidget(
            //   btnText: "update".tr + " " + "profile".tr,
            //   onPressed: () {
            //     UserService().updateProfile(
            //         name: _firstNameController.text +
            //             " " +
            //             _lastNameController.text,
            //         idNum: data!.iqNum ?? 0,);
            //   },
            // ),
            SizedBox(height: 20),
            ButtonWidget(
              btnText: "change_password".tr,
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _changePAssworod() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppBackButton(
                isTransparent: true,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _pageController.previousPage(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOutCubic,
                  );
                },
              ),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "change_password".tr,
                  style: Get.textTheme.headline6,
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          TextFieldWidget(
            icon: AssetConstants.PASSWORD_ICON,
            hintText: "current_password".tr,
            isObsecure: true,
            controller: _currentPasswordController,
            onChanged: (v) {
              isCurrentPasswordChange = true;
              setState(() {});
            },
            errorText: _currentPasswordController.text.length < 1 &&
                    isCurrentPasswordChange
                ? "Enter your current password"
                : "",
          ),
          TextFieldWidget(
            icon: AssetConstants.PASSWORD_ICON,
            hintText: "new_password".tr,
            isObsecure: true,
            controller: _newPasswordController,
            onChanged: (v) {
              isNewPasswordChange = true;
              setState(() {});
            },
            errorText:
                _newPasswordController.text.length < 6 && isNewPasswordChange
                    ? "Password length must be more than 6"
                    : "",
          ),
          TextFieldWidget(
            icon: AssetConstants.PASSWORD_ICON,
            controller: _confirmPasswordController,
            hintText: "confirm_password".tr,
            isObsecure: true,
            onChanged: (v) {
              isConfirmPasswordChange = true;
              setState(() {});
            },
            errorText: _confirmPasswordController.text.length < 6 &&
                    isConfirmPasswordChange
                ? "Password length must be more than 6"
                : "",
          ),
          ButtonWidget(
            btnText: "update".tr,
            showLoader: showLoader,
            onPressed: () {
              // _pageController.nextPage(
              //   duration: Duration(seconds: 1),
              //   curve: Curves.easeInOut,
              // );
              if (_newPasswordController.text !=
                  _confirmPasswordController.text) {
                AppWidgets.showSnackBar("Your password is not matching!");
              } else if (_currentPasswordController.text.isEmpty &&
                  _newPasswordController.text.isEmpty &&
                  _confirmPasswordController.text.isEmpty) {
                AppWidgets.showSnackBar("Please enter all fields");
              } else if (_currentPasswordController.text.length > 5 &&
                  _newPasswordController.text.length > 5 &&
                  _confirmPasswordController.text.length > 5) {
                showLoader = true;
                setState(() {});
                UserService()
                    .changePassword(_currentPasswordController.text,
                        _newPasswordController.text)
                    .then((value) => setState(() => showLoader = false));
              } else {
                AppWidgets.showSnackBar("Password length must be more than 6");
              }
            },
          )
        ],
      ),
    );
  }

  Center buildProfilePic(String? profileImg) {
    return Center(
      child: Stack(
        children: [
          isImageLoaded
              ? Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    border: Border.all(color: AppColors.PRIMARY, width: 3),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      // image: NetworkImage(profileImg)
                      image: NetworkImage(profilePic ??
                          "http://admin.sendeaze.com/public/assets/img/logo_3.png"),
                      // FileImage(
                      //   File(profilePic),
                      // ),
                    ),
                  ),
                )
              : Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    border: Border.all(color: AppColors.PRIMARY, width: 3),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      // image: NetworkImage(profileImg)
                      image: NetworkImage(
                          "http://admin.sendeaze.com/public/assets/img/logo_3.png"),
                      // FileImage(
                      //   File(profilePic),
                      // ),
                    ),
                  ),
                ),
          Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                mini: true,
                child: const Icon(Icons.edit, color: Colors.white),
                backgroundColor: AppColors.PRIMARY,
                onPressed: () {
                  showActionSheet();

                  // openImage();
                },
              )),
        ],
      ),
    );
  }

  updateDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog();
      },
    );
  }

  showActionSheet() {
    showAdaptiveActionSheet(
      bottomSheetColor: AppColors.WHITE,
      context: context,
      title: Text(
        'Upload Profile Picture',
      ),
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: Text(
              'From Camera',
              style: TextStyle(color: AppColors.BLACK, fontSize: 14),
              textAlign: TextAlign.left,
            ),
            onPressed: () {
              Navigator.pop(context);
              getImage(ImageSource.camera, context);
            }),
        BottomSheetAction(
            title: Text(
              'From Gallery',
              style: TextStyle(color: AppColors.BLACK, fontSize: 14),
              textAlign: TextAlign.left,
            ),
            onPressed: () {
              Navigator.pop(context);
              getImage(ImageSource.gallery, context);
            }),
      ],
    );
  }

  Future getImage(ImageSource source, BuildContext context1) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: source, maxWidth: 1200.0, maxHeight: 2000.0, imageQuality: 100);
    print("File: " + pickedFile!.path);

    await SharedPref()
        .setStringToLocal(SharedPrefConstants.USER_PROFILE_IMAGE, "");
    isImageLoaded = false;
    setState(() {});
    openImage(pickedFile);
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: pickedFile.path);
    fileUrl = File(rotatedImage.path);
    print("$fileUrl & ${this.profilePic}");
  }

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";

  openImage(pickedFile) async {
    try {
      // var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        print(imagepath);
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string =
            base64.encode(imagebytes); //convert bytes to base64 string
        print(base64string);
        /* Output:
              /9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
              wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
              AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
              */

        UserService().uploadImageFunc(base64string).then((value) async => {
              this.profilePic = await SharedPref()
                  .getDataFromLocal(SharedPrefConstants.USER_PROFILE_IMAGE),
              isImageLoaded = true,
              setState(() {}),
            });

        Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes

      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }
}
