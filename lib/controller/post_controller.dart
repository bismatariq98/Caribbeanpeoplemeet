import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialtinder/controller/loading_controller.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PostController extends GetxController {
  // ReactionListController reactionListController =
  //     Get.put(ReactionListController());
  PostModel postData = PostModel();
  Loader loader = Get.put(Loader());
  UserController userController = Get.put(UserController());
  TextEditingController postTextController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  File postpic;
  bool actionBlocked = false;
  List<PostModel> allPosts = [];

  savePost() {
    if (!actionBlocked) {
      actionBlocked = true;
      uploadFile();
    }
  }

  // sharePost(PostModel post) {
  //   if (!actionBlocked) {
  //     actionBlocked = true;

  //     var sharedPost = PostModel();
  //     int totalShares = post.totalShares + 1;
  //     if (post.isPostShared) {
  //       sharedPost.originalPostId = post.originalPostId;
  //       sharedPost.originalUserId = post.originalUserId;
  //       sharedPost.originalTime = post.originalTime;
  //       sharedPost.originalUserName = post.originalUserName;
  //       sharedPost.originalUserPic = post.originalUserPic;
  //     } else {
  //       sharedPost.originalPostId = post.postId;
  //       sharedPost.originalUserId = post.userId;
  //       sharedPost.originalTime = post.time;
  //       sharedPost.originalUserName = post.username;
  //       sharedPost.originalUserPic = post.userPic;
  //     }
  //     sharedPost.userPic = userController.userData.profilePhoto;
  //     sharedPost.username = userController.userData.firstName +
  //         ' ' +
  //         userController.userData.lastName;
  //     sharedPost.userId = userController.userData.userId;
  //     sharedPost.isPostShared = true;
  //     sharedPost.content = post.content;
  //     sharedPost.postPhoto = post.postPhoto;
  //     sharedPost.time = FieldValue.serverTimestamp();
  //     post.ref.update({'totalShares': totalShares});
  //     firebase.collection('Posts').add(sharedPost.toMap()).then((ref) {
  //       ref.get().then((doc) {
  //         allPosts.insert(0, PostModel.fromDocumentSnapShot(doc));
  //         update();
  //       });
  //     });
  //     post.totalShares = totalShares;
  //     Get.snackbar('Shared', 'Post Shared',
  //         backgroundColor: Colors.greenAccent.withOpacity(0.4));
  //     actionBlocked = false;
  //     sharedPost.time = null;

  //     update();
  //   }
  // }

  getPosts() {
    // allPosts.clear();
    firebase
        .collection('Posts')
        .orderBy('time', descending: true)
        .get()
        .then((qSnap) {
      if (qSnap.size > 0) {
        qSnap.docs.forEach((docSnap) async {
          var post = PostModel.fromDocumentSnapShot(docSnap);
          allPosts.add(post);
          print (allPosts);
          //get likes
          // getLike(post);
          // getWow(post);
          // getHaha(post);
          // getSad(post);
          // getAngry(post);
          // getLove(post);
        });
        update();
      }
    });
  }

/* ------------------------- select Picture from camera ------------------------ */

  imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      postpic = File(pickedFile.path);
      update();
    }
  }

/* ------------------------ select picture from galer ----------------------- */

  imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      postpic = File(pickedFile.path);
      update();
    }
  }

/* ------------------- bottom sheet for picture selcetion ------------------- */

  void selectPhoto(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

/* ------------------------------ delete PHoto ------------------------------ */

  deletePhoto() {
    postpic = null;
    update();
  }

  uploadPost(link) async {
    // String link;
    // if (postpic != null) {
    //   link = await uploadFile();
    // }
    var user = userController.signup;
    postData.content = postTextController.text;
    postData.time = FieldValue.serverTimestamp();
    postData.userId = user.userId;
    // postData.userPic = user.profilePhoto;
    // postData.username = user.firstName + ' ' + user.lastName;
     postData.username = user.username;
    postData.postPhoto = link;
    firebase.collection('Posts').add(postData.toMap());
    loader.loadingDismiss();
    postTextController.text = '';
    postpic = null;
    Get.back();
    Get.snackbar('Published', 'Your post Publish SuccessFully',
        backgroundColor: Colors.greenAccent.withOpacity(0.4));
    actionBlocked = false;
    update();
  }
/* ------------------------------- upload file ------------------------------ */

  Future uploadFile() async {
    loader.loadingShow();
    if (postpic != null) {
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(
              "postsPics/${userController.signup.userId}/Posts${DateTime.now()}.jpg");
      final firebase_storage.UploadTask uploadTask =
          storageReference.putData(postpic.readAsBytesSync());
      await uploadTask.whenComplete(() {
        storageReference.getDownloadURL().then((link) {
          print(link);
          uploadPost(link);
        });
      });
    } else {
      uploadPost(null);
    }
  }

/* -------------------------------------------------------------------------- */
/*                              get all reaction                              */
/* -------------------------------------------------------------------------- */
  getLike(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Likes').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Likes').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.likeList = tempList;
      print(allPosts);
      update();
    }
  }

  getHaha(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Hahas').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Hahas').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.hahaList = tempList;
      print(allPosts);
      update();
    }
  }

  getAngry(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc =
        await post.ref.collection('Angrys').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref
            .collection('Angrys')
            .doc("$index")
            .get()
            .then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.angryList = tempList;
      print(allPosts);
      update();
    }
  }

  getSad(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Sads').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Sads').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.sadList = tempList;
      print(allPosts);
      update();
    }
  }

  getLove(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Loves').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Loves').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.loveList = tempList;
      print(allPosts);
      update();
    }
  }

  getWow(PostModel post) async {
    List tempList = [];
    DocumentSnapshot doc = await post.ref.collection('Wows').doc('info').get();
    if (doc.exists) {
      var len = doc.data()['TotalLists'];
      for (var i = 0; i < len; i++) {
        int index = i + 1;
        await post.ref.collection('Wows').doc("$index").get().then((likeList) {
          if (likeList.exists) {
            var listdata = likeList.data()['list'];
            tempList.addAll(listdata);
          }
        });
      }
      post.wowList = tempList;
      print(allPosts);
      update();
    }
  }
}
