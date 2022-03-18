import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  final Function()? onPressed;

  const AppBarWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
          child: IconButton(
            onPressed: onPressed ??
                () {
                  Scaffold.of(context).openDrawer();
                },
            icon: Icon(Icons.list_outlined),
          ),
        ),
        SizedBox(width: 15),
        Text(
          "home".tr,
          style: Get.textTheme.headline6,
        )
      ],
    );
  }
}
