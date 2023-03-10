import 'analysis_menu_model.dart';

class FooterGetSet {
  String name = "";
  List<AnalysisMenuGetSet> menuItems = List<AnalysisMenuGetSet>.empty(growable: true);

  set setName(String data)
  {
    name = data;
  }

  set setList(List<AnalysisMenuGetSet> dataList)
  {
    menuItems = dataList;
  }
}
