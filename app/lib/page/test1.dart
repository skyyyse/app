import 'dart:convert';

import 'package:app/model/Comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen({required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CommentController controller = Get.put(CommentController());
  @override
  void initState() {
    // TODO: implement initState
    controller.fetchComment(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Details'),
      ),
      body: Obx(() {
        return controller.isLoading.value?Center(
          child: Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ): Stack(
          children: [
            ListView.builder(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(controller.comments[index].user.name), // Replace with actual user name
                                      InkWell(
                                        onTap: () {
                                          // Handle more options
                                        },
                                        child: Icon(Icons.more_horiz),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Text(
                                    controller.comments[index].comment,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white, // Background color to cover the background content
                          child: TextField(
                            // controller: comment.commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            // controller.store(widget.id);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  Future<void> fetchComment(int id) async {
    final url = 'http://10.0.2.2:8000/api/comment/get?id=$id';
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization":
          "Bearer 49|KsEM7Hu7Sav0HX7lfYlxRwJzsGdKYcQ9lOSnNWPK6eb46382",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['comment'];
        comments.assignAll(jsonList.map((json) => Comment.fromjson(json)).toList());
      } else {
        errorMessage.value = 'Failed to load comment';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}