class ScanDetailsModel {
  ScanDetailsModel({
    this.clientId,
    this.clientName,
    this.pickupLocation,
    this.info,
    this.boxesQuantity,
  });

  var clientId;
  String? clientName;
  String? pickupLocation;
  List<Info>? info;
  BoxesQuantity? boxesQuantity;

  factory ScanDetailsModel.fromJson(dynamic json) => ScanDetailsModel(
        clientId: json == null ? null : json["client_id"],
        clientName: json == null ? null : json["client_name"],
        pickupLocation: json == null ? null : json["pickup_location"],
        info: json == null
            ? null
            : List<Info>.from(json["info"].map((x) => Info.fromJson(x))),
        boxesQuantity: json == null
            ? null
            : BoxesQuantity.fromJson(json["boxes_quantity"]),
      );
}

class BoxesQuantity {
  BoxesQuantity({
    this.s,
    this.m,
    this.l,
  });

  int? s;
  int? m;
  int? l;

  factory BoxesQuantity.fromJson(Map<String?, dynamic> json) => BoxesQuantity(
        s: json["S"] == null ? null : json["S"],
        m: json["M"] == null ? null : json["M"],
        l: json["L"] == null ? null : json["L"],
      );
}

class Info {
  Info({this.id, this.boxClientId, this.isSelected=false});

  int? id;
  String? boxClientId;
  bool isSelected;
  factory Info.fromJson(Map<String?, dynamic> json) => Info(
        id: json["id"] == null ? null : json["id"],
        boxClientId:
            json["box_client_id"] == null ? null : json["box_client_id"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "box_client_id": boxClientId == null ? null : boxClientId,
      };
}
