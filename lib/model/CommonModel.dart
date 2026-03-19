class CommonValueModel{
  String title;
  String description;
  String image;
  String id;

  CommonValueModel({
    required this.title,
    required this.description,
    required this.image,
    required this.id
  });
}

class TabModel{
  String id;
  String title;

  TabModel({
    required this.id,
    required this.title
  });
}

class MonthlyTransaction {
  final String schemeName;
  final String folioNo;
  final String applicant;
  final Map<String, double> monthlyAmounts;

  final bool isHeader;
  final bool isTotal;

  MonthlyTransaction({
    required this.schemeName,
    required this.folioNo,
    required this.applicant,
    required this.monthlyAmounts,
    this.isHeader = false,
    this.isTotal = false,
  });
}
