// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_declarations, no_leading_underscores_for_local_identifiers, unnecessary_this

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ghada/utils/colors.dart';
import 'package:ghada/widgets/loadingWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RehabDetail extends StatefulWidget {
  final String name;
  final BluetoothDevice server;
  final String video;
  final int indx;

  RehabDetail(this.name, this.video, this.indx, this.server);

  static const routeName = "/RehabDetail";

  @override
  State<RehabDetail> createState() => _RehabDetailState();
}

class _RehabDetailState extends State<RehabDetail> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  int counter = 0;
  bool playingMessage = false;
  Timer? timer;
  BluetoothConnection? connection;
  List<String> messages = [];
  String checkConnectivity = '';

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  @override
  void initState() {
    messages.add('No messages yet!');
    try {
      controller = VideoPlayerController.asset('assets/videos/${widget.video}');
      _initializeVideoPlayerFuture = controller.initialize();
      controller.setLooping(true);
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
            checkConnectivity =
                AppLocalizations.of(context)!.disconnectingLocally;
          });
        } else {
          setState(() {
            checkConnectivity =
                AppLocalizations.of(context)!.disconnectedRemotely;
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
              _sendMessage('stopRehabilitaion${widget.indx + 1}');
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
                                      'playRehabilitaion${widget.indx + 1}');
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
            checkConnectivity,
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
    );
  }

  String getTimerString(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _onDataReceived(Uint8List data) {
    String dataString = String.fromCharCodes(data);
    setState(() {
      if (messages[0] == "No messages yet!") {
        messages.removeAt(0);
      }
      if(messages.length>5){
        messages.removeRange(0, messages.length - 5);
      }
      messages.add(dataString);
    });
  }

  void _sendMessage(String text) async {
    try {
      Uint8List data = Uint8List.fromList(utf8.encode("$text\r\n"));
      connection!.output.add(data);
      await connection!.output.allSent;
    } catch (e) {
      setState(() {});
    }
  }
}
