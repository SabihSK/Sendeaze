import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/models/history_of_deliveries.dart';
import 'package:sendeaze/pages/delivery/delivery-details-page.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-divder.dart';
import 'package:sendeaze/widgets/order-detail-card.dart';
import 'package:sendeaze/models/orders-list-response.dart'
    as ordersListResponse;

class DeliveryHistoryPage extends StatefulWidget {
  static String route = "/pages/delivery/delivery-page";

  @override
  State<DeliveryHistoryPage> createState() => _DeliveryHistoryPageState();
}

class _DeliveryHistoryPageState extends State<DeliveryHistoryPage> {
  int currentIndex = 0;

  Widget tabbar(width) {
    return TabBar(
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
      indicatorColor: Colors.transparent,
      // indicator: BoxDecoration(
      //     // shape: EdgeInsets.only(left: 10, right: 10),
      //     // borderRadius: BorderRadius.only(
      //     //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      //     color: AppColors.PRIMARY_BLUE),
      unselectedLabelColor: AppColors.GREY,
      unselectedLabelStyle: TextStyle(),
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      labelColor: AppColors.PRIMARY_BLUE,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.only(top: 13, bottom: 20),
      tabs: [
        Text("All"),
        Text("Ongoing"),
        Text("Delivered"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(isTransparent: true),
              tabbar(width),
              // SizedBox(height: 15),
              AppDivider(),
              Expanded(
                child: FutureBuilder<HistoryOfDeliveries>(
                    future: OrderService()
                        .getDeliveredBasedOnStatus(currentIndex == 0
                            ? "All"
                            : currentIndex == 1
                                ? "Ongoing"
                                : "Delivered"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      if (snapshot.data?.datum == null) {
                        return Center(child: Text("No orders found."));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.datum?.data!.length ?? 0,
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.datum!.data![index];
                            return OrderDetailCard(
                                data: item,
                                ontap: () => Get.to(() => DeliveryDetailsPage(
                                      data: item,
                                      width: MediaQuery.of(context).size.width,
                                    )));
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
