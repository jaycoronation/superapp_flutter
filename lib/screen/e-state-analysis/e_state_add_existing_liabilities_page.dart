import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/existing_liabilities_response_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/liabilities_response_model.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class EStateAddExistingLiabilitiesPage extends StatefulWidget {
  final ExistingLiabilities dataGetSet;
  final bool isFromList;

  const EStateAddExistingLiabilitiesPage(this.dataGetSet, this.isFromList, {Key? key}) : super(key: key);

  @override
  _EStateAddExistingLiabilitiesPageState createState() => _EStateAddExistingLiabilitiesPageState();
}

class _EStateAddExistingLiabilitiesPageState extends BaseState<EStateAddExistingLiabilitiesPage> {
  bool _isLoading = false;

  final TextEditingController _liabilityTypeController = TextEditingController();
  final TextEditingController _assetsTypeController = TextEditingController();
  final TextEditingController _currentValueController = TextEditingController();

  final TextEditingController _searchLiabilitiesController = TextEditingController();
  List<Liabilities> _tempListLiabilities = [];
  List<Liabilities> listLiabilities = List<Liabilities>.empty();

  bool _validLiabilityType = true;
  bool _validCurrentValue = true;

  var dataGetSet = ExistingLiabilities();

  @override
  void initState() {
    super.initState();

    if(isInternetConnected) {
      getData();
    }else{
      noInterNet(context);
    }

    dataGetSet = (widget as EStateAddExistingLiabilitiesPage).dataGetSet;
    if (dataGetSet.liabilityType.toString().isNotEmpty) {
      _liabilityTypeController.text = checkValidString(dataGetSet.liabilityType.toString());
      _assetsTypeController.text = checkValidString(dataGetSet.assetType.toString());
      _currentValueController.text = checkValidString(dataGetSet.currentValue.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(right: 8),
                          child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
                        )),
                     Expanded(child: Text((widget as EStateAddExistingLiabilitiesPage).isFromList ? "Update Existing Liabilities" : "Add Existing Liabilities",
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: _isLoading
            ? const LoadingWidget()
            : SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 15, left: 12),
                                child: const Text("Enter Following Data:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _liabilityTypeController,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validLiabilityType = false;
                                      } else {
                                        _validLiabilityType = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Liability Type',
                                      errorText: _validLiabilityType ? null : "Please select liability type"
                                  ),
                                  onTap: () {
                                    _searchLiabilitiesController.clear();
                                    _tempListLiabilities.clear();
                                    _showLiabilityTypeDialog(context);
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _assetsTypeController,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  decoration: const InputDecoration(
                                      labelText: 'Assets Type',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _currentValueController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validCurrentValue = false;
                                      } else {
                                        _validCurrentValue = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Current Value',
                                      errorText: _validCurrentValue ? null : "Please enter current value"
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: blue,
                                      onPrimary: blue,
                                      elevation: 0.0,
                                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      side: const BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kButtonCornerRadius)),
                                      tapTargetSize: MaterialTapTargetSize.padded,
                                      animationDuration: const Duration(milliseconds: 100),
                                      enableFeedback: true,
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () {
                                      if(_liabilityTypeController.text.isEmpty) {
                                        setState(() {
                                          _validLiabilityType = false;
                                          return;
                                        });

                                      } else if(_currentValueController.text.isEmpty) {
                                        setState(() {
                                          _validCurrentValue = false;
                                          return;
                                        });

                                      } else {
                                        if(isInternetConnected) {
                                          saveDetails();
                                          FocusScope.of(context).unfocus();
                                        } else {
                                          noInterNet(context);
                                        }
                                      }
                                    },
                                    onLongPress: () => {},
                                    child: const Text("Submit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
          ),)
    );
  }

  void _showLiabilityTypeDialog(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.88,
              child: Column(children: [
                Container(
                    width: 60,
                    margin: const EdgeInsets.only(top: 12),
                    child: const Divider(
                      height: 1.5,
                      thickness: 1.5,
                      color: blue,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: const Text("Select Liabilities Type",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: black),
                  ),
                ),
                Gap(10),
                Card(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // if you need this
                    ),
                    elevation: 0,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        controller: _searchLiabilitiesController,
                        cursorColor: black,
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: black,),
                        decoration:  InputDecoration(
                          labelText: "Search...",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: lightBlue, width: 0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: lightBlue, width: 0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: black,
                          ),

                        ),
                        enabled: true,
                        onChanged: (text) {
                          if(text.isNotEmpty)
                          {
                            state(() {
                              _tempListLiabilities = _buildSearchListForILiabilities(text);
                            });
                          }
                          else
                          {
                            state(() {
                              _searchLiabilitiesController.clear();
                              _tempListLiabilities.clear();
                            });
                          }
                        },
                      ),
                    )),
                Container(height: 6),
                Expanded(
                  child: ListView.builder(
                      itemCount: _tempListLiabilities.isNotEmpty ? _tempListLiabilities.length : listLiabilities.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: _tempListLiabilities.isNotEmpty
                                ? _showBottomSheetForLiabilities(index, _tempListLiabilities)
                                : _showBottomSheetForLiabilities(index, listLiabilities),
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() {
                                if (_tempListLiabilities.isNotEmpty) {
                                  _liabilityTypeController.text = checkValidString(_tempListLiabilities[index].liability.toString());
                                  _assetsTypeController.text = checkValidString(_tempListLiabilities[index].assetType.toString());
                                  _validLiabilityType = true;
                                } else {
                                  _liabilityTypeController.text = toDisplayCase(listLiabilities[index].liability.toString());
                                  _assetsTypeController.text = checkValidString(listLiabilities[index].assetType.toString());

                                  _validLiabilityType = true;
                                }
                              });
                            });
                      }),
                ),
              ]),
            );
          });
        });
  }

  Widget _showBottomSheetForLiabilities(int index, List<Liabilities> listData) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
          alignment: Alignment.centerLeft,
          child: listData[index].liability == _liabilityTypeController.text.toString()
              ? Text(
            checkValidString(toDisplayCase(listData[index].liability.toString().trim())),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blue),
          )
              : Text(
            checkValidString(toDisplayCase(listData[index].liability.toString().trim())),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const Divider(
          thickness: 0.5,
          color: grayLight,
          endIndent: 16,
          indent: 16,
        )
      ],
    );
  }

  List<Liabilities> _buildSearchListForILiabilities(String userSearchTerm) {
    List<Liabilities> _searchList = [];
    for (int i = 0; i < listLiabilities.length; i++) {
      String liabilitiesType = listLiabilities[i].liability.toString().toLowerCase();
      if (liabilitiesType.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(listLiabilities[i]);
      }
    }
    return _searchList;
  }

  @override
  void castStatefulWidget() {
    widget is EStateAddExistingLiabilitiesPage;
  }

  //API call func..
  void saveDetails() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + existingLiabilitiesSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'liability_type': _liabilityTypeController.value.text.trim(),
      'asset_type' : _assetsTypeController.value.text.trim(),
      'current_value' : _currentValueController.value.text.trim(),
      'existing_liability_id' : (widget as EStateAddExistingLiabilitiesPage).isFromList ? dataGetSet.existingLiabilityId.toString() : '',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      lastInsertedModule();
      Navigator.pop(context, "success");

      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


  void lastInsertedModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module':(widget as EStateAddExistingLiabilitiesPage).isFromList ? "edit-future_expense" : "add-future_expense",
      'user_id':sessionManagerPMS.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

    } else {

    }
  }



  void getData() async {
    // setState(() {
    //   _isLoading = true;
    // });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + liabilities);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = LiabilitiesResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      listLiabilities = dataResponse.liabilities!;

      // setState(() {
      //   _isLoading = false;
      // });

    }else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }

  }

}