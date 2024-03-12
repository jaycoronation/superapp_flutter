import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superapp_flutter/constant/colors.dart';

import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  BaseState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends BaseState<EditProfilePage> {

  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  bool _validName = true;
  bool _validEmail = true;
  bool _validContact= true;

  String pickImgSelectedPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 8),
              child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
            )
        ),
        title: const Text("Profile",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: white,
      ),
      body: Padding(
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
                          margin: const EdgeInsets.only(top: 10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showImageActionDialog();
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    width: 120,
                                    height: 120,
                                    child: /*pickImgSelectedPath.isNotEmpty
                                        ? Image.file(File(pickImgSelectedPath), fit: BoxFit.cover)
                                        : sessionManagerVault.getProfilePic().toString().isNotEmpty
                                        ? FadeInImage.assetNetwork(
                                          image: sessionManager.getProfilePic().toString() + "&h=500&zc=2",
                                          fit: BoxFit.cover,
                                          placeholder: 'assets/images/ic_user_placeholder.png',
                                        )
                                        : Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover)*/
                                    Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -8,
                                bottom: -8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1), //color of shadow
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 9, // blur radius
                                        offset: const Offset(0, 2), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  height: 36.0,
                                  width: 36.0,
                                  child: Center(
                                    child: IconButton(
                                      icon: Image.asset("assets/images/ic_edit_pencil_new.png", width: 36, height: 36, color: black),
                                      onPressed: () {
                                        showImageActionDialog();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 22),
                          child: TextField(
                            cursorColor: black,
                            controller: nameController,
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
                            controller: emailController,
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
                              errorText: _validEmail
                                  ? null
                                  : emailController.text.isNotEmpty
                                  ? 'Please enter valid email address'
                                  : 'Please enter your email address',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: TextField(
                            cursorColor: black,
                            controller: contactController,
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
                                errorText: _validContact
                                    ? null
                                    : contactController.text.isNotEmpty
                                    ? 'Please enter valid mobile number'
                                    : "Please enter your mobile number",
                                counterText: ''
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],

                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 22, ),
                          width: double.infinity,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                        side: const BorderSide(width: 1,color: blue)
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(blue)
                              ),
                              onPressed: () {
                                if(nameController.text.isEmpty) {
                                  setState(() {
                                    _validName = false;
                                    return;
                                  });

                                } else if(emailController.text.isEmpty) {
                                  setState(() {
                                    _validEmail = false;
                                    return;
                                  });

                                } else if(!isValidEmail(emailController.text)) {
                                  setState(() {
                                    _validEmail = false;
                                    return;
                                  });

                                } else if(contactController.text.isEmpty) {
                                  setState(() {
                                    _validContact = false;
                                    return;
                                  });

                                } else if(contactController.text.length != 10) {
                                  setState(() {
                                    _validContact = false;
                                    return;
                                  });

                                } else {
                                  if(isInternetConnected) {
                                    //saveDetails();
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    noInterNet(context);
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                                ),
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
      ),
    );
  }

  void showImageActionDialog() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: 2, width: 40, color: black, margin: const EdgeInsets.only(bottom: 12)),
                    const Text(
                      "Select Image From?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(height: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_camera.png', height: 26, width: 26),
                            Container(width: 15),
                            const Text(
                              "Camera",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: grayLight,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        pickImageFromGallery();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_gallery.png', height: 26, width: 26),
                            Container(width: 15),
                            const Text(
                              "Gallery",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 12)
                  ],
                ))
          ],
        );
      },
    );
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 80);
      if (pickedfiles != null) {
        final filePath = pickedfiles.path;
        _cropImage(filePath);
      } else {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
      if (pickedfiles != null) {
        final filePath = pickedfiles.path;
        _cropImage(filePath);
      } else {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: filePath,compressQuality: 80,);
    if (croppedFile != null) {
      setState(() {
        pickImgSelectedPath = croppedFile.path;
        print("_pickImage picImgPath crop ====>$pickImgSelectedPath");
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is EditProfilePage;
  }

}