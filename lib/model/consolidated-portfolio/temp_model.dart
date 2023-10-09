import 'TempResponse.dart';
class TempModel {
  String name = "";
  List<TempResponse> menuItems = List<TempResponse>.empty(growable: true);

  set setName(String data)
  {
    name = data;
  }

  set setList(List<TempResponse> dataList)
  {
    menuItems = dataList;
  }
}
