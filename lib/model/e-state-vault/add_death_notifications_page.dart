import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superapp/constant/colors.dart';
import 'package:superapp/utils/app_utils.dart';
import 'package:superapp/utils/my_toolbar.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import 'DeathNotificationResponse.dart';

class AddDeathNotificationPage extends StatefulWidget {
  Notifications notifications;
  final bool isForEdit;

  AddDeathNotificationPage(this.notifications, this.isForEdit, {Key? key}) : super(key: key);

  @override
  BaseState<AddDeathNotificationPage> createState() => _AddDeathNotificationPageState();
}

class _AddDeathNotificationPageState extends BaseState<AddDeathNotificationPage> {
  bool _isLoading = false;
  bool isForEdit = false;
  bool isSubmitClick = false;
  var itemData = Notifications();
  List<Notifications> listData = List<Notifications>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    isForEdit = (widget as AddDeathNotificationPage).isForEdit;
    if(isForEdit)
    {
        itemData = (widget as AddDeathNotificationPage).notifications;
        itemData.nameController.text = checkValidString(itemData.name.toString().trim());
        itemData.phoneController.text = checkValidString(itemData.phone.toString().trim());
        itemData.emailController.text = checkValidString(itemData.email.toString().trim());
        itemData.addressController.text = checkValidString(itemData.address.toString().trim());
        addMoreViews(itemData);
    }
    else
    {
        addMoreViews(Notifications());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title:  MyToolBar(pageName: isForEdit ? "Update Death Notification" : "Add Death Notifications"),
          centerTitle: false,
          elevation: 0,
          backgroundColor: appBg,
        ),
        body: _isLoading ? const LoadingWidget() : setData());
  }

  SafeArea setData() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                listItemData(),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
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
                        setState(() {
                          isSubmitClick = true;
                          return;
                        });
                         if (!isValidData()) {
                          setState(() {
                            showSnackBar(isValidDataMsg(), context);
                            return;
                          });
                        } else {

                          _makeJsonData();
                         /* if (isInternetConnected) {
                            _saveProjectCall();
                            FocusScope.of(context).unfocus();
                          } else {
                            noInterNet(context);
                          }*/
                        }
                      }, //set both onPressed and onLongPressed to null to see the disabled properties
                      onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                      child: const Text("Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Column listItemData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: const Text(
            "Enter details of people to be informed on death",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: listData.length,
            itemBuilder: (ctx, index) => (GestureDetector(
                onTap: () async {},
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  color: white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].nameController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setName = text;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          cursorColor: black,
                          controller: listData[index].phoneController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPhone = text;
                            });
                          },
                          decoration: const InputDecoration(
                            counterText: "",
                            labelText: 'Mobile Number',
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: black,
                          controller: listData[index].emailController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPhone = text;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          cursorColor: black,
                          controller: listData[index].addressController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAddress = text;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      index == 0
                          ? Container()
                          : Container(
                        margin: const EdgeInsets.only(top: 12, left: 10),
                        height: 26,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: white,
                              //button's fill color
                              onPrimary: white,
                              //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                              elevation: 0.0,
                              //buttons Material shadow
                              //specify the button's text TextStyle
                              side: const BorderSide(color: blue, width: 0.7, style: BorderStyle.solid),
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              //set border for the button
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              // set the buttons shape. Make its birders rounded etc
                              tapTargetSize: MaterialTapTargetSize.padded,
                              // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                              animationDuration: const Duration(milliseconds: 100),
                              //the buttons animations duration
                              enableFeedback: true,
                              //to set the feedback to true or false
                              alignment: Alignment.center, //set the button's child Alignment
                            ),
                            onPressed: () {
                              setState(() {
                                listData.removeAt(index);
                              });
                            }, //set both onPressed and onLongPressed to null to see the disabled properties
                            onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                            child: const Text(
                              "Remove",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w600),
                            )),
                      ),
                    ],
                  ),
                )))),
        Row(
          children: [
            Expanded(child: Container(),flex: 1),
            SizedBox(
              height: 26,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: white,
                    onPrimary: white,
                    //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                    elevation: 0.0,
                    side: const BorderSide(color: blue, width: 0.7, style: BorderStyle.solid),
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 12,bottom: 12),
                    //set border for the button
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    // set the buttons shape. Make its birders rounded etc
                    tapTargetSize: MaterialTapTargetSize.padded,
                    // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                    animationDuration: const Duration(milliseconds: 100),
                    //the buttons animations duration
                    enableFeedback: true,
                    //to set the feedback to true or false
                    alignment: Alignment.center, //set the button's child Alignment
                  ),
                  onPressed: () {
                    addMoreViews(Notifications());
                  }, //set both onPressed and onLongPressed to null to see the disabled properties
                  onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: blue, size: 16),
                      Text(
                        "Add More",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            ),
            Expanded(child: Container(),flex: 1),
          ],
        )
      ],
    );
  }

  void addMoreViews(Notifications data) {
    setState(() {
       data.setName = "";
       data.setPhone = "";
       data.setEmail = "";
       data.setAddress = "";
       listData.add(data);
    });
  }

  bool isValidData() {
    bool isValid = true;
     /* for (int i = 0; i < listData.length; i++) {
        if (listData[i].questions.isEmpty) {
          return false;
        } else if (listData[i].answer.isEmpty) {
          return false;
        }
      }*/
    return isValid;
  }

  String isValidDataMsg() {
    String value = "";
   /* for (int i = 0; i < listProductVariations.length; i++) {
      if (listProductVariations[i].mrpPrice.isEmpty) {
        value = "MRP Price Can\'t Be Empty";
        break;
      } else if (listProductVariations[i].salePrice.isEmpty) {
        value = "Sale Price Can\'t Be Empty";
        break;
      } else if (int.parse(listProductVariations[i].salePrice) > int.parse(listProductVariations[i].mrpPrice)) {
        value = "Sale price should not greater than Mrp price";
        break;
      }
      else if (listProductVariations[i].color.isEmpty) {
        value = "Color Can\'t Be Empty";
        break;
      }
      else if (listProductVariations[i].size.isEmpty) {
        value = "Size Can\'t Be Empty";
        break;
      }
      else if (listProductVariations[i].status.isEmpty) {
        value = "Please select status of product variation";
        break;
      }
    }*/
    return value;
  }


  void _makeJsonData() async {
    /*List<ProductFaqsModel> listFaqsTemp = List<ProductFaqsModel>.empty(growable: true);
    for (int i = 0; i < listData.length; i++) {
      if (listData[i].questions.isNotEmpty && listData[i].answer.isNotEmpty) {
        listFaqsTemp.add(listData[i]);
      }
    }

    if (listFaqsTemp.isNotEmpty) {
      listData.clear();
      listData.addAll(listFaqsTemp);
    }*/
    print("<><> Json FAQS ${jsonEncode(listData).toString().trim()} END<><>");
  }


  //API call function...
  /*_saveProjectCall() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(BASE_URL + productSave);
    var request = MultipartRequest("POST", url);
    request.fields['product_id'] = productIdApi;
    request.fields['status'] = statusApi;
    request.fields['is_best_seller'] = isBestSellerApi;
    request.fields['is_top_deal'] = isTopDealApi;
    request.fields['category_id'] = categoryIdApi;
    request.fields['brand_id'] = brandIdApi;
    request.fields['name'] = productNameApi;
    request.fields['tagline'] = tagApi;
    request.fields['from_app'] = "true";
    request.fields['apiId'] = API_KEY;
    request.fields['user_id'] = sessionManager.getUserId().toString();
    request.fields['removeImages'] = "";

    if (listProductVariations.isNotEmpty) {
      request.fields['product_variation'] = jsonEncode(listProductVariations).toString().trim();
    } else {
      request.fields['product_variation'] = "";
    }

    if (listFeatures.isNotEmpty) {
      request.fields['product_features'] = jsonEncode(listFeatures).toString().trim();
    } else {
      request.fields['product_features'] = "";
    }

    if (listSpecifications.isNotEmpty) {
      request.fields['product_specifications'] = jsonEncode(listSpecifications).toString().trim();
    } else {
      request.fields['product_specifications'] = "";
    }

    if (listData.isNotEmpty) {
      request.fields['product_faq'] = jsonEncode(listData).toString().trim();
    } else {
      request.fields['product_faq'] = "";
    }

    request.fields['meta_keywords'] = metaTitleApi;
    request.fields['desclaimer'] = disclaimerApi;
    request.fields['description'] = metaDescriptionApi;
    request.fields['sku'] = skuApi;

    List<ProductFilesModel> tempImage = List<ProductFilesModel>.empty(growable: true);
    List<ProductFilesModel> tempVideo = List<ProductFilesModel>.empty(growable: true);

    if (projectImageOrVideo.isNotEmpty) {
      for (int i = 0; i < projectImageOrVideo.length; i++) {
        if (projectImageOrVideo[i].isVideo) {
          if (!projectImageOrVideo[i].path.startsWith("https") || !projectImageOrVideo[i].path.startsWith("http")) {
            tempVideo.add(projectImageOrVideo[i]);
          }
        } else {
          if (!projectImageOrVideo[i].path.startsWith("https") || !projectImageOrVideo[i].path.startsWith("http")) {
            tempImage.add(projectImageOrVideo[i]);
          }
        }
      }
    }

    if (tempImage.isNotEmpty) {
      for (int i = 0; i < tempImage.length; i++) {
        var multipartFile = await MultipartFile.fromPath("product_images[$i]", tempImage[i].path);
        request.files.add(multipartFile);
      }
    }

    if (tempVideo.isNotEmpty) {
      for (int i = 0; i < tempVideo.length; i++) {
        var multipartFile = await MultipartFile.fromPath("product_videos[$i]", tempVideo[i].path);
        request.files.add(multipartFile);
      }
    }

    if (pdfFilePath != null) {
      if (pdfFilePath.toString().isNotEmpty) {
        var multipartFile = await MultipartFile.fromPath("product_pdf", pdfFilePath!);
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> user = jsonDecode(responseString);
    var commonResponse = CommonResponseModel.fromJson(user);

    setState(() {
      _isLoading = false;
    });

    showSnackBar(commonResponse.message, context);

    if (commonResponse.success == 1) {
      if ((widget as AddDeathNotificationPage).isFromList == true) {
        Navigator.pop(context, "success");
      } else {
        setState(() {
          _productNameController.text = "";
          _categoryController.text = "";
          _brandController.text = "";
          _isTopDealController.text = "";
          _isBestSellerController.text = "";
          _statusController.text = "";

          _pdfFileController.text = "";
          _isPdfNameVisible = false;
          _tagController.text = "";
          _disclaimerController.text = "";
          _metaTitleController.text = "";
          _metaDescriptionController.text = "";
          _skuController.text = "";

          textControllerForCategory.text = "";
          textControllerForBrand.text = "";

          listProductVariations.clear();
          projectImageOrVideo.clear();
          listData.clear();
          listFeatures.clear();
          listSpecifications.clear();

          isSubmitClick = false;

          addProductVariationData();
          addMoreViews();
          addProductFeaturesData();
          addProductSpecificationsData();

          _isVisible = true;

          tabNavigationReload();

          FocusManager.instance.primaryFocus?.unfocus();
          final BottomNavigationBar bar = bottomWidgetKey.currentWidget as BottomNavigationBar;
          bar.onTap!(1);
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }*/

  @override
  void castStatefulWidget() {
    widget is AddDeathNotificationPage;
  }
}




