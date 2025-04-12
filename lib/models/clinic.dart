class ClinicModel {
  String clinicId;
  String clinicName;
  String phoneNumber;
  String address;
  String googleMap;
  String clinicThumbnail;

  ClinicModel({
    required this.clinicId,
    required this.clinicName,
    required this.phoneNumber,
    required this.address,
    required this.googleMap,
    required this.clinicThumbnail,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      clinicId: json['clinic_id'],
      clinicName: json['clinic_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      googleMap: json['google_map'],
      clinicThumbnail: json['clinic_thumbnail'],
    );
  }
}