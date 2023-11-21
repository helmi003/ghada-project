// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_declarations, no_leading_underscores_for_local_identifiers, unnecessary_this

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:video_player/video_player.dart';

class RehabTest extends StatefulWidget {
  final String name;
  final String video;

  RehabTest(this.name, this.video);

  static const routeName = "/RehabTest";

  @override
  State<RehabTest> createState() => _RehabTestState();
}

class _RehabTestState extends State<RehabTest> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  // StreamController<bool> loopController = StreamController<bool>();
  int counter = 0;
  bool playingMessage = false;
  Timer? timer;
  List<String> messages = [];
  @override
  void initState() {
    messages.add('No messages yet!');
    try {
      controller = VideoPlayerController.asset('assets/videos/${widget.video}');
      _initializeVideoPlayerFuture = controller.initialize();
      controller.setLooping(true);
      controller.setPlaybackSpeed(1.0);
      // controller.addListener(() {
      //   if (controller.value.position == controller.value.duration) {
      //     loopController.add(true);
      //   }
      // });
      // loopController.stream.listen((isLooping) {
      //   if (isLooping) {
      //     setState(() {
      //       counter = 0;
      //     });
      //   }
      // });
      controller.setVolume(0);
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (controller.value.isPlaying) {
          setState(() {
            counter++;
          });
        }
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    // loopController.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
          backgroundColor: warmBlueColor,
          centerTitle: true,
          title: Text(widget.name),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                playingMessage = false;
              });
              _sendMessage('the video is stopped: ${widget.name}');
            },
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          elevation: 0),
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 300,
                      ),
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  ),
                );
              } else {
                return LoadingWidget();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                controller.play();
                                if (!playingMessage) {
                                  _sendMessage(
                                      'The video is playing: ${widget.name}');
                                  playingMessage = true;
                                }
                              }
                            });
                          },
                          child: Center(
                            child: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40,
                              color: warmBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    getTimerString(counter),
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: warmBlueColor),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              controller.seekTo(Duration.zero);
                              counter = 0;
                              controller.pause();
                            });
                          },
                          child: Center(
                            child: Icon(
                              Icons.refresh,
                              size: 40,
                              color: warmBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Text(
            'Not connected',
            style: TextStyle(
                color: warmBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: primaryColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: warmBlueColor,
              ),
              child: messages.length == 1 && messages[0] == "No messages yet!"
                  ? Center(
                      child: Text(
                      messages[0],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: lightColor,
                      ),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: silverColor.withOpacity(0.8),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            messages[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: lightColor,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: () {
            setState(() {
              if (messages[0] == "No messages yet!") {
                messages.removeAt(0);
              }
              if (messages.length > 5) {
                messages.removeRange(0, messages.length - 5);
              }
              messages.add('helmi');
            });
          }),
    );
  }

  String getTimerString(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _sendMessage(String text) async {
    try {
      print(text);
    } catch (e) {
      setState(() {});
    }
  }

  // void _onDataReceived(Uint8List data) {
  //   String dataString = String.fromCharCodes(data);
  //   setState(() {
  //     lastMessage = dataString;
  //   });
  // }
}
