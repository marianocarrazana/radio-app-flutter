import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';
import 'dart:typed_data';

import 'bottombar.dart';
import 'header.dart';
import 'player.dart';
import 'contact.dart';

class Home extends StatelessWidget {
  //final Player p = Get.put(Player());
  //final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    //var logo = getImageFromStorage('logo');
    //var background = getImageFromStorage('background');
    return Scaffold(
        //appBar: PreferredSize(preferredSize: const Size.fromHeight(100.0),child:Text('App Title')),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              //image: MemoryImage(background),
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Header(),
                Divider(
                    height: 50,
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey.shade300),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.all(25.0),
                        //child: Image.memory(logo))),
                        child:Image.asset('assets/logo.png',filterQuality: FilterQuality.medium))),
                //ContactInfo(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}
