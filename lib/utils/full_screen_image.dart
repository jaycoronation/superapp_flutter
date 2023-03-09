import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path_provider/path_provider.dart';
import '../constant/colors.dart';
import 'app_utils.dart';

class FullScreenImageNew extends StatelessWidget {
  final String imageUrl;
  final List<String>? images;
  int selectedIndex;

  FullScreenImageNew(this.imageUrl, this.images, this.selectedIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController? controller = PageController(initialPage: selectedIndex);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: white,
          body: Container(
            color: white,
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  itemCount: images!.length,
                  pageController: controller,
                  onPageChanged: (int index) {
                    selectedIndex = index;
                  },
                  loadingBuilder: (context, event) => Image.asset(
                    'assets/images/bg_gray.jpeg',
                    fit: BoxFit.contain,
                  ),
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(images![index]),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 42, right: 12),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded),
                    color: black,
                    iconSize: 32,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 42, right: 12),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      if (kIsWeb) {
                        Share.share(images![selectedIndex].toString());
                      } else {
                        final uri = Uri.parse(images![selectedIndex].toString());
                        final response = await http.get(uri);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytes(bytes);
                        shareFileWithText("", path);
                      }
                    },
                    icon: Image.asset('assets/images/share.png', height: 24, width: 24, color: black),
                    color: black,
                    iconSize: 32,
                  ),
                ),
                images!.length > 1
                    ? Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.all(18),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: images!.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: black,
                      dotColor: Colors.grey,
                      // strokeWidth: 5,
                    ),
                  ),
                )
                    : Container()
              ],
            ),
          )),
    );
  }
}
