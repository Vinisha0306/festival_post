import 'package:festival_post/header.dart';
import 'package:festival_post/modal/app_modal.dart';
import 'package:flutter/cupertino.dart';

class All_Post_Page extends StatefulWidget {
  const All_Post_Page({super.key});

  @override
  State<All_Post_Page> createState() => _All_Post_PageState();
}

class _All_Post_PageState extends State<All_Post_Page> {
  @override
  Widget build(BuildContext context) {
    Festival post = ModalRoute.of(context)!.settings.arguments as Festival;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 184, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: post.images.length,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.editor_page,
                  arguments: post.images[index],
                );
              },
              child: Container(
                height: 200,
                width: 200,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5, 5),
                            blurRadius: 3,
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            post.images[index] ?? allPost[0].thamb,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
