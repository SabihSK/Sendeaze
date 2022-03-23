import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/pages/delivery/delivery-details-page.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/widgets/app-back-button.dart';
import 'package:sendeaze/widgets/app-divder.dart';
import 'package:sendeaze/widgets/order-detail-card.dart';

class DeliveryHistoryPage extends StatefulWidget {
  static String route = "/pages/delivery/delivery-page";

  @override
  State<DeliveryHistoryPage> createState() => _DeliveryHistoryPageState();
}

class _DeliveryHistoryPageState extends State<DeliveryHistoryPage> {
  int currentIndex = 0;

  Widget tabbar() {
    return TabBar(
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
      indicatorColor: AppColors.RED,
      indicatorWeight: 0.0001,
      unselectedLabelColor: AppColors.GREY,
      labelColor: AppColors.BLACK,
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(isTransparent: true),
              tabbar(),
              // SizedBox(height: 15),
              AppDivider(),
              Expanded(
                child: FutureBuilder<OrderListResponse>(
                    future: OrderService()
                        .getDeliveredBasedOnStatus(currentIndex == 0
                            ? "All"
                            : currentIndex == 1
                                ? "Ongoing"
                                : "Delivered"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      if (snapshot.data?.data == null) {
                        return Center(child: Text("No orders found."));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.data![index];
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
