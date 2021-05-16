import 'package:socialtinder/controller/post_controller.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialtinder/screens/social_tab_pages.dart/create_post_page.dart';
import 'package:socialtinder/widgets/post_button.dart';
import 'package:socialtinder/widgets/post_widget.dart';
import 'package:socialtinder/widgets/separator_widget.dart';


class SocialTab extends StatefulWidget {
  @override
  _SocialTabState createState() => _SocialTabState();
}

class _SocialTabState extends State<SocialTab> {


  @override
  void initState() { 
    super.initState();
    controller. getPosts();
  }
  //  UserController userController = Get.put(UserController());
   PostController controller = Get.put(PostController());

  //  @override
  //  void initState() { 
  //    super.initState();
  //    controller.getPosts();
  //  }
  @override
  Widget build(BuildContext context) {
      controller.getPosts().then((value) {
        print("Successfully Called");
      });
      return GetBuilder<PostController>(builder: (_){
           return 
         SingleChildScrollView(
          child: Column(
            children: <Widget>[
              writepostBtn(onTapfunction: () {
                return Get.to(CreatePostPage());
              }),
              SeparatorWidget(),
            IconButton(icon: Icon(Icons.share,),onPressed: (){
              controller.getPosts();
            },),
              // // OnlineWidget(),
              // SeparatorWidget(),

              //  StoriesWidget(),
//          for(Post post in posts) Column(
//            children: <Widget>[
//              SeparatorWidget(),
//              PostWidget(post: post),
//            ],
//          ),
              // SeparatorWidget(),
              
              for (var posts in controller.allPosts)
                PostCard(
                  post:posts ,
                ),

                // Text(controller.allPosts[i].content)
            ],
          ),
        );
      });
 
  }
}