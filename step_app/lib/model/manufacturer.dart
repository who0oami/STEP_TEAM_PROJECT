// ignore_for_file: non_constant_identifier_names

class Manufacturer {
  int? manufacturer_id;             // 제조사ID_자동 증가 Primary Key
  String manufacturer_name;          // 제조사명
  String manufacturer_phone;         // 담당자 연락처

  Manufacturer(
    {
      this.manufacturer_id,
      required this.manufacturer_name,
      required this.manufacturer_phone,
    }
  );

  Manufacturer.fromMap(Map<String, dynamic> res)
  : manufacturer_id = res['manufacturer_id'],
    manufacturer_name = res['manufacturer_name'],
    manufacturer_phone = res['manufacturer_phone'];
}