import 'package:app/controller/Comment_controller.dart';
import 'package:app/controller/Function_controller.dart';
import 'package:app/controller/User_controller.dart';
import 'package:app/page/CircularProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class comment_page extends StatefulWidget {
  final int id;
  comment_page({super.key, required this.id});

  @override
  State<comment_page> createState() => _comment_pageState();
}

class _comment_pageState extends State<comment_page> {
  final Comment_controller comment = Get.put(Comment_controller());
  final User_controller userController = Get.put(User_controller());
  final function = Get.put(Function_controller());
  var auth = ['Delete', "Copy"];
  var users = ['Report', 'Copy'];
  @override
  void initState() {
    comment.fetchComment(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        final user = userController.user.value;
        if (comment.isLoading.value) {
          return const CircularProgressIndicator_page();
        } else {
          return Stack(
            children: [
              if (comment.comments.length == 0)
                const Center(
                  child: Text("No Comment...."),
                )
              else
                ListView.builder(
                  itemCount: comment.comments.length,
                  itemBuilder: (context, index) {
                    var comments = comment.comments[index];
                    return ListTile(
                      leading: comments.user.image!.isEmpty
                          ? const CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                comments.user.image.toString(),
                              ),
                            ),
                      title: Text(comments.user.name),
                      subtitle: Text(comments.comment),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) {
                          function.option(value, comment.comments[index].id,
                              comment.comments[index].post_id);
                        },
                        itemBuilder: (BuildContext context) {
                          if (comments.user_id == user?.id) {
                            return auth.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          } else {
                            return users.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          }
                        },
                      ),
                      onTap: () {},
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: TextField(
                              controller: comment.commentController,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            setState(() {
                              comment.store(widget.id);
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
        }
      }),
    );
  }
}
