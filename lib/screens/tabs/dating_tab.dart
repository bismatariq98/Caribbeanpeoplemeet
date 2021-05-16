import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialtinder/controller/dislike_controller.dart';
import 'package:socialtinder/controller/like_controller.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:socialtinder/screens/profile_card.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart';
import 'package:socialtinder/widgets/dating_button.dart';
import 'package:socialtinder/widgets/no_data.dart';

import 'package:swipe_stack/swipe_stack.dart';
import 'package:get/get.dart';
class DatingTab extends StatefulWidget {
  @override
  _DatingTabState createState() => _DatingTabState();
}

class _DatingTabState extends State<DatingTab> {

  @override
  void initState() { 
    super.initState();
   userController.getDataDating();
  }
   DislikeController dislikeController = Get.put(DislikeController());
   UserController userController = Get.put(UserController());
   LikeController likeController = Get.put(LikeController());


  final GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();
  SignUp signUp = SignUp();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<UserController>(builder: (_){
        return 
      // Text("asd");
     _showUsers();
 
    });
 
      
  
  }


  
  Widget _showUsers() {
    /// Check result
  if (userController.signupList.isEmpty) {
      /// No user found
      return NoData(
        svgName: 'search_icon', 
        text: "no_user_found_around_you_please_try_again_later");
    } else {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// User card list
      
        SwipeStack(
            key: _swipeKey,
            children: [
   for(var i = 0;i < userController.signupList.length; i++) 
              // Get User object
              // final SignUp signup = SignUp.fromDocumentSnapshot(userDoc);
              // Return user profile
            SwiperItem(
                  builder: (SwiperPosition position, double progress) {
                /// Return User Card
                return ProfileCard(
                    page: 'discover', position: position, user: userController.signupList[i] );
              }),
            ],
          
         
            
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            translationInterval: 6,
            scaleInterval: 0.03,
            stackFrom: StackFrom.None,
            onEnd: () => debugPrint("onEnd"),
            onSwipe: (int index, SwiperPosition position) {
              /// Control swipe position
              switch (position) {
                case SwiperPosition.None:
                  break;
                case SwiperPosition.Left:

                  /// Swipe Left Dislike profile
                  dislikeController.checkIfDisliked(
                    dislikedUserId: userController.signupList[index].userId,
                   
                  );

                  break;

                case SwiperPosition.Right:
                    return null;
                //   /// Swipe right and Like profile
                //   _likeUser(context,
                //       clickedUserDoc: userController.signupList[i]);

                //   break;
              }
            }),

        /// Swipe buttons
        // Container(
        //   margin: const EdgeInsets.only(bottom: 20),
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: swipeButtons(context),
        // )),
      ],
     );
    }  
  }

  /// Build swipe buttons
  // Widget swipeButtons(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       /// Rewind profiles
  //       ///
  //       /// Go to Disliked Profiles
  //       cicleButton(
  //           bgColor: Colors.white,
  //           padding: 8,
  //           icon: Icon(Icons.restore, size: 22, color: Colors.grey),
  //           onTap: () {
  //             // Go to Disliked Profiles Screen
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => DislikedProfilesScreen()));
  //           }),

  //       SizedBox(width: 20),

  //       /// Swipe left and reject user
  //       cicleButton(
  //           bgColor: Colors.white,
  //           padding: 8,
  //           icon: Icon(Icons.close, size: 35, color: Colors.grey),
  //           onTap: () {
  //             /// Get card current index
  //             final cardIndex = _swipeKey.currentState.currentIndex;

  //             /// Check card valid index
  //             if (cardIndex != -1) {
  //               /// Swipe left
  //               _swipeKey.currentState.swipeLeft();

  //               /// Dislike profile
  //               _dislikesApi.dislikeUser(
  //                   dislikedUserId:  _users[cardIndex][USER_ID],
  //                   onDislikeResult: (r) => debugPrint('onDislikeResult: $r')
  //                );
  //             }
  //           }),

  //       SizedBox(width: 20),

  //       /// Swipe right and like user
  //       cicleButton(
  //           bgColor: Colors.white,
  //           padding: 8,
  //           icon: Icon(Icons.favorite_border,
  //               size: 35, color: Theme.of(context).primaryColor),
  //           onTap: () async {
  //             /// Get card current index
  //             final cardIndex = _swipeKey.currentState.currentIndex;

  //             /// Check card valid index
  //             if (cardIndex != -1) {
  //               /// Like profile
  //               await _likeUser(context,
  //                   clickedUserDoc: _users[cardIndex]);
  //             }
  //           }),

  //       SizedBox(width: 20),

  //       /// Go to user profile
  //       cicleButton(
  //         bgColor: Colors.white,
  //         padding: 8,
  //         icon: Icon(Icons.remove_red_eye, size: 22, color: Colors.grey),
  //         onTap: () {
  //           /// Get card current index
  //           final cardIndex = _swipeKey.currentState.currentIndex;

  //           /// Check card valid index
  //           if (cardIndex != -1) {

  //             /// Get User object
  //             final User user =
  //                 User.fromDocument(_users[cardIndex].data());

  //             /// Go to profile screen
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => 
  //                    ProfileScreen(user: user, showButtons: false)));

  //             /// Increment user visits an push notification
  //             _visitsApi.visitUserProfile(
  //               visitedUserId: user.userId,
  //               userDeviceToken: user.userDeviceToken,
  //               nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
  //                   "${_i18n.translate("visited_your_profile_click_and_see")}",
  //             );
  //           }
  //         }),
  //     ],
  //   );
  // }

  /// Like user function
  Future<void> _likeUser(
    BuildContext context, {@required DocumentSnapshot clickedUserDoc}) async {
      /// Check match first
      // await _matchesApi.checkMatch(
      //   userId: clickedUserDoc[USER_ID],
      //   onMatchResult: (result) {
      //     if (result) {
      //       /// It`s match - show dialog to ask user to chat or continue playing
      //       showDialog(
      //         context: context,
      //         barrierDismissible: false,
      //         builder: (context) {
      //           return ItsMatchDialog(
      //             swipeKey: _swipeKey,
      //             matchedUser: User.fromDocument(clickedUserDoc.data()),
      //           );
      //       });
      //     } else {
      //       /// Swipe right
      //       _swipeKey.currentState.swipeRight();
      //     }
      //   });

        /// like profile
        // await likeController.likeUser(
        //       likedUserId: clickedUserDoc[USER_ID],
        //       userDeviceToken: clickedUserDoc[USER_DEVICE_TOKEN],
        //       nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
        //           "${_i18n.translate("liked_your_profile_click_and_see")}",
        //       onLikeResult: (result) {
        //         print('likeResult: $result');
        // });
  }
}