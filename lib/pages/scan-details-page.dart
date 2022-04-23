import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/controllers/delivery-controller.dart';
import 'package:sendeaze/models/scanDataModel.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-loader.dart';
import 'package:sendeaze/widgets/button-widget.dart';
import 'package:sendeaze/widgets/text-field-widget.dart';

class ScanDetails extends StatefulWidget {
  static String routeName = "/pages/scan-details-page";
  // final ScanDetailsModel? data;

  ScanDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanDetails> createState() => _ScanDetailsState();
}

class _ScanDetailsState extends State<ScanDetails> {
  bool _showLoader = false;
  bool _pageLoadin = true;
  // late final argss;
  var todayAssignedDeliveriesData;
  int s = 0, m = 0, l = 0;

  // DeliveriesController _deliveriesController = Get.put(DeliveriesController());
  @override
  void initState() {
    super.initState();
    getFutureData();
    // _deliveriesController.getInfoList(argss.info ?? []);
    // print("lskfjdlks ${_deliveriesController.infoList.length}");
  }

  getFutureData() async {
    todayAssignedDeliveriesData =
        await OrderService().todayAssignedDeliveriesFunc();
    // print("argument ${Get.arguments}");
    // final jsonData = jsonDecode(Get.arguments.toString());
    // argss = ScanDetailsModel.fromJson(jsonData);
    // var _list = argss.info as List;
    // //first adding all the deliveries in the list
    if (await todayAssignedDeliveriesData?.data! != null) {
      await todayAssignedDeliveriesData.data.forEach((e) {
        if (e.boxSize == "S") {
          s++;
        } else if (e.boxSize == "M") {
          m++;
        } else if (e.boxSize == "L") {
          l++;
        }
        _idsStatuses.add({"id": e.id, "status": "Ready"});
      });
    }
    _pageLoadin = false;
    setState(() {});
  }

  @override
  void dispose() {
    s = 0;
    m = 0;
    l = 0;
    _idsStatuses.clear();
    super.dispose();
  }

  List<Map<String, dynamic>> _idsStatuses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageLoadin
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppBackButton(isTransparent: true),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                "scan_details".tr,
                                style: Get.textTheme.headline6,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            //                      buildTextField(text: args['client_id'].toString()),
                            // buildTextField(text: argss.clientName),
                            // buildTextField(
                            //     hint: "vendor_branch_name",
                            //     text: argss.pickupLocation),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildOvalContainer(s),
                                buildOvalContainer(m),
                                buildOvalContainer(l),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Update Box Status",
                                style: Get.textTheme.caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                // var infoItem =
                                //     todayAssignedDeliveriesData.data[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Box ID: ${todayAssignedDeliveriesData?.data[index].boxUniqueId}",
                                            style: Get.textTheme.button!
                                                .copyWith(
                                                    color: AppColors.PRIMARY),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      CircularIconWidget(
                                          color: _idsStatuses[index]
                                                      ["status"] ==
                                                  "Ready"
                                              ? Colors.greenAccent
                                              : null,
                                          onPressed: () {
                                            setState(() {
                                              if (_idsStatuses[index]
                                                      ["status"] ==
                                                  "Ready") {
                                                // _idsStatuses.firstWhere(
                                                //     (e) => e["id"] == infoItem.id);
                                                _idsStatuses[index]["status"] =
                                                    "Unavailable";
                                                // print(
                                                //     "list ${_idsStatuses[index]['status']}");
                                              } else {
                                                _idsStatuses[index]["status"] =
                                                    "Ready";
                                                // print(
                                                //     "list ${_idsStatuses[index]['status']}");

                                                // _idsStatuses.add({
                                                //   "id": infoItem.id,
                                                //   "status": "picked"
                                                // });
                                              }

                                              print(
                                                  "list ${_idsStatuses.length} \n$_idsStatuses");
                                            });
                                          },
                                          iconData: Icons.done_outlined),
                                    ],
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount:
                                  todayAssignedDeliveriesData?.data.length ?? 0,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        todayAssignedDeliveriesData?.data != null
                            ? ButtonWidget(
                                btnText: "confirm".tr,
                                onPressed: () {
                                  _pageLoadin = true;
                                  setState(() {});
                                  OrderService().markAsReady(_idsStatuses).then(
                                    (value) {
                                      setState(() => _pageLoadin = false);
                                      if (value["error"] == null) {
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Get.offAllNamed(HomePage.route);
                                        });
                                      }
                                    },
                                  );
                                },
                              )
                            : Center(
                                child: Text("No deliveries found"),
                              ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  buildOvalContainer([text, heading]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading ?? "Small",
          style: Get.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.BACKGROUND_LIGHT,
              shape: BoxShape.rectangle),
          child: Text(
            text.toString(),
            style: Get.textTheme.button!.copyWith(color: AppColors.PRIMARY),
          ),
        ),
      ],
    );
  }

  Column buildTextField({String hint = "vendor_name", String? text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            hint.tr,
            style: Get.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextFieldWidget(
          icon: "",
          enabled: false,
          controller: TextEditingController(text: text),
          hintText: hint.tr,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CircularIconWidget extends StatelessWidget {
  final Color? color, iconColor;
  final IconData? iconData;
  void Function()? onPressed;
  CircularIconWidget(
      {Key? key, this.color, this.iconColor, this.iconData, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.grey.shade300,
      ),
      padding: EdgeInsets.all(3),
      child: IconButton(
        icon: Icon(
          iconData ?? Icons.close,
          color: iconColor ?? Colors.grey,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
