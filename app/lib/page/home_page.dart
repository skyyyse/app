import 'package:app/controller/Comment_controller.dart';
import 'package:app/controller/Favorite_controller.dart';
import 'package:app/controller/Like_controller.dart';
import 'package:app/controller/Post_controller.dart';
import 'package:app/page/comment_page.dart';
import 'package:app/page/review_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class home_page extends StatefulWidget {
  home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  final post=Get.put(Post_controller());
  final Like=Get.put(Like_controller());
  @override
  void initState() {
    post.fetchPosts();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "New app",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          )
        ],
      ),
      body: Obx((){
        return post.loading.value?Center(
          child: Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ):ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: post.posts.length,
          itemBuilder: (context, index) {
            var posts=post.posts[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 8),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        child: ListTile(
                          leading: post.posts[index].user.image!.isEmpty?CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person,size: 30,),
                          ):CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("http://10.0.2.2:8000/file/post/image/${posts.user.image.toString()}"),
                          ),
                          title: Text(post.posts[index].user.name),
                          trailing:IconButton(onPressed: (){
                            setState(() {
                              final id=posts.id;
                              final favorite=Get.put(Favorite_controller());
                              favorite.fovorite(id);
                            });
                          }, icon: posts.favorite.length==0?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8,bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              post.posts[index].title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              maxLines: 5, // Maximum number of lines
                              overflow: TextOverflow.ellipsis, // Overflow behavior
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 8, right: 8, bottom: 0),
                      child: InkWell(
                        onTap: () {
                          Get.to(review_page(user_image:posts.user.image,name:posts.user.name,title:posts.title,image: posts.image,description:posts.description,id:posts.id));
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:  Image(
                              image: NetworkImage(
                                  "http://10.0.2.2:8000/file/post/image/${posts.image}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  int id =post.posts[index].id;
                                  Get.to(comment_page(id: id));
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 125,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.chat),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text('Comment'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  int id=post.posts[index].id;
                                  Like.like(id);
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 125,
                                child:  Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      post.posts[index].like.length==0?Icon(Icons.thumb_up):Icon(Icons.thumb_up,color: Colors.red,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(post.posts[index].likeCount.toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 125,
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.share),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text('Share'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
