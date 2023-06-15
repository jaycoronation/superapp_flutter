import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/model/blogs_filter_response_model.dart';
import 'package:superapp/model/blogs_response_model.dart';
import 'package:superapp/screen/common/blog_detail_page.dart';
import '../../constant/blogs_api_end_point.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  _BlogsPageState createState() => _BlogsPageState();
}

class _BlogsPageState extends BaseState<BlogsPage> {
  List<ItemsBlogs> listData = List<ItemsBlogs>.empty(growable: true);
  List<Url> listFilterData = List<Url>.empty();

  bool _isLoading = false;
  ScrollController _scrollViewController = ScrollController();

  bool _isLoadingMore = false;
  int _pageIndex = 1;
  final int _pageResult = 10;
  bool _isLastPage = false;
  bool isScrollingDown = false;

  String selectedFilterText = "";

  @override
  void initState() {
    super.initState();

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {});
        }
      }

      pagination();

    });

    if (isInternetConnected) {
      getFilterData();
      getList(true);
    }else {
      noInterNet(context);
    }

  }

  void pagination() {
    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent)) {
        setState(() {
          _isLoadingMore = true;
          getList(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
                  const Expanded(child: Text("Feeds",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                  )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _showFilterDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(selectedFilterText.isEmpty ? "All" : selectedFilterText,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: white,
      ),
      body: isInternetConnected
          ? _isLoading
          ? const LoadingWidget()
          : listData.isEmpty
          ? const Center(child: MyNoDataWidget(msg: 'No blogs data found!'))
          : _setData()
          : const NoInternetWidget()
    );
  }

  SafeArea _setData() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child:SingleChildScrollView(
                    controller: _scrollViewController,
                    child: AnimationLimiter(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: listData.length,
                          itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogsDetailPage(listData[index])),);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:Border.all(color: black, width: 1,)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 160,
                                            width: MediaQuery.of(context).size.width,
                                            // color: grayLight,
                                            child: listData[index].image.toString().isNotEmpty
                                                ? FadeInImage.assetNetwork(
                                              image: listData[index].image.toString(),
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context).size.width,
                                              height: 160,
                                              placeholder: 'assets/images/ic_alpha_logo.png',
                                            ) : Image.asset('assets/images/ic_alpha_logo.png',
                                                width: 50, height: 50),
                                          ),
                                          const Gap(10),
                                          Text(checkValidString(listData[index].title.toString()),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.bold),
                                          ),
                                          const Gap(10),
                                          Text(checkValidString(listData[index].author!.name.toString()),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 15, color: blue, fontWeight: FontWeight.w500),
                                          ),
                                          const Gap(15),
                                          const Divider(height: 0.5, color: black, thickness: 1,),
                                          const Gap(25),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM,yyyy", listData[index].datePublished.toString()),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w600),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: const EdgeInsets.only(right: 8),
                                                child: Image.asset('assets/images/up-arrow.png',height: 26, width: 26, color: black,),
                                              ),
                                            ],
                                          ),
                                          const Gap(10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  )),
              Visibility(
                visible: _isLoadingMore,
                child: Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30, height: 30,
                          child: Lottie.asset('assets/images/loader_new.json',repeat: true, animate: true, frameRate: FrameRate.max)),
                      const Text(' Loading more...',
                          style: TextStyle(color: black, fontWeight: FontWeight.w400, fontSize: 16)
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is BlogsPage;
  }

  void _showFilterDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter updateSetState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 60,
                            margin: const EdgeInsets.only(top: 5),
                            child: const Divider(height: 1.5, thickness: 1.5, color: blue)
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                          child: const Text("Filter", style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Container(height: 6),
                      ],
                    ),
                  ),
                );
              });
        });

  }

  //API call func..
  void getList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
        // _isLoading = true;
        _isLoadingMore = false;
        _pageIndex = 1;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://alphacapital.in/blog/feed/json?paged=$_pageIndex");
    // Map<String, String> jsonBody = {
    //   'paged' : _pageIndex.toString(),
    // };

    final response = await http.get(url);//post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> codes = jsonDecode(body);
    var dataResponse = BlogsResponseModel.fromJson(codes);

    if (isFirstTime) {
      if (listData.isNotEmpty) {
        listData = [];
      }
    }

    if (statusCode == 200) {
      if (dataResponse.itemsBlogs != null) {
        if (isFirstTime) {
          if (listData.isNotEmpty) {
            listData = [];
          }
        }

        List<ItemsBlogs>? _tempList = [];
        _tempList = dataResponse.itemsBlogs;
        listData.addAll(_tempList!);

        if (_tempList.isNotEmpty) {
          _pageIndex += 1;
          if (_tempList.isEmpty || _tempList.length % _pageResult != 0) {
            _isLastPage = true;
          }
        }
      }

      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });

    } else {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }

  }

  void getFilterData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://alphacapital.in/blog/filter.json");
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogsFilterResponseModel.fromJson(user);

    if (statusCode == 200) {
      listFilterData = dataResponse.url!;

    }else {
    }

  }

  void getFinancialPlanningData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_BLOGS + financialPlanning);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogsResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.itemsBlogs!;

      setState(() {
        _isLoading = false;
      });

    }else {
      setState(() {
        _isLoading = false;
      });
    }

  }

  void getGeneralData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_BLOGS + general);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogsResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.itemsBlogs!;

      setState(() {
        _isLoading = false;
      });

    }else {
      setState(() {
        _isLoading = false;
      });
    }

  }

  void getInvestmentIdeasData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_BLOGS + investmentIdeas);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogsResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.itemsBlogs!;

      setState(() {
        _isLoading = false;
      });

    }else {
      setState(() {
        _isLoading = false;
      });
    }

  }

  void getTaxPlanningData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_BLOGS + taxPlanning);
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BlogsResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.itemsBlogs!;

      setState(() {
        _isLoading = false;
      });

    }else {
      setState(() {
        _isLoading = false;
      });
    }

  }


}