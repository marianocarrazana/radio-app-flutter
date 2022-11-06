import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'player.dart';
import 'package:ionicons/ionicons.dart';
import 'package:auto_animated/auto_animated.dart';

class BottomBar extends GetView<Player> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ConvexAppBar.builder(
          count: 1,
          height: 35,
          curveSize: 75,
          elevation: 5,
          backgroundColor: Color(controller.dominantColor),
          itemBuilder: BottomBarBuilder(),
          onTap: (index) {
            //controller.play();
            //await AudioService.start(backgroundTaskEntrypoint: _entrypoint)
          },
        ));
  }
}

// user defined class
class BottomBarBuilder extends DelegateBuilder {
  final Player p = Get.put(Player());
  @override
  Widget build(BuildContext context, int index, bool active) {
    AnimatedIconData ic;
    if (p.playing.value)
      ic = AnimatedIcons.pause_play;
    else
      ic = AnimatedIcons.play_pause;
    var co = p.vibrantColor.value;
    var iconColor = Color(co);
    var iconSize = 64.0;
    return LiveIconButton(
      icon: ic,
      onPressed: () {
        p.play();
      },
      padding: EdgeInsets.all(0),
      color: iconColor,
      size: iconSize,
      semanticLabel: 'Play or pause',
    );
  }
}
