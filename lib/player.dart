import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:typed_data';
import 'package:palette_generator/palette_generator.dart';
//import 'package:get_storage/get_storage.dart';

import 'contact.dart';

class Player extends GetxController {
  final ContactList c = Get.put(ContactList());
  final _player = AssetsAudioPlayer();
  final playing = RxBool(false);
  final loadStatus = RxInt(0);
  final vibrantColor = RxInt(0xffffffff);
  final _dominantColor = RxInt(0xff000000);
  final textColor = RxInt(0xffffffff);
  final textShadowColor = RxInt(0x66555555);
  final radioUrl = RxString("");
  final info = RxString("Cargando...");
  final domain = RxString("");
  final _radioName = "".obs;
  bool _autostart = false;
  final customNotification = NotificationSettings(
       prevEnabled: false, nextEnabled: false, stopEnabled: false,
       customPlayPauseAction:(p){
        //if(p.isPlaying)
        p.stop();
       }
   );
  //final playerLogo = RxString(''):
  //final playerBackground = RxString('');
  play() { 
    if(radioUrl.value=="")return false;
    playing.value = !playing.value;
    if(playing.value){
      _autostart = true;
      _player.open(Audio.liveStream(radioUrl.value), showNotification: true, notificationSettings:customNotification);
    }
    else {
      _autostart = false;
      _player.stop();
    }
  }
  setDomain(data)=>domain.value = data;
  setRadioUrl(url){
    //_player.setUrl(url);
    radioUrl.value = url;
  }
  setVibrantColor(c){ vibrantColor.value = c;vibrantColor.refresh();}
  void set dominantColor(c) => _dominantColor.value = c;
  int get dominantColor => _dominantColor.value;
  void set radioName(name) => _radioName.value = name;
  String get radioName => _radioName.value;
  setTextColor(c) => textColor.value = c;
  setTextShadowColor(c) => textShadowColor.value = c;
  addLoadPercent(percent) {
    loadStatus.value += percent;
    if (loadStatus.value == 100) {
      Get.offNamed('/home');
      startInfoTimer();
    }
  }

  getStatus() {
    double v = loadStatus.value / 100;
    return v;
  }
  void parseShoutcastData(response){
    var radioData = jsonDecode(response.body);
        if(radioData['activestreams']!=1){
          info.value = "Radio Offline";
          _player.stop();
        }
        else{
          if(radioData['streams'][0]['songtitle']=="")info.value = "Radio Online";
          else info.value = radioData['streams'][0]['songtitle'];
          
        }
  }
  void parseIcecastData(response){
    var radioData = jsonDecode(response.body);
    radioData = radioData['icestats'];
        if(radioData['source']==null){
          info.value = "Radio Offline";
          _player.stop();
        }
        else{
          var title;
          RegExp exp = RegExp(r'\/stream\"[^\}]+title\":\"([^\"]+)\"');
          var matches = exp.firstMatch(response.body);
          if(matches==null){
            exp = RegExp(r'\/live\"[^\}]+title\":\"([^\"]+)\"');
            matches = exp.firstMatch(response.body);
            if(matches==null){
              exp = RegExp(r'\/autodj\"[^\}]+title\":\"([^\"]+)\"');
              matches = exp.firstMatch(response.body);
            }
          }
          if(matches!=null)title = matches.group(1);
          if(title=="" || title == null)info.value = "Radio Online";
          else info.value = title;
        }
  }
  startInfoTimer(){
    int errorCounter = 0;
    bool waiting = false;
    Timer.periodic(Duration(milliseconds: 1500), (timer) {
      if(waiting || radioUrl.value == "")return false;
      waiting = true;
      http.get(Uri.parse('$radioUrl/statistics'))
      //http.get(Uri.parse('http://192.168.2.77:8002/status-json.xsl'))
      .then((response) {
        errorCounter = 0;
        if (response.statusCode == 200) {
        //autostart=parseIcecastData(response,autostart);
        if(radioUrl.contains("icecast"))parseIcecastData(response);
        else parseShoutcastData(response);
        if (_autostart && !playing.value){
          playing.value = true;
            _player.open(Audio.liveStream(radioUrl.value), showNotification: true, notificationSettings:customNotification);
          }
        } else {
        throw Exception('Failed to load radio');
      }
      })
      .catchError((e) {
        print(e);
        errorCounter++;
        if(errorCounter>3){
          info.value = "Radio Offline";
          //this.errored = true;
          _player.stop();
          playing.value = false;
          _autostart = true;
        }
      })
      .whenComplete((){
        waiting=false;
        //this.$store.commit('changeSongTitle',this.info);
      });
    });
  }
  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    int id = 60;
    http
        .get(Uri.https(
            'larutaproducciones.com.ar', 'usuarios/api/app/info/id/$id'))
        .then((e) {
      if (e.statusCode == 200) {
        var radioData = jsonDecode(e.body);
        print(radioData);
        setRadioUrl(radioData["radio_url"]);
        addLoadPercent(30);
        c.setContactList(radioData["contact"]);
        setDomain(radioData["domain"]);
        radioName = radioData["name"];
        startInfoTimer();
        /*var logoUrl,backgroundUrl;
        if(radioData['images']==null){
          logoUrl =
        "https://larutaproducciones.com.ar/usuarios/public/images/radio_logos/$id.png";
          backgroundUrl =
        "https://larutaproducciones.com.ar/usuarios/public/images/radio_backgrounds/$id.jpg";
        }else {
          logoUrl = radioData['images']['logo'];
          backgroundUrl = radioData['images']['background'];
        }
        if (box.read("logo") == null || logoUrl != box.read('logo_url')) {
          box.write("logo_url",logoUrl);
          NetworkAssetBundle(Uri.parse(logoUrl)).load("").then((imageData) {
            final Uint8List bytes = imageData.buffer.asUint8List();
            box.write('logo', bytes);
            getLogoColors(bytes);
          });
        } else {
          var logo = getImageFromStorage('logo');
          getLogoColors(logo);
        }
        if (box.read("background") == null || backgroundUrl != box.read('background_url')) {
          NetworkAssetBundle(Uri.parse(backgroundUrl))
              .load("")
              .then((imageData) {
            final Uint8List bytes = imageData.buffer.asUint8List();
            box.write('background', bytes);
            getBackgroundColors(bytes);
          });
        } else {
          var background = getImageFromStorage('background');
          getBackgroundColors(background);
        }*/
      } else {
        throw Exception('Failed to load radio');
      }
    });
  }
/*
  void getBackgroundColors(Uint8List image) {
    var img = MemoryImage(image);
    PaletteGenerator.fromImageProvider(img).then((palette) {
      var dominant = palette.dominantColor;
      setTextColor(dominant.titleTextColor.withAlpha(255).value);
      setTextShadowColor(dominant.bodyTextColor.value);
      addLoadPercent(35);
    });
  }

  void getLogoColors(Uint8List image) {
    var img = MemoryImage(image);
    PaletteGenerator.fromImageProvider(img).then((palette) {
      int vibrantColor = palette.vibrantColor?.color?.value ?? 0xff000000;
      setVibrantColor(vibrantColor);
      int vibrantBackColor = palette.vibrantColor?.bodyTextColor?.value ?? 0xffffffff;
      dominantColor = vibrantBackColor;
      addLoadPercent(35);
    });
  }*/
}
