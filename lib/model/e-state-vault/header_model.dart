import 'menu_model.dart';

class HeaderGetSet {
  String name = "";
  List<MenuGetSet> menuItems = List<MenuGetSet>.empty(growable: true);

  set setName(String data)
  {
    name = data;
  }

  set setList(List<MenuGetSet> dataList)
  {
    menuItems = dataList;
  }
}
