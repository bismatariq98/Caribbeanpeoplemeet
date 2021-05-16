import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:socialtinder/controller/post_controller.dart';
import 'package:socialtinder/models/post_model.dart';
import 'package:socialtinder/widgets/post_image.dart';
import 'package:socialtinder/widgets/separator_widget.dart';
import 'package:socialtinder/widgets/time_to_stamp.dart';




// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  TextEditingController commentTextController = TextEditingController();

  final PostModel post;

  PostCard({this.post});
  PostController postController = Get.put(PostController());
  // CommentController commentController = Get.put(CommentController());
  // LikeController likeController = Get.put(LikeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (_) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // if (post.isPostShared)
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          // backgroundImage: NetworkImage(post.userPic),
                          backgroundImage: AssetImage("assets/palm.jpg"),
                          radius: 20.0,
                        ),
                        SizedBox(width: 7.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(post.content,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),
                            SizedBox(height: 5.0),
                            Text(post.time == null
                                ? 'Now'
                                : timestampToString(post.time)),
                                
                          ],
                        ),
                      ],
                    ),
                  // if (post.isPostShared)
                    SizedBox(
                      height: 10,
                    ),
                  // Padding(
                  //   // padding: post.isPostShared
                  //   //     ? const EdgeInsets.all(8.0)
                  //   //     : EdgeInsets.zero,
                  //   padding:const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Row(
                  //         children: <Widget>[
                  //           CircleAvatar(
                  //             // backgroundImage: NetworkImage(
                  //             //   post.isPostShared
                  //             //     ? post.originalUserPic
                  //             //     : post.userPic
                  //             //     ),
                  //             backgroundImage: AssetImage("assets/palm.jpg"),
                  //             radius: 20.0,
                  //           ),
                  //           SizedBox(width: 7.0),
                  //           Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: <Widget>[
                  //               // Text(
                  //               //     post.isPostShared
                  //               //         ? post.originalUserName
                  //               //         : post.username,
                  //               //     style: TextStyle(
                  //               //         fontWeight: FontWeight.bold,
                  //               //         fontSize: 17.0)),
                  //               // SizedBox(height: 5.0),
                  //               // Text(post.isPostShared
                  //               //     ? post.originalTime == null
                  //               //         ? '...'
                  //               //         : timestampToString(post.originalTime)
                  //               //     : post.time == null
                  //               //         ? 'Now'
                  //               //         : timestampToString(post.time))
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 20.0),
                  //       if (post.content != '')
                  //         Row(
                  //           mainAxisAlignment: post.content.length < 20 &&
                  //                   post.postPhoto == null
                  //               ? MainAxisAlignment.center
                  //               : MainAxisAlignment.start,
                  //           children: [
                  //             post.content.length < 20 && post.postPhoto == null
                  //                 ? Container(
                  //                     width: Get.width - 50,
                  //                     // height: Get.width / 2,
                  //                     decoration: BoxDecoration(
                  //                         gradient: LinearGradient(colors: [
                  //                       Colors.lightBlue,
                  //                       Colors.greenAccent
                  //                     ])),
                  //                     child: AspectRatio(
                  //                       aspectRatio: 16 / 9,
                  //                       child: Center(
                  //                           child: Padding(
                  //                         padding: const EdgeInsets.all(4.0),
                  //                         child: Text(
                  //                           post.content,
                  //                           style: TextStyle(
                  //                               fontSize: 25,
                  //                               fontWeight: FontWeight.bold),
                  //                         ),
                  //                       )),
                  //                     ),
                  //                   )
                  //                 : Text(post.content,
                  //                     style: TextStyle(
                  //                         fontSize: post.postPhoto == null
                  //                             ? post.content.length > 200
                  //                                 ? 16.0
                  //                                 : post.content.length > 40
                  //                                     ? 20
                  //                                     : 25
                  //                             : 16)),
                  //           ],
                  //         ),
                  //       SizedBox(height: 10.0),
                  //       if (post.postPhoto != null)
                          postImage(
                            context,
                            post.postPhoto,
                          ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: <Widget>[
                  //           Row(
                  //             children: <Widget>[
                  //               // Icon(FontAwesomeIcons.thumbsUp,
                  //               //     size: 15.0, color: Colors.blue),
                  //               // Text(likeController.countLikes(post).toString()
                  //                   //' ${post.likes}'
                  //                   // ),
                  //             ],
                  //           ),
                  //           // Row(
                  //           //   children: <Widget>[
                  //           //     Text(post.totalComments == 0
                  //           //             ? "No Comment"
                  //           //             : '${post.totalComments.toString()} Comments'
                  //           //         //'${post.comments} comments  •  '
                  //           //         ),
                  //           //   ],
                  //           // ),
                  //           // Row(
                  //           //   children: <Widget>[
                  //           //     Text(post.totalShares == 0
                  //           //             ? "No Share"
                  //           //             : '${post.totalShares.toString()} Shares'
                  //           //         //' ${post.likes}'
                  //           //         ),
                  //           //   ],
                  //           // ),
                  //         ],
                  //       ),
                  //       Divider(height: 30.0),
                  //       // Row(
                  //       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       //   crossAxisAlignment: CrossAxisAlignment.center,
                  //       //   children: <Widget>[
                  //       //     Row(
                  //       //       children: <Widget>[
                  //       //         FlutterReactionButtonCheck(
                  //       //           onReactionChanged:
                  //       //               (reaction, index, isChecked) {
                  //       //             likeController.liked(
                  //       //                 post.ref, post, index, isChecked);
                  //       //             print(
                  //       //                 'reaction selected index: $index --$isChecked');
                  //       //             // likeController.liked(post.ref);
                  //       //           },
                  //       //           isChecked:
                  //       //               likeController.checkIsLiked(post) != -1
                  //       //                   ? true
                  //       //                   : false,
                  //       //           boxPadding: EdgeInsets.all(5),
                  //       //           boxItemsSpacing: 3,
                  //       //           boxAlignment: Alignment.centerLeft,
                  //       //           boxDuration: Duration(milliseconds: 100),
                  //       //           selectedReaction:
                  //       //               likeController.checkLikedReaction(post),
                  //       //           reactions: [
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/like.gif',
                  //       //                 'assets/reactions/like_fill.png',
                  //       //                 'Like',
                  //       //                 Colors.blue),
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/love.gif',
                  //       //                 'assets/reactions/love.png',
                  //       //                 'Love',
                  //       //                 Colors.red[900]),
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/haha.gif',
                  //       //                 'assets/reactions/haha.png',
                  //       //                 'Haha',
                  //       //                 Colors.yellow[900]),
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/wow.gif',
                  //       //                 'assets/reactions/wow.png',
                  //       //                 'Wow',
                  //       //                 Colors.yellow[900]),
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/sad.gif',
                  //       //                 'assets/reactions/sad.png',
                  //       //                 'Sad',
                  //       //                 Colors.yellow[900]),
                  //       //             reactionIcon(
                  //       //                 'assets/reactions/angry.gif',
                  //       //                 'assets/reactions/angry.png',
                  //       //                 'Angry',
                  //       //                 Colors.deepOrange),
                  //       //           ],
                  //       //           // initialReaction:
                  //       //           //     ,
                  //       //           initialReaction: reactionIcon(
                  //       //               'assets/reactions/like.gif',
                  //       //               'assets/reactions/like.png',
                  //       //               'Like',
                  //       //               Colors.grey[800]),
                  //       //         ),
                  //       //         // SizedBox(width: 5.0),
                  //       //         // Text('Like', style: TextStyle(fontSize: 14.0)),
                  //       //       ],
                  //       //     ),
                  //       //     Row(
                  //       //       children: <Widget>[
                  //       //         // Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                  //       //         // SizedBox(width: 5.0),
                  //       //         TextButton(
                  //       //           onPressed: () {
                  //       //             commentController.currentPost = post;
                  //       //             commentController.getAllComments();
                  //       //             Get.to(AllCommentPage());
                  //       //           },
                  //       //           child: Text('See All Comment',
                  //       //               style: TextStyle(fontSize: 14.0)),
                  //       //         )
                  //       //       ],
                  //       //     ),
                  //       //     InkWell(
                  //       //       onTap: () {
                  //       //         postController.sharePost(post);
                  //       //       },
                  //       //       child: Row(
                  //       //         children: <Widget>[
                  //       //           Icon(FontAwesomeIcons.share, size: 20.0),
                  //       //           SizedBox(width: 5.0),
                  //       //           Text('Share',
                  //       //               style: TextStyle(fontSize: 14.0)),
                  //       //         ],
                  //       //       ),
                  //       //     ),
                  //       //   ],
                  //       // ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       // if (post.lastComment != null)
                  //       //   Row(
                  //       //     children: <Widget>[
                  //       //       CircleAvatar(
                  //       //         backgroundImage:
                  //       //             NetworkImage(post.lcUserphoto ?? ''),
                  //       //         radius: 15.0,
                  //       //       ),
                  //       //       SizedBox(width: 7.0),
                  //       //       Expanded(
                  //       //         child: Card(
                  //       //           child: Padding(
                  //       //             padding: const EdgeInsets.all(5.0),
                  //       //             child: Column(
                  //       //               mainAxisAlignment:
                  //       //                   MainAxisAlignment.center,
                  //       //               crossAxisAlignment:
                  //       //                   CrossAxisAlignment.start,
                  //       //               children: <Widget>[
                  //       //                 Row(
                  //       //                   mainAxisAlignment:
                  //       //                       MainAxisAlignment.spaceBetween,
                  //       //                   children: [
                  //       //                     Text(post.lcUserName,
                  //       //                         style: TextStyle(
                  //       //                             fontWeight: FontWeight.bold,
                  //       //                             fontSize: 12.0)),
                  //       //                     Text(
                  //       //                         post.lastCommentTime == null
                  //       //                             ? 'now'
                  //       //                             : timestampToString(
                  //       //                                 post.lastCommentTime),
                  //       //                         style:
                  //       //                             TextStyle(fontSize: 12.0))
                  //       //                   ],
                  //       //                 ),
                  //       //                 SizedBox(height: 5.0),
                  //       //                 Text(post.lastComment,
                  //       //                     maxLines: 4,
                  //       //                     style: TextStyle(fontSize: 12.0))
                  //       //               ],
                  //       //             ),
                  //       //           ),
                  //       //         ),
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       TextField(
                  //         maxLines: null,
                  //         controller: commentTextController,
                  //         decoration: InputDecoration(
                  //           hintText: "Write Comment...",
                  //           suffix: IconButton(
                  //               icon: Icon(Icons.send_rounded),
                  //               onPressed: () {
                  //                 //post Comment
                  //                 // if (commentTextController.text != null) {
                  //                 //   commentController.currentPost = post;
                  //                 //   commentController.postComment(
                  //                 //     commentTextController.text,
                  //                 //   );
                  //                 //   commentTextController.text = '';
                  //                 // }
                  //                 return null;
                  //               }),
                  //           hintStyle: TextStyle(color: Colors.black54),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SeparatorWidget(),
          ],
        );
      },
    );
  }
}
