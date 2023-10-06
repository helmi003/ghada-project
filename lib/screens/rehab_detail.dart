// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_declarations, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/backAppbar.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RehabDetail extends StatefulWidget {
  final String name;
  final BluetoothDevice server;
  final String video;

  RehabDetail(this.name, this.video, this.server);

  static const routeName = "/RehabDetail";

  @override
  State<RehabDetail> createState() => _RehabDetailState();
}

class _RehabDetailState extends State<RehabDetail> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  StreamController<bool> loopController = StreamController<bool>();
  int counter = 0;
  Timer? timer;
  BluetoothConnection? connection;
  String lastMessage = '';
  String checkConnectivity = '';

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  @override
  void initState() {
    lastMessage = AppLocalizations.of(context)!.noMessages;
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
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      setState(() {
        checkConnectivity = AppLocalizations.of(context)!.connected;
      });
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          setState(() {
            checkConnectivity = AppLocalizations.of(context)!.disconnectingLocally;
          });
        } else {
          setState(() {
            checkConnectivity = AppLocalizations.of(context)!.disconnectedRemotely;
          });
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      setState(() {
        checkConnectivity = AppLocalizations.of(context)!.cannotConnect;
      });
      print(error);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    loopController.close();
    controller.dispose();
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: backAppBar(context,widget.name),
      body:
          // Stack(
          //   children: [
          // Positioned(
          //   bottom: 10,
          //   right: 10,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Image.asset(
          //       'assets/images/laboratoire logo.jpeg',
          //       width: 100,
          //     ),
          //   ),
          // ),
          Column(
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
          Text(
            checkConnectivity,
            style: TextStyle(
                color: lightColor, fontSize: 20, fontWeight: FontWeight.w600),
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
                lastMessage,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: lightColor),
              )),
            ),
          )
        ],
      ),
      //   ],
      // ),
    );
  }

  void _onDataReceived(Uint8List data) {
    String dataString = String.fromCharCodes(data);
    setState(() {
      lastMessage = dataString;
    });
  }
}
