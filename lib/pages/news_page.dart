import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/pages/add_new_news.dart';
import 'package:readmore/readmore.dart';

import '../controllers/news_controller.dart';
import '../controllers/signup_login_controller.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _signupLoginController = Get.put(SignupLoginController());
  final _newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 255, 250, 234),
          width: 400,
          height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('news')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No messages yet."));
              }

              var messages = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = messages[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(
                      message['title'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: ReadMoreText(
                      message['body'] ?? '',
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.blue,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                    ),

                    // there will be update and delete button in trailing area
                    trailing: _signupLoginController.id != message['userid']
                        ? null
                        : Wrap(
                            direction: Axis.horizontal,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _newsController
                                      .deleteNews(messages[index].id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                                onPressed: () {
                                  // Get.to(const AddnewNewsPage(),
                                  //     arguments: messages[index].id);
                                  // _newsController.updateNews(messages[index].id, message['title'], message['body']);
                                  Get.to(AddnewNewsPage(
                                    msgid: messages[index].id,
                                    title: message['title'],
                                    body: message['body'],
                                  ));
                                },
                              ),
                            ],
                          ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const AddnewNewsPage());
          },
          icon: const Icon(Icons.add),
          label: const Text('Add News')),
    );
  }
}
