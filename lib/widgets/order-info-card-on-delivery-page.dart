import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderInfoCard extends StatelessWidget {
  final Duration? elapsedTime;
  final distance;
  final orderId;

  const OrderInfoCard({Key? key, this.elapsedTime, this.distance, this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 60,
        width: Get.width * .925,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElapsedTimeText(elapsed: elapsedTime),
            // _infoCard(),
            VerticalDivider(),
            _infoCard(title: "Travel Distance", value: "$distance KM"),
            VerticalDivider(),
            _infoCard(title: "Order #", value: "$orderId"),
          ],
        ),
      ),
    );
  }

  Column _infoCard({String title = "Travel Time", String value = "00:20:12"}) {
    return Column(
      children: [
        Text(
          title,
          style: Get.textTheme.caption!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: Get.textTheme.button,
        ),
      ],
    );
  }
}

class ElapsedTimeText extends StatelessWidget {
  const ElapsedTimeText({Key? key, required this.elapsed}) : super(key: key);
  final Duration? elapsed;

  @override
  Widget build(BuildContext context) {
    final hundreds = (elapsed!.inMilliseconds / 10) % 100;
    final hours = elapsed!.inHours % 60;
    final seconds = elapsed!.inSeconds % 60;
    final minutes = elapsed!.inMinutes % 60;
    final hundredsStr = hundreds.toStringAsFixed(0).padLeft(2, '0');
    final hoursStr = hours.toString().padLeft(2, "0");
    final secondsStr = seconds.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    const digitWidth = 9.0;
    return Column(
      children: [
        Text(
          "Travel time",
          style: Get.textTheme.caption!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeDigit(hoursStr.substring(0, 1), width: digitWidth),
            TimeDigit(hoursStr.substring(1, 2), width: digitWidth),
            TimeDigit(':', width: 6),
            TimeDigit(minutesStr.substring(0, 1), width: digitWidth),
            TimeDigit(minutesStr.substring(1, 2), width: digitWidth),
            TimeDigit(':', width: 6),
            TimeDigit(secondsStr.substring(0, 1), width: digitWidth),
            TimeDigit(secondsStr.substring(1, 2), width: digitWidth),
            // TimeDigit(':', width: 6),
            // TimeDigit(hundredsStr.substring(0, 1), width: digitWidth),
            // TimeDigit(hundredsStr.substring(1, 2), width: digitWidth),
          ],
        ),
      ],
    );
  }
}

class TimeDigit extends StatelessWidget {
  const TimeDigit(this.text, {Key? key, required this.width}) : super(key: key);
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: Get.textTheme.button,
        textAlign: TextAlign.center,
      ),
    );
  }
}
