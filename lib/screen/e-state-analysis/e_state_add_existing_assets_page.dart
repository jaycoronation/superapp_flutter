import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/aspiration_types_response_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/existing_assets_response_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/investment_type_response_model.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class EStateAddExistingAssetsPage extends StatefulWidget {
  final ExistingAssets dataGetSet;
  final bool isFromList;

  const EStateAddExistingAssetsPage(this.dataGetSet, this.isFromList, {Key? key}) : super(key: key);

  @override
  _EStateAddExistingAssetsPageState createState() => _EStateAddExistingAssetsPageState();
}

class _EStateAddExistingAssetsPageState extends BaseState<EStateAddExistingAssetsPage> {
  bool _isLoading = false;

  final TextEditingController _investmentTypeController = TextEditingController();
  final TextEditingController _assetsTypeController = TextEditingController();
  final TextEditingController _currentValueController = TextEditingController();

  final TextEditingController _searchInvestmentTypeController = TextEditingController();
  List<InvestmentTypes> _tempListInvestmentTypes = [];
  List<InvestmentTypes> listInvestmentTypes = List<InvestmentTypes>.empty();

  bool _validInvestementType = true;
  bool _validCurrentValue = true;

  var dataGetSet = ExistingAssets();

  @override
  void initState() {
    super.initState();

    dataGetSet = (widget as EStateAddExistingAssetsPage).dataGetSet;

    if (dataGetSet.existingAssetsId.toString().isNotEmpty) {
      _investmentTypeController.text = checkValidString(dataGetSet.investmentType.toString());
      _assetsTypeController.text = checkValidString(dataGetSet.assetType.toString());
      _currentValueController.text = checkValidString(dataGetSet.currentValue.toString());
    }

    if(isInternetConnected) {
      getData();
    }else{
      noInterNet(context);
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
                     Expanded(child: Text((widget as EStateAddExistingAssetsPage).isFromList ? "Update Existing Assets" : "Add Existing Assets",
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
                                  controller: _investmentTypeController,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validInvestementType = false;
                                      } else {
                                        _validInvestementType = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Investment Type',
                                      errorText: _validInvestementType ? null : "Please select investment type"
                                  ),
                                  onTap: () {
                                    _searchInvestmentTypeController.clear();
                                    _tempListInvestmentTypes.clear();
                                    _showInvestmentTypeDialog(context);
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
                                      foregroundColor: blue, backgroundColor: blue,
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

                                      if(_investmentTypeController.text.isEmpty) {
                                        setState(() {
                                          _validInvestementType = false;
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

  void _showInvestmentTypeDialog(context) {
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
                  child: const Text("Select Investment Type",
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
                        controller: _searchInvestmentTypeController,
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
                          if(text.isNotEmpty) {
                            state(() {
                              _tempListInvestmentTypes = _buildSearchListForInvestmentType(text);
                            });

                          } else {
                            state(() {
                              _searchInvestmentTypeController.clear();
                              _tempListInvestmentTypes.clear();
                            });
                          }
                        },
                      ),
                    )),
                Container(height: 6),
                Expanded(
                  child: ListView.builder(
                      itemCount: _tempListInvestmentTypes.isNotEmpty ? _tempListInvestmentTypes.length : listInvestmentTypes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: _tempListInvestmentTypes.isNotEmpty
                                ? _showBottomSheetForInvestmentTypes(index, _tempListInvestmentTypes)
                                : _showBottomSheetForInvestmentTypes(index, listInvestmentTypes),
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() {
                                if (_tempListInvestmentTypes.isNotEmpty) {
                                  _investmentTypeController.text = checkValidString(_tempListInvestmentTypes[index].investmentType.toString());
                                  _assetsTypeController.text = checkValidString(_tempListInvestmentTypes[index].assetType.toString());
                                  _validInvestementType = true;
                                } else {
                                  _investmentTypeController.text = toDisplayCase(listInvestmentTypes[index].investmentType.toString());
                                  _assetsTypeController.text = checkValidString(listInvestmentTypes[index].assetType.toString());
                                  _validInvestementType = true;
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

  Widget _showBottomSheetForInvestmentTypes(int index, List<InvestmentTypes> listData) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
          alignment: Alignment.centerLeft,
          child: listData[index].investmentType == _investmentTypeController.text.toString()
              ? Text(
            checkValidString(toDisplayCase(listData[index].investmentType.toString().trim())),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blue),
          )
              : Text(
            checkValidString(toDisplayCase(listData[index].investmentType.toString().trim())),
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

  List<InvestmentTypes> _buildSearchListForInvestmentType(String userSearchTerm) {
    List<InvestmentTypes> _searchList = [];
    for (int i = 0; i < listInvestmentTypes.length; i++) {
      String investmentType = listInvestmentTypes[i].investmentType.toString().toLowerCase();
      if (investmentType.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(listInvestmentTypes[i]);
      }
    }
    return _searchList;
  }

  @override
  void castStatefulWidget() {
    widget is EStateAddExistingAssetsPage;
  }

  //API call func..
  void saveDetails() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + existingAssetsSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'investment_type': _investmentTypeController.value.text.trim(),
      'asset_type' : _assetsTypeController.value.text.trim(),
      'current_value' : _currentValueController.value.text.trim(),
      'existing_assets_id' : (widget as EStateAddExistingAssetsPage).isFromList ? dataGetSet.existingAssetsId.toString() : '',
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
      'module':(widget as EStateAddExistingAssetsPage).isFromList ? "edit-existing_assets" : "add-existing_assets",
      'user_id':sessionManager.getUserId().toString().trim(),
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

    final url = Uri.parse(API_URL_ANALYSIS + investmentTypes);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = InvestmentTypeResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      listInvestmentTypes = dataResponse.investmentTypes!;
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