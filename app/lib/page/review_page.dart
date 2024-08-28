import 'package:app/controller/Favorite_controller.dart';
import 'package:app/page/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
class review_page extends StatefulWidget {
  var user_image,name,title,image,description,id;
  review_page({super.key,required this.user_image,required this.name,required this.title,required this.image,required this.description,required this.id});

  @override
  State<review_page> createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  final Favorite_controller favorite = Get.put(Favorite_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("http://10.0.2.2:8000/file/user/image/${widget.user_image}"),
                  ) ,
                  title: Text(widget.name),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8,right: 8),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Get.to(review_page(posts: posts,));
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: NetworkImage(
                          "http://10.0.2.2:8000/file/post/image/${widget.image}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
               widget.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ), // Overflow behavior
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
                            Get.to(comment_page(id:widget.id));
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
                          // setState(() {
                          //   int id=post.posts[index].id;
                          //   Like.like(id);
                          // });
                        },
                        child: Container(
                          height: 60,
                          width: 125,
                          child:  Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // post.posts[index].like.length==0?Icon(Icons.thumb_up):Icon(Icons.thumb_up,color: Colors.red,),
                                // Padding(
                                //   padding: EdgeInsets.only(left: 5),
                                //   child: Text(post.posts[index].likeCount.toString()),
                                // ),
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
      ),
    );
  }
}
