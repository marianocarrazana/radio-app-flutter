import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ionicons/ionicons.dart';
import 'package:auto_animated/auto_animated.dart';

import 'player.dart';

class ContactList extends GetxController {
  final _phone = "".obs;
  final _whatsapp = "".obs;
  final _facebook = "".obs;
  final _twitter = "".obs;
  final _email = "".obs;
  final _instagram = "".obs;
  String get phone => _phone.value;
  String get whatsapp => _whatsapp.value;
  String get facebook => _facebook.value;
  String get twitter => _twitter.value;
  String get email => _email.value;
  String get instagram => _instagram.value;
  void setContactList(contact){
    contact = contact ?? Map<String,dynamic>();
    _phone.value = contact['phone'];
    _whatsapp.value = contact['whatsapp'];
    _facebook.value = contact['facebook'];
    _twitter.value = contact['twitter'];
    _email.value = contact['email'];
    _instagram.value = contact['instagram'];
  }
}

class ContactInfo extends StatelessWidget {
  final Player p = Get.put(Player());
  final ContactList c = Get.put(ContactList());
  @override
  Widget build(BuildContext context) {
    double iconsSize = 42;
    double iconsMargin = 20;
    return Obx(()=>Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          margin: EdgeInsets.symmetric(horizontal: iconsMargin),
          child: IconButton(
              icon: Icon(Ionicons.home, color: Color(p.textColor.value), size: iconsSize),
              onPressed: () {
                launchURL('http://${p.domain.value}');
              })),
      (c.phone != "" && c.phone != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.call, color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('tel:${c.phone}');
                  }))
          : SizedBox.shrink(),
      (c.whatsapp != "" && c.whatsapp != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.logo_whatsapp,
                      color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('https://wa.me/${c.whatsapp}');
                  }))
          : SizedBox.shrink(),
      (c.facebook != "" && c.facebook != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.logo_facebook,
                      color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('${c.facebook}');
                  }))
          : SizedBox.shrink(),
      (c.twitter != "" && c.twitter != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.logo_twitter,
                      color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('${c.twitter}');
                  }))
          : SizedBox.shrink(),
      (c.email != "" && c.email != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.mail, color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('mailto:${c.twitter}');
                  }))
          : SizedBox.shrink(),
      (c.instagram != "" && c.instagram != null)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: iconsMargin),
              child: IconButton(
                  icon: Icon(Ionicons.logo_instagram,
                      color: Color(p.textColor.value), size: iconsSize),
                  onPressed: () {
                    launchURL('${c.instagram}');
                  }))
          : SizedBox.shrink(),
    ]));
  }
}

void launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
