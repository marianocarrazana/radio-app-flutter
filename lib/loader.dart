import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:palette_generator/palette_generator.dart';

import 'player.dart';
import 'utils.dart';

class Loader extends StatelessWidget {
  final box = GetStorage();
  final Player p = Get.put(Player());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onLoad(context));
    p.loadStatus.value = 0;
    return Scaffold(
        body: Container(
      color: Colors.grey[900],
      child: Container(
          margin: EdgeInsets.all(50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: RichText(
                    text: TextSpan(
                      text: 'Mi',
                      style: TextStyle(
                          color: Color(0xff66aaff),
                          fontSize: 64,
                          fontFamily: 'Roboto'),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Radio',
                            style: TextStyle(color: Color(0xff00ff00))),
                        TextSpan(
                            text: '.live',
                            style: TextStyle(color: Color(0xffff66ff))),
                      ],
                    ),
                  ),
                ),
                //Image.asset("assets/miradio.png"),
                Obx(
                  () => LinearProgressIndicator(
                    value: p.getStatus(),
                    semanticsLabel: 'Linear progress indicator',
                  ),
                )
              ])),
    ));
  }

  
}
