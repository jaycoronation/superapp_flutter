import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart' as path;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/AddTaskResponseModel.dart';
import 'package:superapp_flutter/model/DeleteTaskResponseModel.dart';
import 'package:superapp_flutter/model/TaskListResponseModel.dart';
import 'package:superapp_flutter/screen/common/task_detail_page.dart';
import 'package:superapp_flutter/widget/loading.dart';
import 'package:superapp_flutter/widget/no_data.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class ClientTaskListScreen extends StatefulWidget {
  const ClientTaskListScreen({super.key});

  @override
  BaseState<ClientTaskListScreen> createState() => _ClientTaskListScreenState();
}

class _ClientTaskListScreenState extends BaseState<ClientTaskListScreen> {

  bool isLoading = false;
  final int _pageIndex = 0;
  final int _pageResult = 20;

  TextEditingController taskController = TextEditingController();

  List<TaskList> listTasks = [];

  String selectedImageFile = "";

  @override
  void initState(){
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: dashboardBg,
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            title: const Text(""),
            centerTitle: false,
            elevation: 0,
            backgroundColor: white,
          ),
          body: isLoading
              ? const LoadingWidget()
              : listTasks.isNotEmpty
              ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 16),
                    child: const Text('Click on the tasks to see the status : ',style: TextStyle(fontSize: 14, color: blackLight, fontWeight: FontWeight.w600,),)
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ListView.builder(
                    itemCount: listTasks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        //color: white,
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        // decoration: BoxDecoration(color: index % 2 == 0 ? semiBlue : white, borderRadius: BorderRadius.all(Radius.circular(10))),
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {
                            _redirectToDetail(context, listTasks[index]);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible: (listTasks[index].strTaskPriority?.isNotEmpty ?? false),
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 8),
                                                  padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: blue),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Text(listTasks[index].strTaskPriority ?? "", style: getMediumTextStyle(fontSize: 12, color: blue),),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: blue),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text(listTasks[index].taskStatus ?? "", style: getMediumTextStyle(fontSize: 12, color: blue),),
                                              ),
                                            ],
                                          )
                                        ),
                                        Visibility(
                                          visible: listTasks[index].isAddedByClient ?? true,
                                          child: PopupMenuButton<int>(
                                            itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                                              PopupMenuItem<int>(
                                                value: 1,
                                                height: 18,
                                                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Edit",
                                                        style: getRegularTextStyle(color: black, fontSize: 14),
                                                      ),
                                                      const Gap(10),
                                                      Image.asset(
                                                        "assets/images/img_edit.png",
                                                        height: 18,
                                                        width: 18,
                                                      )
                                                    ],
                                                  ),
                                              ),
                                              PopupMenuItem<int>(
                                                value: 2,
                                                padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                                                height: 18,
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Delete",
                                                        style: getRegularTextStyle(color: red, fontSize: 14),
                                                      ),
                                                      const Gap(10),
                                                      Image.asset(
                                                        "assets/images/img_delete.png",
                                                        height: 18,
                                                        width: 18,
                                                      )
                                                    ],
                                                  ),
                                              ),
                                            ],
                                            onSelected: (int value) async {
                                              if(value == 1)
                                              {
                                                showAddTaskDialog(true, listTasks[index]);
                                              }
                                              else if(value == 2)
                                              {
                                                openDeleteTaskDialog(listTasks[index]);
                                              }
                                            },
                                            borderRadius: BorderRadius.circular(12),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            position: PopupMenuPosition.under,
                                            icon: Icon(Icons.more_vert, size: 24, color: black,),
                                            padding: EdgeInsets.zero,
                                            iconSize: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Gap(8),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            listTasks[index].taskMessage ?? "",
                                            style: getMediumTextStyle(fontSize: 14, color: blackLight),
                                          ),
                                        ),
                                        Visibility(
                                          visible: listTasks[index].attachmentCount != 0,
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 8),
                                            child: Icon(Icons.attachment, size: 24, color: graySemiDark,),
                                          ),
                                        )
                                      ],
                                    ),
                                    Visibility(
                                      visible: listTasks[index].allEmployeeName?.isNotEmpty ?? false,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Gap(4),
                                          Text(
                                            "Assigned To",
                                            style: getSemiBoldTextStyle(fontSize: 12, color: black),
                                          ),
                                          const Gap(2),
                                          Text(
                                            listTasks[index].allEmployeeName ?? "",
                                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: listTasks[index].taskCompletedRemark?.isNotEmpty ?? false,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Gap(4),
                                          Text(
                                            "Remark",
                                            style: getSemiBoldTextStyle(fontSize: 12, color: black),
                                          ),
                                          const Gap(2),
                                          Text(
                                            listTasks[index].taskCompletedRemark ?? "",
                                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: listTasks[index].dueDate.toString().isNotEmpty && (listTasks[index].dueDate != null),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex:1,
                                            child: Text("Due Date", textAlign: TextAlign.start,
                                              style:  TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          const Text(":", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(
                                            flex:4,
                                            child: Text(checkValidString(listTasks[index].dueDate.toString()), textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Visibility(visible: index != listTasks.length-1,child: Container(color: grayLight, height: 0.5),)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
              : const MyNoDataWidget(msg: "No Tasks Pending"),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isOnline)
              {
                showAddTaskDialog(false,TaskList());
              }
              else
              {
                noInterNet(context);
              }
            },
            backgroundColor: blue,
            child: const Icon(Icons.add, color: white),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  openDeleteTaskDialog(TaskList getSet){
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, updateState) {
            return SafeArea(
              child: Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        getBottomSheetHeaderWithoutButton2(context, "Delete?"),
                        Text(
                          "Are you sure want to Delete this task?",
                          style: getMediumTextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: getCommonButtonBorder(
                                  "CANCEL",
                                  false,
                                  () {
                                    if(!isLoading) Navigator.pop(context);
                                  }
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: getCommonButton(
                                "Delete",
                                isLoading,
                                () async{

                                  updateState((){
                                    isLoading = true;
                                  });

                                  bool result = await deleteTask("${getSet.employeeId}", "${getSet.id}");

                                  updateState((){
                                    isLoading = false;
                                  });

                                  if(result)
                                  {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showAddTaskDialog(bool isForUpdate, TaskList taskListData) {

    if (isForUpdate) {
      taskController.text = taskListData.taskMessage ?? "";
    } else {
      taskController.clear();
    }

    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      elevation: 5,
      isDismissible: true,
      builder: (context) {
        bool isLoading = false;
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, updateState) {
              return ConstrainedBox(
                constraints:  BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.95),
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Add Task For Alpha Capital",
                                  style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              const Gap(10),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/images/ic_close.png",
                                  height: 24,
                                  width: 24,
                                ),
                              )
                            ],
                          ),
                          const Gap(16),
                          TextField(
                            cursorColor: black,
                            controller: taskController,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            style: getMediumTextStyle(fontSize: 14, color: black),
                            decoration: InputDecoration(
                              fillColor: white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey,width: 0.5),
                              ),
                              hintText: "Enter Task message",
                            ),
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Icon(Icons.attachment, color: graySemiDark, size: 24,),
                              const Gap(10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          pickImagesFromGallery(updateState);
                                        },
                                        child: Text(
                                          selectedImageFile.isEmpty ? "Attack file or screenshot" : path.basename(selectedImageFile),
                                          style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: selectedImageFile.isNotEmpty,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          updateState(() {
                                            selectedImageFile = "";
                                          });
                                          setState(() {});
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          child: Image.asset(
                                            "assets/images/img_delete.png",
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            child: getCommonButton(
                              isForUpdate ? "Update" : "Save",
                              isLoading,
                              () async{
                                if(taskController.text.isEmpty)
                                {
                                  showToast("Please enter task message");
                                }
                                else
                                {
                                  updateState(() {
                                    isLoading = true;
                                  });

                                  bool result = await addUpdateTask(isForUpdate, taskListData);

                                  updateState(() {
                                    isLoading = false;
                                  });

                                  if (result) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ), 
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> pickImagesFromGallery(StateSetter updateState) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'heic', 'webp'],
      );

      if (result != null)
      {
        File file = File(result.files.single.path!);
        updateState(() {
          selectedImageFile = file.path;
        });

        setState(() {});
      }
      else
      {
        showSnackBar("No image selected.", context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addUpdateTask(bool isFormEdit, TaskList getSet) async {
    if(isOnline)
    {
      try
      {
        String base64Image = selectedImageFile.isNotEmpty ? await convertImageToBase64(selectedImageFile) : "";

        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(isFormEdit ? updateTask : addTaskApi);

        Map<String, String> jsonBody = {
          "FileExtension": selectedImageFile.isNotEmpty ? path.extension(selectedImageFile) : "",
          "file_name": selectedImageFile.isNotEmpty ? path.basename(selectedImageFile) : "",
          "client_name": isFormEdit ? "" : "${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
          "pan_card": isFormEdit ? "" : sessionManagerPMS.getPanCard(),
          "assign_client_ids": isFormEdit ? "${getSet.addedByClientId}" : "",
          "due_date": isFormEdit ? getSet.dueDate ?? "" : "",
          "employee_id": isFormEdit ? "${getSet.employeeId}" : "",
          "id": isFormEdit ? "${getSet.id}" : "",
          "img_url": base64Image,
          "taskStatus": isFormEdit ? "${getSet.taskStatusId}" : "1",
          "task_message": taskController.text,
          "task_priority": isFormEdit ? "${getSet.taskPriority}" : "3",
          "task_status_id": isFormEdit ? "${getSet.taskStatusId}" : "1"
        };

        final response = await http.post(url, body: jsonBody, headers: {
          "Authorization": authHeader,
        });

        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> data = jsonDecode(body);
        var dataResponse = AddTaskResponseModel.fromJson(data);

        if(statusCode == 200 && dataResponse.success == true)
        {
          if(dataResponse.message?.isNotEmpty ?? false)
          {
            showToast("${dataResponse.message}");
          }
          else
          {
            showToast("Saved Successfully");
          }

          taskController.clear();
          selectedImageFile = "";
          _getList();

          return true;
        }
        else
        {
          if(dataResponse.message?.isNotEmpty ?? false)
          {
            showToast("${dataResponse.message}");
          }
          return false;
        }
      }
      catch(e)
      {
        print("Failed to add update task : $e");
        return false;
      }
    }
    else
    {
      noInterNet(context);
      return false;
    }
  }

  deleteTask(String employeeId, String taskId) async {
    if(isOnline)
    {
      try
      {

        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(deleteTaskAPi);

        Map<String, String> jsonBody = {
          "employee_id": employeeId,
          "task_deleted_remark": "Removed by client",
          "task_id": taskId
        };

        final response = await http.post(url, body: jsonBody, headers: {
          "Authorization": authHeader,
        });

        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> data = jsonDecode(body);
        var dataResponse = DeleteTaskResponseModel.fromJson(data);

        if(statusCode == 200 && dataResponse.success == true)
        {
          if(dataResponse.message?.isNotEmpty ?? false)
          {
            showToast("${dataResponse.message}");
          }
          _getList();

          return true;
        }
        else
        {
          if(dataResponse.message?.isNotEmpty ?? false)
          {
            showToast("${dataResponse.message}");
          }
          return false;
        }
      }
      catch(e)
      {
        print("Failed to delete task : $e");
        return false;
      }
    }
    else
    {
      noInterNet(context);
      return false;
    }
  }

  //API Call Func...
  _getList() async {
    if (isOnline) {

      setState(() {
        isLoading = true;
      });

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);


      final url = Uri.parse(CHEETAH_TASK_LIST);

      Map<String, String> jsonBody = {
        "pan_card": sessionManagerPMS.getPanCard(),
        // "client_name": "${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
        "first_name": "${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
        "fromdate": '',
        "todate": '',
        "pageindex": _pageIndex.toString(),
        "pagesize": _pageResult.toString()
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = TaskListResponseModel.fromJson(data);


      if (statusCode == 200 && dataResponse.success == true) {
        if (dataResponse.data != null) {

          if (dataResponse.data!.taskList != null) {
            listTasks = dataResponse.data?.taskList ?? [];
          }

        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      noInterNet(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _redirectToDetail(BuildContext context, TaskList taskData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailPage(taskData.id.toString().trim(),false)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {
      });
      _getList();
    }
  }

  @override
  void castStatefulWidget() {
    widget is ClientTaskListScreen;
  }

}