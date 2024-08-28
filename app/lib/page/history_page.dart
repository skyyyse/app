import 'package:app/controller/Favorite_controller.dart';
import 'package:app/controller/History_controller.dart';
import 'package:app/page/CircularProgressIndicator.dart';
import 'package:app/page/review_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class history_page extends StatefulWidget {
  history_page({super.key});

  @override
  State<history_page> createState() => _history_pageState();
}

class _history_pageState extends State<history_page> {
  final history = Get.put(History_controller());
  @override
  void initState() {
    history.fetchPosts();
    // TODO: implement initState
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text("History"),
      ),
      body: Obx(() {
        if (history.loading.value) {
          return CircularProgressIndicator_page();
        } else {
          if (history.posts.length == 0)
            return const Center(
              child: Text("No History...."),
            );
          else
            return ListView.builder(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: history.posts.length,
              itemBuilder: (context, index) {
                var historys = history.posts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(review_page(
                          user_image: historys.user.image,
                          name: historys.user.name,
                          title: historys.title,
                          image: historys.image,
                          description: historys.description,
                        id:historys.id,
                      ),);
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 37, 30, 30),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "http://10.0.2.2:8000/file/post/image/${historys.image}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, right: 8, bottom: 8),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          historys.title,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                          maxLines:
                                              3, // Maximum number of lines
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            int id = historys.id;
                                            history.delete(id);
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
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
              },
            );
        }
      }),
    );
  }
}
