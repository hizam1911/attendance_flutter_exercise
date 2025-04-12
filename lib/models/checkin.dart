class QRModel {
  String qrValue;
  String qrValidDate;

  QRModel({
    required this.qrValue,
    required this.qrValidDate,
  });

  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      qrValue: json['qrcode_value'],
      qrValidDate: json['qrcode_valid_date'],
    );
  }
}