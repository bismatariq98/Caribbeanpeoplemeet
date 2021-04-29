import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget postImage(context, String imageURL,
    {double width = 500, double height = 300}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: Get.width - 50,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(imageURL), fit: BoxFit.fitHeight)),
        ),
      ),
    ),
    // ClipRRect(
    //   borderRadius: BorderRadius.circular(15.0),
    //   child: CachedNetworkImage(
    //     imageUrl: imageURL,
    //     placeholder: (context, url) => Container(
    //       transform: Matrix4.translationValues(0.0, 0.0, 0.0),
    //       child: Container(
    //           width: width,
    //           height: height,
    //           child: Center(child: new CircularProgressIndicator())),
    //     ),
    //     errorWidget: (context, url, error) => new Icon(Icons.error),
    //     width: 500,
    //     height: 300,
    //     fit: BoxFit.cover,
    //   ),
    // ),
  );
}
