import 'dart:async';
import 'dart:math';
//import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

class FullScreenImage extends StatefulWidget {
  final String imgPath;
  FullScreenImage(this.imgPath);

  @override
  FullScreenImageState createState() => new FullScreenImageState();
}

class FullScreenImageState extends State<FullScreenImage>
    with SingleTickerProviderStateMixin {
  bool downloading = false;
  var progress = "";
  Permission permission1 = Permission.WriteExternalStorage;
  static final Random random = Random();


  final LinearGradient backgroundGradient = LinearGradient(
      colors: [Color(0x10000000), Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: downloading
              ? Container(
                  decoration: BoxDecoration(gradient: backgroundGradient),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: widget.imgPath,
                          child: FadeInImage(
                            image: NetworkImage(widget.imgPath),
                            fit: BoxFit.cover,
                            placeholder: AssetImage('wallfy.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.black45,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(gradient: backgroundGradient),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: widget.imgPath,
                          child: FadeInImage(
                            image: NetworkImage(widget.imgPath),
                            fit: BoxFit.cover,
                            placeholder: AssetImage('wallfy.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AppBar(
                              elevation: 0.0,
                              backgroundColor: Colors.transparent,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
}
