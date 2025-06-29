import 'dart:convert';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
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

  List<TaskList> listTasks = [];

  @override
  void initState(){
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            toolbarHeight: 55,
            leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackArrow(),
            ),
            automaticallyImplyLeading: false,
            title: getTitle("My Tasks",),
            centerTitle: true,
            elevation: 0,
            backgroundColor: white,
          ),
          body: isLoading
              ? const LoadingWidget()
              : listTasks.isNotEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                      child: const Text('Click on the tasks to see the status : ',style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w600,),)
                  ),
                  const Gap(12),
                  ListView.builder(
                    itemCount: listTasks.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: white,
                        child: InkWell(
                          onTap: () {
                            _redirectToDetail(context, listTasks[index]);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15,top: 10,bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${(index + 1).toString()}. ",style: const TextStyle( fontSize: 15, fontWeight: FontWeight.w500, color: blue,),),
                                        Expanded(
                                            child: DetectableText(
                                              trimLines: 3,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'more',
                                              trimExpandedText: '...less',
                                              text: setTaskName(listTasks[index]),
                                              detectionRegExp: RegExp(
                                                "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                                multiLine: true,
                                              ),
                                              basicStyle: listTasks[index].taskStatusId == 2 ? const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                              ) :
                                              const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                              ),
                                              detectedStyle:  listTasks[index].taskStatusId == 2 ? const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                color: blue,
                                              ) :
                                              const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                color: blue,
                                              ),
                                            )),
                                        /*GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            //showActionDialog(listTasks[index], index);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 50,
                                            height: 40,
                                            child: Image.asset('assets/images/ic_dot_new.png', color: black, height: 20, width: 20),
                                          ),
                                        ),*/
                                      ],
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
                              Visibility(visible: index != listTasks.length-1,child: Container(color: grayLight, height: 0.5),)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
              : const MyNoDataWidget(msg: "No Tasks Pending"),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
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
        "client_name": "${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
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