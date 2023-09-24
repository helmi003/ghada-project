// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_declarations, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghada/utils/colors.dart';
import 'package:video_player/video_player.dart';

class ReductionTest extends StatefulWidget {
  final String name;
  final String video;

  ReductionTest(this.name, this.video);

  static const routeName = "/ReductionTest";

  @override
  State<ReductionTest> createState() => _ReductionTestState();
}

class _ReductionTestState extends State<ReductionTest> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  StreamController<bool> loopController = StreamController<bool>();
  int counter = 0;
  Timer? timer;

  bool isDisconnecting = false;
  @override
  void initState() {
    try {
      controller = VideoPlayerController.asset('assets/videos/${widget.video}');
      _initializeVideoPlayerFuture = controller.initialize();
      controller.setLooping(false);

      controller.addListener(() {
        if (controller.value.position == controller.value.duration) {
          loopController.add(true);
        }
      });
      loopController.stream.listen((isLooping) {
        if (isLooping) {
          setState(() {
            counter = 0;
          });
        }
      });
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
    loopController.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(widget.name),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
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
                return Center(
                    child: CircularProgressIndicator(
                  color: lightColor,
                ));
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
                    counter.toString(),
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: lightColor),
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
                              if (!controller.value.isPlaying) {
                                controller.pause();
                              }
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: lightColor),
                  borderRadius: BorderRadius.circular(20),
                  color: warmBlueColor),
              child: Center(
                  child: Text(
                'Message',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: lightColor),
              )),
            ),
          )
        ],
      ),
    );
  }
}
