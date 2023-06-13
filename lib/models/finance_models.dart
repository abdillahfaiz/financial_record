// ignore_for_file: public_member_api_docs, sort_constructors_first
class FinanceData {
  final List<FinanceModel>? financeData;
  FinanceData({
    this.financeData,
  });

  factory FinanceData.fromJson(Map<String, dynamic> json) {
    return FinanceData(
        financeData: List<FinanceModel>.from(
                json["data"].map((e) => FinanceModel.fromJson(e))) ??
            []);
  }


  @override
  String toString() => 'FinanceData(financeData: $financeData)';
}

class FinanceModel {
  int id;
  String title;
  int counted;
  String category;

  FinanceModel({
    required this.id,
    required this.title,
    required this.counted,
    required this.category,
  });

  factory FinanceModel.fromJson(Map<String, dynamic> json) {
    return FinanceModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        counted: json["counted"] ?? 0,
        category: json["category"] ?? '');
  }

  @override
  String toString() {
    return 'FinanceModel(id: $id, title: $title, counted: $counted, category: $category)';
  }
}
