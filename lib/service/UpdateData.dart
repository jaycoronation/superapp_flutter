import 'package:flutter/foundation.dart';

class UpdateData with ChangeNotifier, DiagnosticableTreeMixin {
  String _selectedApplicant = "";

  String get selectedApplicant => _selectedApplicant;

  void setSelectedApplicant(String data) {
    _selectedApplicant = data;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedApplicant', selectedApplicant));
  }
}