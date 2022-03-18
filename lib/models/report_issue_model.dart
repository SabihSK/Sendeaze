class ReportIssueModel {
  ReportIssueModel({
    this.code,
    this.message,
    this.error,
    this.data,
  });

  String? code;
  String? message;
  dynamic error;
  ReportIssueData? data;

  factory ReportIssueModel.fromJson(Map<String?, dynamic> json) =>
      ReportIssueModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"],
        data: json["data"] == null
            ? null
            : ReportIssueData.fromJson(json["data"]),
      );
}

class ReportIssueData {
  ReportIssueData({
    this.driverId,
    this.subject,
    this.content,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.driverName,
    this.driverEmail,
  });

  num? driverId;
  String? subject;
  String? content;
  var createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;
  String? driverName;
  String? driverEmail;

  factory ReportIssueData.fromJson(Map<String?, dynamic> json) =>
      ReportIssueData(
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        subject: json["subject"] == null ? null : json["subject"],
        content: json["content"] == null ? null : json["content"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        id: json["id"] == null ? null : json["id"],
        driverName: json["driver_name"] == null ? null : json["driver_name"],
        driverEmail: json["driver_email"] == null ? null : json["driver_email"],
      );
}
