import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:intl/intl.dart';

class LikeController extends GetxController {
 String TIMESTAMP = "timestamp";
UserController userController = Get.put(UserController());
 Future<void> _saveLike({
    @required String likedUserId,
    @required String userDeviceToken,
    @required String nMessage,
  }) async {
    FirebaseFirestore.instance.collection("C_LIKES").add({
      "LIKED_USER_ID": likedUserId,
      "LIKED_BY_USER_ID": userController.currentUserId,
      "TIMESTAMP": FieldValue.serverTimestamp()
    }).then((_) async {
      /// Update user total likes
      await userController.updatelikeData(
          userId: likedUserId,
          data: {"USER_TOTAL_LIKES": FieldValue.increment(1).toString()});

      /// Save notification in database
      // await _notificationsApi.saveNotification(
      //   nReceiverId: likedUserId,
      //   nType: 'like',
      //   nMessage: nMessage,
      // );

      /// Send push notification
  //     await _notificationsApi.sendPushNotification(
  //         nTitle: APP_NAME,
  //         nBody: nMessage,
  //         nType: 'like',
  //         nSenderId: UserModel().user.userId,
  //         nUserDeviceToken: userDeviceToken);
  //   });
  // }

  /// Like user profile
  Future<void> likeUser(
      {@required String likedUserId,
      @required String userDeviceToken,
      @required String nMessage,
      @required Function(bool) onLikeResult}) async {
    /// Check if current user already liked profile
    FirebaseFirestore.instance
      .collection("C_LIKES")
      .where("LIKED_BY_USER_ID", isEqualTo: userController.currentUserId).
      where("LIKED_USER_ID", isEqualTo: likedUserId)
      .get()
      .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isEmpty) {
            onLikeResult(true);
            // Like user
            await _saveLike(
                likedUserId: likedUserId,
                nMessage: nMessage,
                userDeviceToken: userDeviceToken);
            debugPrint('likeUser() -> success');
          } else {
            onLikeResult(false);
            debugPrint('You already liked the user');
          }
    }).catchError((e) {
      print('likeUser() -> error: $e');
    });
  }


    });}}