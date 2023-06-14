import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/constant/analysis_api_end_point.dart';
import 'package:superapp/model/CommanResponse.dart';
import 'package:superapp/model/e-state-analysis/aspiration_types_response_model.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class EStateAddFutureExpensePage extends StatefulWidget {
  final ListData dataGetSet;
  final bool isFromList;

  const EStateAddFutureExpensePage(this.dataGetSet, this.isFromList, {Key? key}) : super(key: key);

  @override
  _EStateAddFutureExpensePageState createState() => _EStateAddFutureExpensePageState();
}

class _EStateAddFutureExpensePageState extends BaseState<EStateAddFutureExpensePage> {
  bool _isLoading = false;

  final TextEditingController _aspirationTypeController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _periodicityController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _searchYearController = TextEditingController();
  List<String> listItem = List<String>.empty();
  List<String> _tempListItem = [];

  final TextEditingController _searchAspirationTypeController = TextEditingController();
  List<AspirationTypes> _tempListAspirationType = [];
  List<AspirationTypes> listAspirationTypes = List<AspirationTypes>.empty();

  bool _validAspirationType = true;
  bool _validStartYear = true;
  bool _validEndYear = true;
  bool _validPeriodicity = true;
  bool _validAmount = true;

  var dataGetSet = ListData();

  @override
  void initState() {
    super.initState();

    if(isInternetConnected) {
      getAspirationType();
    }else{
      noInterNet(context);
    }

    dataGetSet = (widget as EStateAddFutureExpensePage).dataGetSet;
    if (dataGetSet.aspirationId.toString().isNotEmpty) {
      _aspirationTypeController.text = checkValidString(dataGetSet.aspirationType.toString());
      _startYearController.text = checkValidString(dataGetSet.startYear.toString());
      _endYearController.text = checkValidString(dataGetSet.endYear.toString());
      _periodicityController.text = checkValidString(dataGetSet.periodicity.toString());
      _amountController.text = checkValidString(dataGetSet.amount.toString());
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
                     Expanded(child: Text((widget as EStateAddFutureExpensePage).isFromList ? "Update Future Expense" : "Add Future Expense",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
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
                                  controller: _aspirationTypeController,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validAspirationType = false;
                                      } else {
                                        _validAspirationType = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Aspiration Type',
                                      errorText: _validAspirationType ? null : "Please select aspiration type for future expense"
                                  ),
                                  onTap: () {
                                    _searchAspirationTypeController.clear();
                                    _tempListAspirationType.clear();
                                    _showAspirationTypeDialog(context);
                                  },
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
                                  controller: _periodicityController,
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validPeriodicity = false;
                                      } else {
                                        _validPeriodicity = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Periodicity',
                                      errorText: _validPeriodicity ? null : "Please select periodicity of expense"
                                  ),
                                  onTap: () {
                                    _showPeriodicityDialog();
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                                child: TextField(
                                  cursorColor: black,
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.isEmpty) {
                                        _validAmount = false;
                                      } else {
                                        _validAmount = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Amount',
                                      errorText: _validAmount ? null : "Please enter expense amount"

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

                                      if(_aspirationTypeController.text.isEmpty) {
                                        setState(() {
                                          _validAspirationType = false;
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

                                      } else if(_periodicityController.text.isEmpty) {
                                        setState(() {
                                          _validPeriodicity = false;
                                          return;
                                        });

                                      } else if(_amountController.text.isEmpty) {
                                        setState(() {
                                          _validAmount = false;
                                          return;
                                        });

                                      } else {
                                        if(isInternetConnected)
                                        {
                                          saveAspirationsFutureExpense();
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


  void _showAspirationTypeDialog(context) {
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
                  child: const Text("Select aspiration type",
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
                        controller: _searchYearController,
                        cursorColor: black,
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: black,),
                        decoration:  InputDecoration(
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
                            state(() {
                              _tempListAspirationType = _buildSearchListForAspirationType(text);
                            });
                          }
                          else
                          {
                            state(() {
                              _searchAspirationTypeController.clear();
                              _tempListAspirationType.clear();
                            });
                          }
                        },
                      ),
                    )),
                Container(height: 6),
                Expanded(
                  child: ListView.builder(
                      itemCount: _tempListAspirationType.isNotEmpty ? _tempListAspirationType.length : listAspirationTypes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: _tempListAspirationType.isNotEmpty
                                ? _showBottomSheetForAspirationType(index, _tempListAspirationType)
                                : _showBottomSheetForAspirationType(index, listAspirationTypes),
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() {
                                if (_tempListAspirationType.isNotEmpty) {
                                  _aspirationTypeController.text = checkValidString(_tempListAspirationType[index].aspirationType.toString());
                                  _validAspirationType = true;
                                } else {
                                  _aspirationTypeController.text = toDisplayCase(listAspirationTypes[index].aspirationType.toString());
                                  _validAspirationType = true;
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

  Widget _showBottomSheetForAspirationType(int index, List<AspirationTypes> listData) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
          alignment: Alignment.centerLeft,
          child: listData[index].aspirationType == _aspirationTypeController.text.toString()
              ? Text(
            checkValidString(toDisplayCase(listData[index].aspirationType.toString())),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blue),
          )
              : Text(
            checkValidString(toDisplayCase(listData[index].aspirationType.toString())),
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

  List<AspirationTypes> _buildSearchListForAspirationType(String userSearchTerm) {
    List<AspirationTypes> _searchList = [];
    for (int i = 0; i < listAspirationTypes.length; i++) {
      String aspirationType = listAspirationTypes[i].aspirationType.toString().toLowerCase();
      if (aspirationType.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(listAspirationTypes[i]);
      }
    }
    return _searchList;
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
                          style: const TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
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
                       /*SingleChildScrollView(
                          child: ListView.builder(
                              itemCount: listItem.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(isFor == "End year") {
                                            _endYearController.text = checkValidString(listItem[index]);
                                          }else {
                                            _startYearController.text = checkValidString(listItem[index]);
                                          }
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
                                        alignment: Alignment.center,
                                        child: Text(checkValidString(listItem[index]),
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                                        ),
                                      ),
                                    ),
                                    const Divider(thickness: 0.5, color: grayLight, endIndent: 16, indent: 16),
                                  ],
                                );
                              }),
                        )*/
                       )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  void _showPeriodicityDialog() {
    List<String> listPeriodicityData = getPeriodicity();

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
                          child: const Text("Select Periodicity",
                            style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,),
                        ),
                        Container(height: 6),
                        Expanded(child: ListView.builder(
                            itemCount: listPeriodicityData.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                          _periodicityController.text = checkValidString(listPeriodicityData[index]);
                                          _validPeriodicity = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8, bottom: 8),
                                      alignment: Alignment.center,
                                      child: Text(checkValidString(listPeriodicityData[index]),
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                                      ),
                                    ),
                                  ),
                                  const Divider(thickness: 0.5, color: grayLight, endIndent: 16, indent: 16),
                                ],
                              );
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
    widget is EStateAddFutureExpensePage;
  }

  //API call func..
  void saveAspirationsFutureExpense() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + aspirationsFutureExpenseSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'aspiration_type': _aspirationTypeController.value.text.trim(),
      'start_year' : _startYearController.value.text.trim(),
      'end_year' : _endYearController.value.text.trim(),
      'periodicity': _periodicityController.value.text.trim(),
      'amount' : _amountController.value.text.trim(),
      'aspiration_id' : (widget as EStateAddFutureExpensePage).isFromList ? dataGetSet.aspirationId.toString() : '',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
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

  void getAspirationType() async {
    // setState(() {
    //   _isLoading = true;
    // });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + aspirationTypes);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AspirationTypesResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      listAspirationTypes = dataResponse.aspirationTypes!;

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