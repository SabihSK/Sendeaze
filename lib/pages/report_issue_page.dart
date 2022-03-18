import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/user/user-service.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/app-widgets.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/text-field-widget.dart';

class ReportIssuePage extends StatefulWidget {
  @override
  State<ReportIssuePage> createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  TextEditingController _subjectController = TextEditingController();

  TextEditingController _contentController = TextEditingController();

  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    AppBackButton(isTransparent: true),
                    SizedBox(width: 15),
                    Text(
                      "Report a problem",
                      style: Get.textTheme.headline6,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Subject",
                    style: Get.textTheme.caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFieldWidget(
                  icon: "",
                  hintText: "Write a Subject",
                  controller: _subjectController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Content",
                    style: Get.textTheme.caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.BACKGROUND_LIGHT,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    maxLines: 6,
                    minLines: 6,
                    controller: _contentController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: AppColors.PRIMARY_BLUE),
                        border: InputBorder.none,
                        hintText: "Add content here..."),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  onPressed: () {
                    if (_contentController.text.isEmpty ||
                        _subjectController.text.isEmpty) {
                      AppWidgets.showSnackBar("Please fill the fields");
                    } else {
                      showLoader = true;
                      setState(() {});
                      UserService()
                          .reportIssue(
                              _subjectController.text, _contentController.text)
                          .then((value) {
                        setState(() => showLoader = false);
                        if (value.message != null) Get.offAll(() => HomePage());
                      });
                    }
                  },
                  btnText: "submit".tr,
                )
              ],
            ),
          ),
          if (showLoader) Center(child: AppLoader())
        ],
      ),
    ));
  }
}
