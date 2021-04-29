import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  PostModel(
      {this.username,
      this.likeList,
      this.loveList,
      this.hahaList,
      this.angryList,
      this.sadList,
      this.wowList,
      this.userId,
      this.userPic,
      this.time,
      this.postId,
      this.content,
      this.postPhoto,
      this.totalLike = 0,
      this.totalLove = 0,
      this.totalHaha = 0,
      this.totalWow = 0,
      this.totalSad = 0,
      this.totalAngry = 0,
      this.totalComments = 0,
      this.totalShares = 0,
      this.lcbyUserId,
      this.lcUserphoto,
      this.lcUserName,
      this.lastComment,
      this.isPostShared = false,
      this.originalUserName,
      this.originalPostId,
      this.lastCommentTime,
      this.originalTime,
      this.originalUserPic,
      this.originalUserId,
      this.ref});

  String username;
  List likeList;
  List loveList;
  List hahaList;
  List wowList;
  List sadList;
  List angryList;
  String userId;
  String originalUserId;
  String userPic;
  var time;
  String postId;
  String content;
  String postPhoto;
  int totalLike;
  int totalLove;
  int totalHaha;
  int totalWow;
  int totalSad;
  int totalAngry;
  int totalComments;
  int totalShares;
  String lcbyUserId;
  String lcUserphoto;
  String lcUserName;
  String lastComment;
  var lastCommentTime;
  bool isPostShared;
  String originalUserName;
  var originalTime;
  String originalPostId;

  String originalUserPic;
  DocumentReference ref;

  factory PostModel.fromDocumentSnapShot(DocumentSnapshot doc) => PostModel(
      username: doc.data()["username"],
      userId: doc.data()["userId"],
      originalUserId: doc.data()["originalUserId"],
      userPic: doc.data()["userPic"],
      originalUserPic: doc.data()["originalUserPic"],
      time: doc.data()["time"],
      originalTime: doc.data()["originalTime"],
      postId: doc.reference.id,
      content: doc.data()["content"],
      postPhoto: doc.data()["postPhoto"],
      totalLike: doc.data()["totalLike"],
      totalLove: doc.data()["totalLove"],
      totalHaha: doc.data()["totalHAHA"],
      totalWow: doc.data()["totalWow"],
      totalSad: doc.data()["totalSad"],
      totalAngry: doc.data()["totalAngry"],
      totalComments: doc.data()["totalComments"],
      totalShares: doc.data()["totalShares"],
      lcbyUserId: doc.data()["lcbyUserId"],
      lcUserphoto: doc.data()["lcUserphoto"],
      lcUserName: doc.data()["lcUserName"],
      lastCommentTime: doc.data()["lcTime"],
      lastComment: doc.data()["lastComment"],
      isPostShared: doc.data()["isPostShared"],
      originalUserName: doc.data()["originalUserName"],
      originalPostId: doc.data()["originalPostId"],
      ref: doc.reference);

  Map<String, dynamic> toMap() => {
        "originalUserId": originalUserId,
        "username": username,
        "userId": userId,
        "userPic": userPic,
        "time": time,
        "originalUserPic": originalUserPic,
        "originalTime": originalTime,
        "postId": postId,
        "content": content,
        "postPhoto": postPhoto,
        "totalLike": totalLike,
        "totalLove": totalLove,
        "totalHAHA": totalHaha,
        "totalWow": totalWow,
        "totalSad": totalSad,
        "totalAngry": totalAngry,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "lcbyUserId": lcbyUserId,
        "lcUserphoto": lcUserphoto,
        "lcUserName": lcUserName,
        "lcTime": lastCommentTime,
        "lastComment": lastComment,
        "isPostShared": isPostShared,
        "originalUserName": originalUserName,
        "originalPostId": originalPostId,
      };
}
