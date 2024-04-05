import 'package:festival_post/header.dart';
import 'package:festival_post/modal/app_modal.dart';

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
                Navigator.pushNamed(context, AppRoutes.editor_page,
                    arguments: post.images[index]);
              },
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      post.images[index],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
