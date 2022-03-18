import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/models/orders-list-response.dart';
import 'package:sendeaze/pages/delivery/delivery-details-page.dart';
import 'package:sendeaze/pages/home-page.dart';
import 'package:sendeaze/services/orders/orders-services.dart';
import 'package:sendeaze/widgets/app-bar-widget.dart';
import 'package:sendeaze/widgets/app-divder.dart';
import 'package:sendeaze/widgets/order-detail-card.dart';
import 'package:sendeaze/widgets/statistics-card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RefreshIndicator(
          onRefresh: _refreshList,
          child: Column(
            children: [
              SizedBox(height: 15),
              AppBarWidget(),
              SizedBox(height: 15),
              StatisticsCard(),
              // SizedBox(height: 15),
              // AppDivider(),
              Expanded(
                child: FutureBuilder<OrderListResponse>(
                    future: OrderService().getDeliveries(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      if (snapshot.data == null ||
                          snapshot.data!.error != null) {
                        return Center(child: Text("No orders found."));
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return OrderDetailCard(
                              data: snapshot.data?.data![index],
                              ontap: () => Get.to(() => DeliveryDetailsPage(
                                  data: snapshot.data?.data![index])),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _refreshList() async {
    Get.offAll(HomePage(), transition: Transition.zoom);
  }
}
