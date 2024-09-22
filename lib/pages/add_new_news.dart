import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/shared/my_toast.dart';

class AddnewNewsPage extends StatefulWidget {
  final String? msgid;
  final String? title;
  final String? body;
  const AddnewNewsPage({
    super.key,
    this.msgid,
    this.title,
    this.body,
  });

  @override
  State<AddnewNewsPage> createState() => _AddnewNewsPageState();
}

class _AddnewNewsPageState extends State<AddnewNewsPage> {
  final titleTextController = TextEditingController();
  final bodyTextController = TextEditingController();

  final _newsController = Get.put(NewsController());

  @override
  void initState() {
    super.initState();

    if (widget.msgid != null) {
      titleTextController.text = widget.title!;
      bodyTextController.text = widget.body!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.msgid == null ? 'Upload News' : 'Update News'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // color: const Color.fromARGB(255, 251, 255, 237),
          width: 300,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TextField(
                        controller: titleTextController,
                        decoration: const InputDecoration(labelText: 'Title')),
                    TextField(
                        controller: bodyTextController,
                        decoration: const InputDecoration(
                            labelText: 'News Description')),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              fieldValidation();
                            },
                            child: Text(widget.msgid == null
                                ? 'Upload News'
                                : 'Update News'))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fieldValidation() {
    if (titleTextController.text == '') {
      showErrorToast('Plese enter title');
    } else if (bodyTextController.text == '') {
      showErrorToast('Please enter description');
    } else {
      if (widget.msgid == null) {
        _newsController.saveNewsToCloudStorage(
            titleTextController.text, bodyTextController.text);
      } else {
        _newsController.updateNews(
            widget.msgid!, titleTextController.text, bodyTextController.text);
      }
    }
  }
}
