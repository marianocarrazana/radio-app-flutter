import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';

//import 'loader.dart';
import 'home.dart';

void main() async{
  //await GetStorage.init();
  /*if(GetPlatform.isAndroid){
    print("isAndroid");
    runApp(
    AudioServiceWidget(child: MyApp()),
  );
  }
  else {
    print("Is not android");*/
    runApp( MyApp() );
  //}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Radio App',
      getPages: Router.route,
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //home: Loader(),
      initialRoute: '/home',
    );
  }
}

class Router {
  static var route = [
    //GetPage(name: '/loader', page: () => Loader()),
    GetPage(name: '/home', page: () => Home()),
  ];
}
