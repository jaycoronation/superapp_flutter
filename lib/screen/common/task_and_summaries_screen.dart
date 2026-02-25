import 'package:flutter/material.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/screen/common/SummaryScreen.dart';
import 'package:superapp_flutter/screen/common/client_task_list.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../model/CommonModel.dart';
import '../RecommendationListScreen.dart';

class TaskAndSummariesScreen extends StatefulWidget {
  const TaskAndSummariesScreen({super.key});

  @override
  BaseState<TaskAndSummariesScreen> createState() => _TaskAndSummariesScreenState();
}

class _TaskAndSummariesScreenState extends BaseState<TaskAndSummariesScreen>with SingleTickerProviderStateMixin {

  ScrollController scrollController = ScrollController();

  int currentIndex = 0;
  late TabController tabController;

  List<TabModel> tabList = [];

  @override
  void initState() {
    setData();
    tabController = TabController(length: tabList.length, vsync: this,initialIndex: currentIndex);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
    super.initState();
  }

  setData(){
    tabList = [
      TabModel(id: "1", title: "Tasks"),
      TabModel(id: "2", title: "Summaries"),
      TabModel(id: "3", title: "Recommendations"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        title: getTitle("Tasks & Summaries"),
        backgroundColor: white,
      ),
      body: NestedScrollView(
        controller: scrollController,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: true,
              snap: true,
              primary: false,
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              backgroundColor: Colors.white,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: dashboardBg,
                    ),
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: tabController,
                      indicatorColor: blue,
                      labelColor: blue,
                      unselectedLabelColor: black,
                      labelStyle: getBoldTextStyle(fontSize: 14, color: blue),
                      unselectedLabelStyle: getMediumTextStyle(fontSize: 14, color: black),
                      tabs: tabList.map((e) {
                        return Tab(text: e.title);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: TabBarView(
            controller: tabController,
            physics: const ClampingScrollPhysics(),
            children: [
              const ClientTaskListScreen(),
              const SummaryScreen(),
              const RecommendationListScreen(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget as TaskAndSummariesScreen;
  }
}
