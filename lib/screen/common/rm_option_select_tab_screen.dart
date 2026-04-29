import 'dart:async';

import 'package:flutter/material.dart';
import 'package:superapp_flutter/screen/common/rmid_user_select_screen.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../model/CommonModel.dart';
import '../../utils/MessageHandler.dart';
import '../e-state-analysis/rm_fp_lead_screen.dart';

class RmOptionSelectTabScreen extends StatefulWidget {
  const RmOptionSelectTabScreen({super.key});

  @override
  BaseState<RmOptionSelectTabScreen> createState() => _RmOptionSelectTabScreenState();
}

class _RmOptionSelectTabScreenState extends BaseState<RmOptionSelectTabScreen>with SingleTickerProviderStateMixin {

  ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  late TabController tabController;
  List<TabModel> tabList = [];

  StreamSubscription<Message>? _subscription;
  final MessageHandler _handler = MessageHandler();

  bool isSearchClient = true;
  bool isSearchLead = true;

  @override
  void initState() {
    super.initState();
    _init();
    _subscription = _handler.stream.listen((message) {
      if(message.what == 106)
      {
        if (!mounted) return;
        setState(() {
          isSearchClient = !isSearchClient;
        });
      }
      else if(message.what == 107)
      {
        if (!mounted) return;
        setState(() {
          isSearchLead = !isSearchLead;
        });
      }
    });
  }


  void _init() async {
    setData();

    if (!mounted) return;

    tabController = TabController(length: tabList.length, vsync: this, initialIndex: currentIndex,);

    tabController.addListener(() {
      if (!mounted) return;

      setState(() {
        isSearchClient = true;
        isSearchLead = true;
        currentIndex = tabController.index;
      });
    });

    setState(() {});
  }

  setData(){
    tabList = [
      TabModel(id: "1", title: "Client"),
      TabModel(id: "2", title: "Leads"),
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    _subscription?.cancel();
    super.dispose();
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
        title: getTitle(""),
        backgroundColor: white,
        actions: [
          Visibility(
            visible: currentIndex == 0,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async{
                    _handler.sendMessage(Message(108, ""));
                  },
                  child: Image.asset(isSearchClient ? "assets/images/ic_search.png" : "assets/images/ic_search_cancel.png", width: 22, height: 22, color: blue,)
              ),
            ),
          ),
          Visibility(
            visible: currentIndex == 1,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async{
                    _handler.sendMessage(Message(109, ""));
                  },
                  child: Image.asset(isSearchLead ? "assets/images/ic_search.png" : "assets/images/ic_search_cancel.png", width: 22, height: 22, color: blue,)
              ),
            ),
          ),
        ],
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
                      isScrollable: false,
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
              const RMIDUserSelectScreen("FP", isFromTab: true,),
              const RmFpLeadScreen(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget as RmOptionSelectTabScreen;
  }
}
