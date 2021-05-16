

import 'package:flutter/material.dart';
import 'package:socialtinder/screens/cicle_button.dart';
import 'package:socialtinder/screens/default_card_bottom.dart';
import 'package:socialtinder/screens/showLikeDislike.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart';
import 'package:swipe_stack/swipe_stack.dart';


class ProfileCard extends StatelessWidget {
  /// User object
  final SignUp user;

  /// Screen to be checked
  final String page;

  /// Swiper position
  final SwiperPosition position;

  ProfileCard({this.page, this.position, @required this.user});

  // Local variables
  // final AppHelper _appHelper = AppHelper();

  @override
  Widget build(BuildContext context) {
    // Variables
    // final bool requireVip =
    //     this.page == 'require_vip' && !UserModel().userIsVip;

    // Build profile card
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: [
          /// User Card
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            margin: EdgeInsets.all(0),
            shape: defaultCardBorder(),
            child: Container(
              decoration: BoxDecoration(
                /// User profile image
                image: DecorationImage(

                    /// Show VIP icon if user is not vip member
                    image: 
                        NetworkImage(user.profilePhoto),
                    fit: BoxFit.cover),
              ),
              child: Container(
                /// BoxDecoration to make user info visible
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.transparent
                      ]),
                ),

                /// User info container
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User fullname
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${user.firstName}, '
                              '${user.age}',
                              style: TextStyle(
                                  fontSize: this.page == 'discover' ? 20 : 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      /// User education
                      Row(
                        children: [
                          Image.asset("assets/search.png",color: Colors.white, width: 20, height: 20)
                         ,
                          SizedBox(width: 5),
                          // Expanded(
                          //   child: Text(
                          //     user.userSchool,
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 16,
                          //     ),
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 3),

                      /// User job title
                      Row(
                        children: [
                         Image.asset("assets/search.png",
                              color: Colors.white, width: 17, height: 17),
                          // SizedBox(width: 5),
                          // Expanded(
                          //   child: Text(
                          //     user.userJobTitle,
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 16,
                          //     ),
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                        ],
                      ),

                      // this.page == 'discover'
                      //     ? SizedBox(height: 70)
                      //     : Container(width: 0, height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Show location distance
          // Positioned(
          //   top: 10,
          //   left: this.page == 'discover' ? 8 : 5,
          //   child: Badge(
          //       icon: this.page == 'discover'
          //           ? SvgIcon("assets/icons/location_point_icon.svg",
          //               color: Colors.white, width: 15, height: 15)
          //           : null,
          //       text:
          //           '${_appHelper.getDistanceBetweenUsers(userLat: user.userGeoPoint.latitude, userLong: user.userGeoPoint.longitude)}km'),
          // ),

          /// Show Like or Dislike
          this.page == 'discover'
              ? ShowLikeOrDislike(position: position)
              : Container(width: 0, height: 0),

          /// Show message icon
          this.page == 'matches'
              ? Positioned(
                  bottom: 5,
                  right: 5,
                  child: cicleButton(
                    padding: 7,
                    bgColor: Theme.of(context).primaryColor,
                    icon: 
                    Image.asset("assets/search.png",
                        color: Colors.white, width: 30, height: 30),
                    onTap: () {},
                  ),
                )
              : Container(width: 0, height: 0),

          /// Show flag profile icon
          // this.page == 'discover'
          //     ? Positioned(
          //         right: 0,
          //         child: IconButton(
          //             icon: Icon(Icons.flag_outlined,
          //                 color: Theme.of(context).primaryColor),
          //             onPressed: () {
          //               /// Flag user profile
          //               showDialog(
          //                   context: context,
          //                   barrierDismissible: false,
          //                   builder: (context) {
          //                     return FlagUserDialog(flaggedUserId: user.userId);
          //                   });
          //             }))
          //     : Container(width: 0, height: 0),
        ],
      ),
    );
  }
}
