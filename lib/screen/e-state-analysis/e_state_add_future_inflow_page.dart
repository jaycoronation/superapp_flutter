import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/aspiration_types_response_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/future_inflow_list_reponse_model.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class EStateAddFutureInflowPage extends StatefulWidget {
  final FutureInflows dataGetSet;
  final bool isFromList;

  const EStateAddFutureInflowPage(this.dataGetSet, this.isFromList, {Key? key}) : super(key: key);

  @override
  _EStateAddFutureInflowPageState createState() => _EStateAddFutureInflowPageState();
}

class _EStateAddFutureInflowPageState extends BaseState<EStateAddFutureInflowPage> {
  bool _isLoading = false;

  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expectedGrowthController = TextEditingController();


  final TextEditingController _searchYearController = TextEditingController();
  List<String> listItem = List<String>.empty();
  List<String> _tempListItem = [];


  bool _validSource = true;
  bool _validStartYear = true;
  bool _validEndYear = true;
  bool _validExpectedGrowth = true;

  var dataGetSet = FutureInflows();

  @override
  void initState() {
    super.initState();

    dataGetSet = (widget as EStateAddFutureInflowPage).dataGetSet;
    if (dataGetSet.futureInflowId.toString().isNotEmpty) {
      _sourceController.text = checkValidString(dataGetSet.source.toString());
      _startYearController.text = checkValidString(dataGetSet.startYear.toString());
      _endYearController.text = checkValidString(dataGetSet.endYear.toString());
      _amountController.text = checkValidString(dataGetSet.amount.toString());
      _expectedGrowthController.text = checkValidString(dataGetSet.expectedGrowth.toString());
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle((widget as EStateAddFutureInflowPage).isFromList ? "Update Future Inflow" : "Add Future Inflow",),
          centerTitle: true,
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
                                  controller: _sourceController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validSource = false;
                                      } else {
                                        _validSource = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Source',
                                      errorText: _validSource ? null : "Please enter future inflow source"
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                      child: TextField(
                                        cursorColor: black,
                                        controller: _startYearController,
                                        readOnly: true,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                        onChanged: (text) {
                                          setState(() {
                                            if (text.isEmpty) {
                                              _validStartYear = false;
                                            } else {
                                              _validStartYear = true;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Start Year',
                                            errorText: _validStartYear ? null : "Please select start year"
                                        ),
                                        onTap: () {
                                          DateTime nowDate = DateTime.now();
                                          int currYear = nowDate.year;
                                          _showStartYearDialog(currYear, "Start year");
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                      child: TextField(
                                        cursorColor: black,
                                        controller: _endYearController,
                                        readOnly: true,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                        onChanged: (text) {
                                          setState(() {
                                            if (text.isEmpty) {
                                              _validEndYear = false;
                                            } else {
                                              _validEndYear = true;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'End year',
                                            errorText: _validEndYear ? null : "Please select end year"
                                        ),
                                        onTap: () {
                                          if (_startYearController.text.isNotEmpty) {
                                            _showStartYearDialog(int.parse(_startYearController.value.text.toString().trim()), "End year");
                                          }else {
                                            showSnackBar("Please select start year", context);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  decoration: InputDecoration(
                                      labelText: 'Amount',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _expectedGrowthController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validExpectedGrowth = false;
                                      } else {
                                        _validExpectedGrowth = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Expected Growth(In %)',
                                      errorText: _validExpectedGrowth ? null : "Please enter expected growth"
                                  ),
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

                                      if(_sourceController.text.isEmpty) {
                                        setState(() {
                                          _validSource = false;
                                          return;
                                        });

                                      } else if(_startYearController.text.isEmpty) {
                                        setState(() {
                                          _validStartYear = false;
                                          return;
                                        });

                                      } else if(_endYearController.text.isEmpty) {
                                        setState(() {
                                          _validEndYear = false;
                                          return;
                                        });

                                      } else if(_expectedGrowthController.text.isEmpty) {
                                        setState(() {
                                          _validExpectedGrowth = false;
                                          return;
                                        });

                                      } else {
                                        if(isOnline)
                                        {
                                          saveDetails();
                                          FocusScope.of(context).unfocus();
                                        }
                                        else
                                        {
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

  void _showStartYearDialog(int year, String isFor) {
    _searchYearController.clear();

    if(isFor == "End year") {
      listItem = getYear(year+1);
    }else {
      listItem = getYear(year);
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 60,
                            child: const Divider(height: 1.5, thickness: 1.5, color: blue,)),
                        Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 12),
                        // padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                        child: Text("Select $isFor",
                          style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
                          textAlign: TextAlign.center,),
                      ),
                        const Gap(10),
                        Card(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // if you need this
                            ),
                            elevation: 0,
                            child: SizedBox(
                              width: double.infinity,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.sentences,
                                textAlign: TextAlign.start,
                                controller: _searchYearController,
                                cursorColor: black,
                                maxLength: 4,
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: black,),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration:  InputDecoration(
                                  counterText: '',
                                  hintText: "Search...",
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
                                    setState(() {
                                      _tempListItem = _buildSearchListForYear(text);
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      _searchYearController.clear();
                                      _tempListItem.clear();
                                    });
                                  }
                                },
                              ),
                            )),
                        Container(height: 6),
                        Expanded(child:ListView.builder(
                           itemCount: (_tempListItem.isNotEmpty) ? _tempListItem.length : listItem.length,
                           itemBuilder: (context, index) {
                             return InkWell(
                                 child: (_tempListItem.isNotEmpty)
                                     ? _showBottomSheetForStartYear(
                                     index, _tempListItem)
                                     : _showBottomSheetForStartYear(
                                     index, listItem),
                                 onTap: () {
                                   setState(() {
                                     if(_tempListItem != null && _tempListItem.length > 0)
                                     {
                                       if(isFor == "End year") {
                                         _endYearController.text = _tempListItem[index];
                                         _validEndYear = true;
                                       }else {
                                         _startYearController.text = _tempListItem[index];
                                         _validStartYear = true;
                                         _endYearController.text = '';
                                         _validEndYear = false;
                                       }
                                     }
                                     else
                                     {
                                       if(isFor == "End year") {
                                         _endYearController.text = listItem[index];
                                         _validEndYear = true;
                                       }else {
                                         _startYearController.text = listItem[index];
                                         _validStartYear = true;
                                         _endYearController.text = '';
                                         _validEndYear = false;
                                       }
                                     }
                                     Navigator.of(context).pop();
                                   });
                                 });
                           })
                       )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _showBottomSheetForStartYear(int index, List<String> listData) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8,bottom: 8),
          alignment: Alignment.center,
          child: Text(listData[index],
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: black),),
        ),
        const Divider(thickness: 0.5, color: grayLight, endIndent: 16, indent: 16,)
      ],
    );
  }

  List<String> _buildSearchListForYear(String userSearchTerm) {
    List<String> _searchList = [];
    for (int i = 0; i < listItem.length; i++) {
      String year = listItem[i];
      if (year.contains(userSearchTerm)) {
        _searchList.add(listItem[i]);
      }
    }
    return _searchList;
  }

  @override
  void castStatefulWidget() {
    widget is EStateAddFutureInflowPage;
  }

  //API call func..
  void saveDetails() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + futureInflowSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'source': _sourceController.value.text.trim(),
      'start_year' : _startYearController.value.text.trim(),
      'end_year' : _endYearController.value.text.trim(),
      'expected_growth': _expectedGrowthController.value.text.trim(),
      'amount' : _amountController.value.text.trim(),
      'future_inflow_id' : (widget as EStateAddFutureInflowPage).isFromList ? dataGetSet.futureInflowId.toString() : '',
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
      'module':(widget as EStateAddFutureInflowPage).isFromList ? "edit-future_inflow" : "add-future_inflow",
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


}