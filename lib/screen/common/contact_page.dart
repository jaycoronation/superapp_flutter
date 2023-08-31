import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/CommanResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/responsive.dart';
import '../../widget/loading.dart';

class ContactPage extends StatefulWidget {

  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends BaseState<ContactPage> {
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _validName = true;
  bool _validEmail = true;
  bool _validContact= true;

  bool isSubmitClick = false;

  @override
  void initState() {
    super.initState();

    if (sessionManager.getFullName().toString().isNotEmpty) {
      _nameController.text = checkValidString(sessionManagerPMS.getFristName().toString().trim()) + " " + checkValidString(sessionManagerPMS.getLastName().toString().trim()) ;
    }

    if (sessionManager.getEmail().toString().isNotEmpty) {
      _emailController.text = checkValidString(sessionManagerPMS.getEmail().toString().trim());
    }

    if (sessionManager.getPhoneNo().toString().isNotEmpty) {
      _contactController.text = checkValidString(sessionManager.getPhoneNo().toString().trim());
    }

  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget.isSmallScreen(context)
        ?  Scaffold(
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
                    const Expanded(child: Text("Contact",
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
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validName = false;
                                    } else {
                                      _validName = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    errorText: _validName ? null : "Please enter your name"
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validEmail = false;
                                    } else {
                                      _validEmail = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  errorText: _validEmail ? null : _emailController.text.isNotEmpty ? 'Please enter valid email address' : 'Please enter your email address',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _contactController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validContact = false;
                                    } else {
                                      _validContact = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Contact',
                                    errorText: _validContact ? null : _contactController.text.isNotEmpty ? 'Please enter valid mobile number' : "Please enter your mobile number",
                                    counterText: ''
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
                                controller: _messageController,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                decoration: const InputDecoration(
                                    labelText: 'Message',
                                    alignLabelWithHint: true
                                ),
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
                                    if(_nameController.text.isEmpty) {
                                      setState(() {
                                        _validName = false;
                                        return;
                                      });

                                    } else if(_emailController.text.isEmpty) {
                                      setState(() {
                                        _validEmail = false;
                                        return;
                                      });

                                    } else if(!isValidEmail(_emailController.text)) {
                                      setState(() {
                                        _validEmail = false;
                                        return;
                                      });

                                    } else if(_contactController.text.isEmpty) {
                                      setState(() {
                                        _validContact = false;
                                        return;
                                      });

                                    } else if(_contactController.text.length != 10) {
                                      setState(() {
                                        _validContact = false;
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
    )
        :  Scaffold(
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
                    const Expanded(child: Text("Contact",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18, color: black, fontWeight: FontWeight.w800),
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
                            Container(height: 14,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: 16),
                              ),
                            ),
                            Container(height: 14,),
                            TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isEmpty) {
                                    _validName = false;
                                  } else {
                                    _validName = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey,width: 0.5),
                                  ),
                                fillColor: white,
                                hintText: 'Name',
                                  errorText: _validName ? null : "Please enter your name"
                              ),
                            ),


                            Container(height: 26,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: 16),
                              ),
                            ),
                            Container(height: 14,),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isEmpty) {
                                    _validEmail = false;
                                  } else {
                                    _validEmail = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey,width: 0.5),
                                  ),
                                  fillColor: white,
                                  hintText: 'Email',
                                errorText: _validEmail ? null : _emailController.text.isNotEmpty ? 'Please enter valid email address' : 'Please enter your email address',
                              ),
                            ),



                            Container(height: 26,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Contact",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: 16),
                              ),
                            ),
                            Container(height: 14,),
                            TextField(
                              controller: _contactController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isEmpty) {
                                    _validContact = false;
                                  } else {
                                    _validContact = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(color: Colors.grey,width: 0.5),
                                ),
                                fillColor: white,
                                hintText: 'Contact',
                                  errorText: _validContact ? null : _contactController.text.isNotEmpty ? 'Please enter valid mobile number' : "Please enter your mobile number",
                                  counterText: ''
                              ),
                            ),


                            Container(height: 26,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Message",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: 16),
                              ),
                            ),
                            Container(height: 14,),
                            TextField(
                              controller: _messageController,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              cursorColor: Colors.grey,
                              onChanged: (text) {
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(color: Colors.grey,width: 0.5),
                                  ),
                                  fillColor: white,
                                  hintText: 'Message',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: 16),
                              ),
                            ),

                           /* Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validName = false;
                                    } else {
                                      _validName = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    errorText: _validName ? null : "Please enter your name"
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validEmail = false;
                                    } else {
                                      _validEmail = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  errorText: _validEmail ? null : _emailController.text.isNotEmpty ? 'Please enter valid email address' : 'Please enter your email address',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                              child: TextField(
                                cursorColor: black,
                                controller: _contactController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isEmpty) {
                                      _validContact = false;
                                    } else {
                                      _validContact = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Contact',
                                    errorText: _validContact ? null : _contactController.text.isNotEmpty ? 'Please enter valid mobile number' : "Please enter your mobile number",
                                    counterText: ''
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
                                controller: _messageController,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 15),
                                decoration: const InputDecoration(
                                    labelText: 'Message',
                                    alignLabelWithHint: true
                                ),
                              ),
                            ),*/
                            // const Spacer(),
                            Container(height: 28,),
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 10, ),
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: blue,
                                    onPrimary: blue,
                                    elevation: 0.0,
                                    padding: const EdgeInsets.only(top: 22.0, bottom: 22.0),
                                    // side: const BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
                                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kButtonCornerRadius)),
                                    tapTargetSize: MaterialTapTargetSize.padded,
                                    animationDuration: const Duration(milliseconds: 100),
                                    enableFeedback: true,
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () {
                                    if(_nameController.text.isEmpty) {
                                      setState(() {
                                        _validName = false;
                                        return;
                                      });

                                    } else if(_emailController.text.isEmpty) {
                                      setState(() {
                                        _validEmail = false;
                                        return;
                                      });

                                    } else if(!isValidEmail(_emailController.text)) {
                                      setState(() {
                                        _validEmail = false;
                                        return;
                                      });

                                    } else if(_contactController.text.isEmpty) {
                                      setState(() {
                                        _validContact = false;
                                        return;
                                      });

                                    } else if(_contactController.text.length != 10) {
                                      setState(() {
                                        _validContact = false;
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
                                    style: TextStyle(fontSize: 18, color: white, fontWeight: FontWeight.w500),
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

  @override
  void castStatefulWidget() {
    widget is ContactPage;
  }

  //API call func..
  void saveDetails() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + contactSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().toString().trim(),
      'name': _nameController.value.text.trim(),
      'email' : _emailController.value.text.trim(),
      'contact' : _contactController.value.text.trim(),
      'comments': _messageController.value.text.trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);

      Navigator.pop(context);

      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });

      showSnackBar(dataResponse.message, context);

    }
  }

}