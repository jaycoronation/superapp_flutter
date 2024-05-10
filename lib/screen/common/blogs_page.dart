import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/constant/global_context.dart';
import 'package:superapp_flutter/screen/common/blog_detail_page.dart';

import '../../constant/colors.dart';
import '../../model/BlogListResponseModel.dart' as blog;
import '../../model/BlogListResponseModel.dart';
import '../../model/CategoryList.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/responsive.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  _BlogsPageState createState() => _BlogsPageState();
}

class _BlogsPageState extends BaseState<BlogsPage> {
  List<blog.ItemBlogs> listData = List<blog.ItemBlogs>.empty(growable: true);
  List<Category> listCategory =[];
  // List<Url> listFilterData = List<Url>.empty();

  bool _isLoading = false;
  ScrollController _scrollViewController = ScrollController();

  bool _isLoadingMore = false;
  int _pageIndex = 0;
  final int _pageResult = 10;
  bool _isLastPage = false;
  bool isScrollingDown = false;
  String selectedCategory = "all";

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
      // getFilterData();
      getCategoryList();

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

    print("IS SMALL === ${ResponsiveWidget.isMediumScreen(context)}");
    print("IS WIDTH === ${MediaQuery.of(context).size.width}");

    return ResponsiveWidget.isMediumScreen(context)
        ? Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              toolbarHeight: 55,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: getBackArrow(),
              ),
              title: getTitle("Feeds",),
              actions: [
                Visibility(
                  visible: false,
                  child: InkWell(
                    onTap: () {
                      _showFilterDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(toDisplayCase(selectedCategory),
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
              centerTitle: true,
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
        )
        : Scaffold(
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
          title: getTitle("Alpha Capital Blog",),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isInternetConnected
            ? _isLoading
            ? const LoadingWidget()
            : listData.isEmpty
            ? const Center(child: MyNoDataWidget(msg: 'No blogs data found!'))
            :  _setDataForWeb()
            : const NoInternetWidget()
    ) ;

  }

  SafeArea _setDataForWeb() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 34,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: listCategory.length,
                      itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                           for(var i = 0; i<listCategory.length ; i++)
                             {
                               listCategory[i].isSelected = false;
                             }
                           listCategory[index].isSelected = true;
                           setState(() {
                             selectedCategory = listCategory[index].category.toString();
                           });
                           getList(true);
                          },
                          child: Container(
                              margin: const EdgeInsets.only( right: 8),
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: listCategory[index].isSelected ?? false ? blue : white,
                                border: Border.all(
                                  width: 1,
                                  color: listCategory[index].isSelected ?? false ? blue : white,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                  child: Text(toDisplayCase(listCategory[index].category.toString()),
                                    style: TextStyle(color: listCategory[index].isSelected ?? false ? white : black, fontSize: 16),
                                  )
                              )
                          ),
                        ),
                      )
                  ),
                ),
              ),
              Container(height: 28,),
              Expanded(
                  child:SingleChildScrollView(
                    controller: _scrollViewController,
                    child: AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 332,
                            crossAxisCount: 2, // number of items in each row
                            mainAxisSpacing: 22.0, // spacing between rows
                            crossAxisSpacing: 22.0, // spacing between columns
                          ),
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
                                    //push(MaterialPageRoute(builder: (context) => BlogsDetailPage(listData[index])));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogsDetailPage(listData[index])),);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        border:Border.all(color: lightGrey, width: 1,)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 160,
                                            width: MediaQuery.of(context).size.width,
                                            // color: grayLight,
                                            child: listData[index].blogImage.toString().isNotEmpty
                                                ? FadeInImage.assetNetwork(
                                              image: listData[index].blogImage.toString(),
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context).size.width,
                                              height: 160,
                                              placeholder: 'assets/images/ic_alpha_logo.png',
                                            ) : Image.asset('assets/images/ic_alpha_logo.png',
                                                width: 50, height: 50),
                                          ),
                                          const Gap(10),
                                          SizedBox(
                                            height: 40,
                                            child: Text(toDisplayCase(listData[index].title.toString()  + "\n"),
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Gap(10),
                                          Text(checkValidString(listData[index].publishedBy!.toString()),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 15, color: blue, fontWeight: FontWeight.w500),
                                          ),
                                          const Gap(15),
                                          const Divider(
                                            height: 0.5,
                                            color: lightGrey,
                                            thickness: 1,
                                          ),
                                          const Gap(20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listData[index].publishedDateView.toString(),
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
                                          // const Gap(10),
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
                  )
              ),
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

  Future<void> push(Route route) {
    return NavigationService.navigatorKey.currentState!.push(route);
  }

  SafeArea _setData() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(height: 12,),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 34,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: listCategory.length,
                      itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            for(var i = 0; i<listCategory.length ; i++)
                            {
                              listCategory[i].isSelected = false;
                            }
                            listCategory[index].isSelected = true;
                            setState(() {
                              selectedCategory = listCategory[index].category.toString();
                            });
                            getList(true);
                          },
                          child: Container(
                              margin: const EdgeInsets.only( right: 8),
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: listCategory[index].isSelected ?? false ? blue : white,
                                border: Border.all(
                                  width: 1,
                                  color: listCategory[index].isSelected ?? false ? blue : white,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                  child: Text(toDisplayCase(listCategory[index].category.toString()),
                                    style: TextStyle(color: listCategory[index].isSelected ?? false ? white : black, fontSize: 16),
                                  )
                              )
                          ),
                        ),
                      )
                  ),
                ),
              ),
              Container(height: 12,),
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
                                    //push(MaterialPageRoute(builder: (context) => BlogsDetailPage(listData[index])));

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogsDetailPage(listData[index])),);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border:Border.all(color: Colors.black, width: 0.7,)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 160,
                                            width: MediaQuery.of(context).size.width,
                                            // color: grayLight,
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: listData[index].blogImage.toString().isNotEmpty
                                                      ? FadeInImage.assetNetwork(
                                                        image: listData[index].blogImage.toString(),
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 160,
                                                        placeholder: 'assets/images/bg_gray.jpeg',
                                                      )
                                                      : Image.asset('assets/images/bg_gray.jpeg', width: 50, height: 50),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 12,right: 12),
                                                  decoration: BoxDecoration(color: blue,borderRadius: BorderRadius.circular(22)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                                    child: Text(listData[index].category.toString(),style: const TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w400)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Gap(10),
                                          Text(checkValidString(listData[index].title.toString()),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.bold),
                                          ),
                                          const Gap(10),
                                          Text(checkValidString(listData[index].publishedBy?.toString()),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 15, color: blue, fontWeight: FontWeight.w500),
                                          ),
                                          const Gap(15),
                                          const Divider(
                                            height: 0.5,
                                            color: black,
                                            thickness: 0.5,
                                          ),
                                          const Gap(15),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(getDateFromTimeStampNew(int.parse(listData[index].publishedDate.toString())),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(fontSize: 14, color: grayDark, fontWeight: FontWeight.w500),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
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
          return Wrap(
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter updateSetState) {
                    return Padding(
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
                            child: const Text("Filter", style: TextStyle(color: black, fontWeight: FontWeight.w600, fontSize: 18)),
                          ),
                          Container(height: 6),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listCategory.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    updateSetState(() {
                                       selectedCategory = listCategory[index].category.toString();

                                       for (var i = 0; i < listCategory.length; i++)
                                         {
                                           if (index == i)
                                             {
                                               listCategory[i].isSelected = true;
                                             }
                                           else
                                             {
                                               listCategory[i].isSelected = false;
                                             }
                                         }
                                     });
                                    Navigator.pop(context);
                                    getList(true);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Gap(6),
                                      Text(toDisplayCase(listCategory[index].category.toString()),style: TextStyle(color: listCategory[index].isSelected ?? false ? blue : black,fontWeight: FontWeight.w400,fontSize: 16),),
                                      const Gap(6),
                                      const Divider(height: 0.7,thickness: 0.7,color: gray,)
                                    ],
                                  ),
                                );
                              },
                          )
                        ],
                      ),
                    );
                  }),
            ],
          );
        });

  }

  //API call func..
  void getList(bool isFirstTime) async {
    if (isFirstTime) {
      setState(() {
         _isLoading = true;
        _isLoadingMore = false;
        _pageIndex = 0;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://www.alphacapital.in/api/admin/blogs/list");
    Map<String, String> jsonBody = {
      'apiId': "YzMxYjMyMzY0Y2UxOWNhOGZjZDE1MGE0MTdlY2NlNTg=",
      'category': selectedCategory,
      'from_app': "true",
      'limit': "10",
      'page': _pageIndex.toString(),
      'status': "active"
    };

    final response = await http.post(url,body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> codes = jsonDecode(body);
    var dataResponse = BlogListResponseModel.fromJson(codes);

    if (isFirstTime) {
      if (listData.isNotEmpty) {
        listData = [];
      }
    }

    if (statusCode == 200) {
      if (dataResponse.itemBlogs != null) {

        List<ItemBlogs>? _tempList = [];
        _tempList = dataResponse.itemBlogs;
        listData.addAll(_tempList!);

        print(listData.length);


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

  void getCategoryList() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://www.alphacapital.in/api/admin/blogs/category");

    Map<String, String> jsonBody = {
      'apiId': "YzMxYjMyMzY0Y2UxOWNhOGZjZDE1MGE0MTdlY2NlNTg=",
      'from_app': "true",
    };

    final response = await http.post(
        url, body: jsonBody); //post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> codes = jsonDecode(body);
    var dataResponse = CategoryList.fromJson(codes);

    if (statusCode == 200) {
      listCategory = [];
      listCategory.add(Category(category: "all", isSelected: true));

      List<Category>? dataList = dataResponse.category;
      listCategory.addAll(dataList ?? []);
      print(listCategory.length);

      getList(true);
    }

  }


/*void getFilterData() async {
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
    var dataResponse = blog.BlogListResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.itemBlogs!;

      setState(() {
        _isLoading = false;
      });

    }else {
      setState(() {
        _isLoading = false;
      });
    }

  }*/



}