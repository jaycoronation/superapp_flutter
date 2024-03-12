import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/screen/common/video_player_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/colors.dart';
import '../../model/video_data_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/responsive.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends BaseState<VideoListPage> {
  List<Items> listData = List<Items>.empty();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if(isInternetConnected) {
      getData();
    }else{
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget.isMediumScreen(context)
        ?  Scaffold(
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
            title: const Text("Videos",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: white,
          ),
          body: isInternetConnected
              ? _isLoading
              ? const LoadingWidget()
              : SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: listData.isEmpty ?
                const Center(
                    child: MyNoDataWidget(msg: 'No videos found!')
                )
                    :AnimationLimiter(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
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

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlayerScreen(listData[index].id!.videoId.toString())));

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
                                        child: listData[index].snippet!.thumbnails!.high!.url.toString().isNotEmpty
                                            ? FadeInImage.assetNetwork(
                                          image: listData[index].snippet!.thumbnails!.high!.url.toString(),
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 160,
                                          placeholder: 'assets/images/ic_alpha_logo.png',
                                        ) : Image.asset('assets/images/ic_alpha_logo.png',
                                            width: 50, height: 50),
                                      ),
                                      const Gap(10),
                                      Text(checkValidString(listData[index].snippet!.title.toString()),
                                        // textAlign: TextAlign.start,
                                        maxLines: 4,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.bold),
                                      ),
                                      const Gap(15),
                                      const Divider(height: 0.5, color: black, thickness: 1,),
                                      const Gap(25),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM,yyyy", listData[index].snippet!.publishedAt.toString()),
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
                                      const Gap(10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                )
            ),)
              : const NoInternetWidget(),
        )
        :  Scaffold(
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
            title: Text("Videos",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18, color: black, fontWeight: FontWeight.w800),
            ),
            centerTitle: false,
            elevation: 0,
            titleSpacing: 0,
            backgroundColor: white,
          ),
          body: isInternetConnected
              ? _isLoading
              ? const LoadingWidget()
              : SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: listData.isEmpty ?
                const Center(
                    child: MyNoDataWidget(msg: 'No videos found!')
                )
                    :AnimationLimiter(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 310,
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 22.0, // spacing between rows
                        crossAxisSpacing: 22.0, // spacing between columns
                      ),
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                                if(kIsWeb)
                                {
                                  launchUrl(Uri.parse("https://www.youtube.com/watch?v=${listData[index].id!.videoId.toString()}"));
                                }
                                else
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPlayerScreen(listData[index].id!.videoId.toString())
                                      )
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border:Border.all(color: lightGrey, width: 0.6,)
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
                                        child: listData[index].snippet!.thumbnails!.high!.url.toString().isNotEmpty
                                            ? FadeInImage.assetNetwork(
                                          image: listData[index].snippet!.thumbnails!.high!.url.toString(),
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 160,
                                          placeholder: 'assets/images/ic_alpha_logo.png',
                                        ) : Image.asset('assets/images/ic_alpha_logo.png',
                                            width: 50, height: 50),
                                      ),
                                      const Gap(10),
                                      Text(checkValidString("${listData[index].snippet!.title}\n\n"),
                                        // textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w500),
                                      ),
                                      const Gap(15),
                                      const Divider(height: 0.5, color: lightGrey, thickness: 0.6,),
                                      const Gap(25),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM,yyyy", listData[index].snippet!.publishedAt.toString()),
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
                                      const Gap(10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                )
            ),)
              : const NoInternetWidget(),
        );
  }


  @override
  void castStatefulWidget() {
    widget is VideoListPage;
  }

  //API call func..
  void getData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://www.alphacapital.in/youtube.php");
    final response = await http.get(url);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = VideoDataResponseModel.fromJson(user);

    if (statusCode == 200) {
      listData = dataResponse.items!;
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