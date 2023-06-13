// ignore_for_file: public_member_api_docs, sort_constructors_first
class FinanceTotalModel {
  final int? data;
  FinanceTotalModel({
    this.data,
  });

  factory FinanceTotalModel.fromJson(Map<String, dynamic> json){
    return FinanceTotalModel(
      data: json["data"] ?? ''
    );
  }


  @override
  String toString() => 'FinanceTotalModel(data: $data)';
}
