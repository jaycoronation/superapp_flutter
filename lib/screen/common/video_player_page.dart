import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';


class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen(this.videoUrl, {Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends BaseState<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    AutoOrientation.portraitAutoMode();

    print( (widget as VideoPlayerScreen).videoUrl.toString());
    _controller = YoutubePlayerController(
      initialVideoId:  (widget as VideoPlayerScreen).videoUrl.toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        hideControls: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }
    else
    {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    AutoOrientation.portraitAutoMode();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,

            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              Navigator.pop(context);
            },
          ),
          builder: (context, player) => Scaffold(
            appBar :AppBar(
              toolbarHeight: 55,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(right: 8),
                              child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: white,),
                            )
                        ),
                        const Spacer()
                      ],
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: black,
            ),
            body: Container(
              color: black,
              alignment: Alignment.center,
              child: player,
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        });
  }

  @override
  void castStatefulWidget() {
    widget is VideoPlayerScreen;
  }
}
