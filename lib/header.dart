import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'player.dart';

class Header extends StatelessWidget {
  final Player p = Get.put(Player());
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child:Column(children:<Widget>[
          Obx(() => Text('${p.radioName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(p.textColor.value),
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color(p.textShadowColor.value),
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
              child: Obx(() => Text('${p.info.value}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(p.textColor.value),
                    fontSize: 28,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color(p.textShadowColor.value),
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  )))),
          SizedBox(width: 10),
          ClipOval(child: Obx(()=>Container(color: p.info.value=="Radio Offline"?Colors.red:Colors.green, width: 16, height: 16)))
        ])]));
  }
}
