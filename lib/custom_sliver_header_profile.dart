import 'dart:math';

import 'package:flutter/material.dart';

class CustomSliverHeaderForProfilePic extends StatefulWidget {
  @override
  CustomSliverHeaderForProfilePicState createState() {
    return CustomSliverHeaderForProfilePicState();
  }
}

//const kToolbarHeight = 50.0;
const avatarSize = 125.0;
const minAvatarSize = 30.0;
const extraSpace = 50.0;

class CustomSliverHeaderForProfilePicState
    extends State<CustomSliverHeaderForProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Color(0XFF181818),
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                delegate:
                    MyHeaderDelegate(kToolbarHeight + avatarSize + extraSpace),
                pinned: true,
              ),
            ];
          },
          body: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.all(16),
                    height: 100,
                    child: Text("Portfolio No# $index")),
              ),
            ),
            itemCount: 6,
          ),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;

  MyHeaderDelegate(this.extendedHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("shrinkOffset: $shrinkOffset ... $overlapsContent");
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = avatarSize + extraSpace - shrinkOffset;
    double newAvatarSize = avatarSize - shrinkOffset;
    double newAvatarSpace = avatarSize - shrinkOffset;
    if (newSize == minExtent) {
      newSize = minExtent;
    }
    if (newAvatarSize < minAvatarSize) {
      newAvatarSize = minAvatarSize;
    }
    if (newAvatarSpace < 0) {
      newAvatarSpace = 0;
    }
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (avatarSize + extraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15);

    //double actionsXPosition = 50 * (1 - percent);

    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //color: Colors.brown,
            height: kToolbarHeight + newAvatarSpace,
            child: Stack(
              children: [
                AppBar(
                  title: Center(child: Text("App Bar")),
                  centerTitle: false,
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: minAvatarSize / 2,
                  left: avatarXPosition, //avatarXPosition,
                  //right: newAvatarSize > minAvatarSize ? avatarXPosition : 0.0,
                  child: CircleAvatar(
                    radius: newAvatarSize / 2,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage('shammi.jpg'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              "Shammi",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
