import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/functions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/widget/no_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/AddMessageResponse.dart';
import '../../model/AllTaskAttachemntResponseModel.dart';
import '../../model/TaskCommentResponse.dart';
import '../../model/TaskDetailsResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_internet.dart';

class TaskDetailPage extends StatefulWidget {
  final String taskIdParam;
  final bool isFromNotification;

  const TaskDetailPage(this.taskIdParam,this.isFromNotification, {Key? key}) : super(key: key);

  @override
  BaseState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends BaseState<TaskDetailPage> {

  String taskIdParam = "";
  bool _isLoading = false;
  var taskData = TaskData();

  List<TaskCommentData> listComments = List<TaskCommentData>.empty(growable: true);
  final TextEditingController _commentController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  List<TaskAttachemnt> listTaskAttachment = [];

  bool isPinnedTaskOpen = true;
  bool isAllTaskOpen = true;
  String finalDateTime = "";
  String clientName = "";
  String employeeName = "";
  String reminderDate = "";
  String selectedClientIdsForTask = "";
  String selectedClientNameForTask = "";
  bool isFromNotification = false;
  bool isSelfTask = false;
  String openSinceDays = "0";

  String? pdfFilePath = "";
  String? pdfFileName = "";
  var selectedPdfFileName = "";

  String selectedSupervisorIdsForTask = "";
  String selectedSupervisorNameForTask = "";

  final TextEditingController _searchClientController = TextEditingController();
  final TextEditingController taskCompletedController = TextEditingController();
  final TextEditingController taskReopenController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    taskIdParam = (widget as TaskDetailPage).taskIdParam;
    isFromNotification  = (widget as TaskDetailPage).isFromNotification;
    _getDetails(true);
    getAllTaskAttachment();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
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
          title: const Text(
            "Task Details",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, color: black, fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
          elevation: 0,
          titleSpacing: 12,
          backgroundColor: white,
        ),
        body: isInternetConnected
            ? _isLoading
            ? const LoadingWidget()
            : _setData()
            : const NoInternetWidget()
      ),
      onWillPop: (){
        Navigator.pop(context,"success");
        return Future.value(true);
    },
    );
  }

  SafeArea _setData() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: DetectableText(
                      trimLines: 4,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'more',
                      trimExpandedText: '...less',
                      text: checkValidString(taskData.taskDetail?.taskMessage),
                      detectionRegExp: RegExp(
                        "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                        multiLine: true,
                      ),
                      callback: (bool readMore) {
                        debugPrint('Read more >>>>>>> $readMore');
                      },
                      onTap: (tappedText) async {
                        print(tappedText);
                        if (tappedText.startsWith('#')) {
                          debugPrint('DetectableText >>>>>>> #');
                        } else if (tappedText.startsWith('@')) {
                          debugPrint('DetectableText >>>>>>> @');
                        } else if (tappedText.startsWith('http')) {
                          debugPrint('DetectableText >>>>>>> http');
                        }
                      },
                      basicStyle: taskData.taskDetail?.taskStatusId == 2
                          ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: black,
                      )
                          : const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                      detectedStyle: taskData.taskDetail?.taskStatusId == 2
                          ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: blue,
                      )
                          : const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: blue,
                          ),
                    )
                ),
                Container()
              ],
            ),
            Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
            Visibility(
              visible: int.parse(openSinceDays) > 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Open Since : ",
                            style: TextStyle(color: black,fontSize: 15,fontWeight: FontWeight.w500)
                        ),
                        const TextSpan(
                            text: "Task open since ",
                            style: TextStyle(color: black,fontSize: 15,fontWeight: FontWeight.w500)
                        ),
                        TextSpan(
                            text: openSinceDays,
                            style: const TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w500)
                        ),
                        const TextSpan(
                            text: " Days",
                            style: TextStyle(color: black,fontSize: 15,fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                  Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
                ],
              ),
            ),
            Visibility(
              visible: employeeName.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Employee Name : $employeeName",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                  ),
                  Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
                ],
              ),
            ),
            Visibility(
              visible: reminderDate.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Date : $reminderDate",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                  ),
                  Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
                ],
              ),
            ),
            Visibility(
              visible: taskData.taskDetail?.taskReopenRemark?.isNotEmpty ?? false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update Remark : ${taskData.taskDetail?.taskReopenRemark} (${taskData.taskDetail?.reopenDate?.isNotEmpty ?? false ? taskData.taskDetail?.reopenDate : taskData.taskDetail?.createdDateOriginalStr})",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                  ),
                  Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskData.taskDetail?.taskDesc?.isNotEmpty ?? false
                      ? "Description : ${taskData.taskDetail?.taskDesc}"
                      : "Description : Not added yet ",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                ),
                Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 115,
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Assigned By",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w400),
                      ),
                      const Gap(6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: lightGrey,
                          alignment: Alignment.center,
                          child: Text(
                            getSortName(taskData.taskDetail?.employeeName ?? ''),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      const Gap(6),
                      Text(
                        getFirstName(checkValidString(taskData.taskDetail?.employeeName)),
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Container(width: 0.5, color: grayLight, margin: const EdgeInsets.only(left: 8, right: 8)),
                  Expanded(
                      child: taskData.employeeList?.isNotEmpty ?? false
                          ? SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(
                                      child: _taskEmployeeListView()
                                  )
                                ],
                              )
                          )
                          : Container()
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
                Row(
                  children: [
                    Text(
                      listTaskAttachment.isNotEmpty ? "Attachments : " : "Attachments : Not Added yet",
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                    ),
                    /*GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _pickFile();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: const Text(
                          "Add Attachment",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),*/
                  ],
                ),
                Visibility(
                  visible:  listTaskAttachment.isNotEmpty,
                    child: const Gap(12)
                ),
                ListView.builder(
                  itemCount: listTaskAttachment.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(listTaskAttachment[index].imgUrl ?? "")))
                            {
                              launchUrl(Uri.parse(listTaskAttachment[index].imgUrl ?? ""));
                            }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              listTaskAttachment[index].imgUrl?.isNotEmpty ?? false
                                  ? Image.asset("assets/images/ic_view.png",width: 28,height: 28,)
                                  : Container(width: 28,height: 28,child: const CircularProgressIndicator(color: blue,strokeWidth: 3)),
                              const Gap(8),
                              Expanded(child: Text(listTaskAttachment[index].fileName ?? '',style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500))),
                              const Gap(12),
                              Visibility(
                                visible: listTaskAttachment[index].imgUrl?.isNotEmpty ?? false,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    _showActionDialog(listTaskAttachment[index]);
                                  },
                                    child: Image.asset('assets/images/t_delete.png',color: Colors.red,width: 24,height: 24,)
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                ),
                Container(height: 0.5, color: grayLight, margin: const EdgeInsets.only(top: 8, bottom: 8)),
              ],
            ),
            isSelfTask
                ? const Expanded(child: MyNoDataWidget(msg: "Comment feature is not enable for self created task."))
                : Expanded(
                  child: listComments.isNotEmpty
                      ? SingleChildScrollView(
                        controller: _scrollController,
                        child: _commentsListView(),
                      )
                      : const MyNoDataWidget(msg: "Add Your Comments!")
                  ),
            Visibility(
                visible: !isSelfTask,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: grayLight),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                              controller: _commentController,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 15),
                              cursorColor: grayDark,
                              decoration: InputDecoration(
                                  hintText: 'Add Comment..',
                                  fillColor: white,
                                  hintStyle: const TextStyle(fontWeight: FontWeight.w400, color: grayLight, fontSize: 15),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: EdgeInsets.zero)
                          ),
                        )
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                        if (_commentController.text.toString().trim().isNotEmpty) {
                          _addComments(_commentController.text.toString().trim(), false, "", "");
                        } else {
                          showSnackBar("Please type a comment.", context);
                        }
                      },
                      child: Image.asset(
                        'assets/images/t_send_new.png',
                        width: 42,
                        height: 42,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  void _showActionDialog(TaskAttachemnt getSet) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 10),
                      child: const Text('Delete File',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: blue))
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text('Are you sure you want to remove this File?',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(white)),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel',
                                style:TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blue)),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(white)),
                            onPressed: () async {
                              Navigator.pop(context);

                              setState(() {
                              });

                            },
                            child: const Text('Delete',
                                style:TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blue)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,allowCompression: true);

    if (result != null) {
      pdfFilePath = (result.files.single.path);
      pdfFileName = result.files.single.name;

      setState(() {
        listTaskAttachment.add(TaskAttachemnt(fileName: pdfFileName,imgUrl: ""));
      });

      setState(() async {
        print("pdf file name ${(pdfFileName?.replaceAll(" ", ""))}");

        var extensionName = ".${getExtension(pdfFilePath ?? "")}";
        File imagefile = File(pdfFilePath ?? ""); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes); //convert bytes to base64 string
        if (base64string.isNotEmpty) {
          uploadTaskAttchment(extensionName, base64string);
        }
        
        selectedPdfFileName = pdfFileName.toString().replaceAll(" ", ""); //.trim();
      });
      print("$pdfFilePath++ pdfFilePath");
    } else {
      // User canceled the picker
    }
  }

  void uploadTaskAttchment(String extensionName, String base64string) async {
    setState(() {
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(SaveTaskAttachment);

    Map<String, String> jsonBody = {
      "employee_id": sessionManager.getUserId(),
      "file_name": pdfFileName.toString(),
      "task_id": taskIdParam,
      "FileExtension": extensionName,
      "img_url": base64string,
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": authHeader,
    });

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == true) {
      setState(() {
        _isLoading = false;
      });

      getAllTaskAttachment();

    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      listTaskAttachment.removeAt(listTaskAttachment.length -1);

      showSnackBar(dataResponse.message, context);
    }
  }

  ListView _taskEmployeeListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: taskData.employeeList?.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 110,
            width: 72,
            child: Column(
              children: [
                const Gap(6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: lightGrey,
                    alignment: Alignment.center,
                    child: Text(
                      maxLines: 1,
                      getSortName(taskData.employeeList![index].employeeName.toString()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const Gap(6),
                Text(
                  maxLines: 1,
                  getFirstName(checkValidString(taskData.employeeList![index].employeeName)),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
    );
  }

  ListView _commentsListView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listComments.length,
        itemBuilder: (ctx, index) => (Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4),
              child: listComments[index].employeeId.toString() == sessionManager.getUserId()
                  ? userMsg(listComments[index])
                  : otherUserMsg(listComments[index]),
            )));
  }

  userMsg(TaskCommentData commentItem) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commentItem.isImage == true
                        ? SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: commentItem.imgUrl.toString().startsWith("https") ? FadeInImage.assetNetwork(
                          image: checkValidString(commentItem.imgUrl),
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/bg_gray.jpeg',
                        ) : Image.file(File(commentItem.imgUrl.toString()),   width: 100,
                            height: 100, fit: BoxFit.cover),
                      ),
                    )
                        : Row(
                      children: [
                        Expanded(child: Container()),
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                          decoration: BoxDecoration(color: blue, border: Border.all(color: blue), borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            checkValidString(commentItem.msgTxt),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const Gap(2),
                    Visibility(
                      visible: checkValidString(commentItem.addedDate).toString().isNotEmpty,
                      child: Text(
                        convertToAgo(checkValidString(commentItem.addedDate)),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: gray, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ],
    );
  }

  otherUserMsg(TaskCommentData commentItem) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 42,
                height: 42,
                color: lightGrey,
                alignment: Alignment.center,
                child: Text(
                  maxLines: 1,
                  getSortName(checkValidString("${commentItem.firstName} ${commentItem.lastName}")),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Gap(6),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    commentItem.isImage == true
                        ? SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: FadeInImage.assetNetwork(
                          image: checkValidString(commentItem.imgUrl),
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/bg_gray.jpeg',
                        ),
                      ),
                    )
                        : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                          decoration:
                          BoxDecoration(color: lightBlue, border: Border.all(color: lightBlue), borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            checkValidString(commentItem.msgTxt),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    const Gap(2),
                    Text(
                      convertToAgo(checkValidString(commentItem.addedDate)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: gray, fontWeight: FontWeight.w300),
                    )
                  ],
                )),
            Expanded(flex: 2, child: Container())
          ],
        ),
      ],
    );
  }

  _getDetails(bool isLoadVisible) async {
    if (isInternetConnected) {
      if (isLoadVisible) {
        setState(() {
          _isLoading = true;
        });
      }

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(TASK_DETAILS);
      Map<String, String> jsonBody = {"task_id": taskIdParam.toString()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = TaskDetailsResponseModel.fromJson(data);

      if (statusCode == 200 && dataResponse.success == true)
      {
        if (dataResponse.data != null)
        {
          taskData = dataResponse.data!;

          if(checkValidString(taskData.taskDetail?.dueDate.toString()).toString().isNotEmpty)
            {
              reminderDate = universalDateConverter("MM/dd/yyyy HH:mm:ss a", "dd MMM yyyy hh:mm a", checkValidString(taskData.taskDetail?.dueDate.toString()));
            }

          clientName = "";
          employeeName = "";

          employeeName = taskData.taskDetail?.employeeName ?? '';

          for (int i = 0; i < dataResponse.data!.clientList!.length; i++)
          {
            if(clientName.isEmpty)
              {
                clientName = checkValidString(dataResponse.data!.clientList![i].clientName);
              }
            else
              {
                clientName = "$clientName," +checkValidString(dataResponse.data!.clientList![i].clientName);
              }
          }

          /*if(dataResponse.data!.employeeList !=null)
          {
            if(dataResponse.data!.employeeList!.isNotEmpty)
            {
              isSelfTask = false;
            }
            else
            {
                isSelfTask = true;
            }
          }
          else
          {
            isSelfTask = true;
          }*/

          // Assuming you have a timestamp in milliseconds (Unix timestamp)
          print("TIMESTAMP === ${dataResponse.data?.taskDetail?.createdDateOriginalTimestamp ?? ''}");

          if (dataResponse.data?.taskDetail?.createdDateOriginalTimestamp?.isNotEmpty ?? false)
            {
              int givenTimestamp = int.parse(dataResponse.data?.taskDetail?.createdDateOriginalTimestamp ?? "");
              DateTime givenDate = DateTime.fromMillisecondsSinceEpoch(givenTimestamp * 1000);
              DateTime currentDate = DateTime.now();
              Duration difference = currentDate.difference(givenDate);
              print('Difference: ${difference.inDays} days, ${difference.inHours % 24} hours, ${difference.inMinutes % 60} minutes, ${difference.inSeconds % 60} seconds');
              openSinceDays = difference.inDays.toString();
            }
          else
            {
              openSinceDays = "0";
            }

          _getComments();
        }
        else
        {
          setState(() {
            _isLoading = false;
          });
          showSnackBar("Task details not found.", context);
          Navigator.pop(context);
        }
      }
      else
        {
          setState(() {
            _isLoading = false;
          });
          showSnackBar("Task details not found.", context);
          Navigator.pop(context);
        }
    } else {
      noInterNet(context);
    }
  }

  _getComments() async {
    if (isInternetConnected) {

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(TASK_MESSAGE);
      Map<String, String> jsonBody = {"task_id": taskIdParam.toString()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = TaskCommentResponse.fromJson(data);

      if (statusCode == 200 && dataResponse.success == true) {
        if (dataResponse.data != null) {
          listComments = dataResponse.data!;
         /* if(listComments.isNotEmpty)
            {
              _scrollDown();
            }*/
        }
      }
    } else {
      noInterNet(context);
    }

    setState(() {
      _isLoading = false;
    });
  }


  _addComments(String msg, bool isImg, String fileExtension, String imgUrl) async {
    if (isInternetConnected) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(TASK_MESSAGE_SAVE);
      Map<String, String> jsonBody = {
        "employee_id": sessionManager.getUserId().toString(),
        "task_id": taskIdParam.toString(),
        "msg_txt": msg,
        "is_image": isImg.toString(),
        "FileExtension": fileExtension,
        "img_url": imgUrl
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = AddMessageResponse.fromJson(data);

      if (statusCode == 200 && dataResponse.success == true) {
        if (dataResponse.data != null) {
          _commentController.text = "";
          var commentsData = TaskCommentData(
            id: dataResponse.data?.id,
            employeeId: dataResponse.data?.employeeId,
            taskId: dataResponse.data?.taskId,
            msgTxt: dataResponse.data?.msgTxt,
            imgUrl: dataResponse.data?.imgUrl,
            isImage: dataResponse.data?.isImage,
            addedDate: dataResponse.data?.addedDate,
            firstName: "",
            lastName: "",
          );
          setState(() {
            if (isImg) {
          //    listComments.removeAt(listComments.length-1);
              listComments.add(commentsData);
              _scrollDown();
            }else {
              listComments.add(commentsData);
              _scrollDown();
            }
          });
        }
      }
    } else {
      noInterNet(context);
    }
  }

  void _openBottomSheetForDescription() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        child: const Text('Task Description', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: blue))
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: TextField(
                        cursorColor: black,
                        controller: taskDescriptionController,
                        minLines: 3,
                        maxLines: 5,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: grayDark,fontSize: 16),
                        decoration: const InputDecoration(
                          labelText: 'Add Task Description',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15,top: 12),
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(white)),
                        onPressed: () async {
                          if (taskDescriptionController.value.text.isNotEmpty)
                          {
                            setState(() {
                              taskData.taskDetail?.taskDesc = taskDescriptionController.value.text;
                            });
                            Navigator.pop(context);
                          }
                          else
                          {
                            showSnackBar("Please enter task description",context);
                          }
                        },
                        child: const Text('Add', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: blue)),
                      ),
                    ),
                    const Gap(40)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getAllTaskAttachment() async {
    if (isInternetConnected)
    {
      /* updateState(() {
          _isLoadingTask = true;
        });*/

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(GET_ALL_TASK_ATTACHMENT);

      Map<String, String> jsonBody = {
        "task_id" : checkValidString(taskIdParam.toString().trim()),
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = AllTaskAttachemntResponseModel.fromJson(data);
      if (statusCode == 200 && dataResponse.success == true)
      {
        setState(() {
          listTaskAttachment = dataResponse.data ?? [];
        });
      }
    }
    else
    {
      noInterNet(context);
    }

  }

  Future<void> _showDatePicker() async {
    DateTime? result = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        // the earliest allowable
        lastDate: DateTime(DateTime.now().year, 12, 31),
        // the latest allowable
        currentDate: DateTime.now(),
        builder: (context, Widget? child) => Theme(
          data: Theme.of(context).copyWith(
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(backgroundColor: blue, iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: white)),
              scaffoldBackgroundColor: white,
              colorScheme: const ColorScheme.light(onPrimary: white, primary: blue)),
          child: child!,
        ),
        initialDate: DateTime.now());

    if (result != null) {
      String startDateFormat = DateFormat('dd/MM/yyyy').format(result);
      print("<><> SHOW DATE ::: $startDateFormat <><>");
      var _time = await _selectTime();
      print("<><> SHOW TIME ::: $_time <><>");
      if(startDateFormat.isNotEmpty && _time.isNotEmpty)
      {
        finalDateTime = "$startDateFormat $_time";
        print("<><> SHOW DATETIME ::: $startDateFormat $_time <><>");
      }
    }
  }

  Future<String> _selectTime() async {
    var _time = "";
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
    {

      DateTime tempDate = DateFormat("hh:mm").parse("${picked.hour}:${picked.minute}");
      var dateFormat = DateFormat("hh:mm a"); // you can change the format here
      print(dateFormat.format(tempDate));
      _time = dateFormat.format(tempDate);
    }

    return _time;
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
                    Container(height: 30)
                  ],
                ))
          ],
        );
      },
    );
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.camera);
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
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.gallery);
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
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: filePath);

    if (croppedFile != null)
    {
      var pickImgSelectedPath = croppedFile.path;
      var extensionName = ".${getExtension(pickImgSelectedPath)}";
      File imagefile = File(pickImgSelectedPath); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      if (base64string.isNotEmpty) {
        _addComments("", true, extensionName, base64string);
      }
    }
  }

  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }



  @override
  void castStatefulWidget() {
    widget is TaskDetailPage;
  }
}
