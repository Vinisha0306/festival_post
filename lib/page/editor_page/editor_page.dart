import 'package:festival_post/header.dart';
import 'package:festival_post/utills/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

bool addText = false;
bool element = false;
bool image = false;

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    String Edit = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 184, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    Edit,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // add text
            Visibility(
              visible: addText == true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Text Style',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('ABC'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // elements
            Visibility(
              visible: element == true,
              child: Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: allPost.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Text('1'),
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      addText = !addText;
                      element = false;
                      image = false;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: addText == true
                              ? Colors.greenAccent
                              : Colors.black,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Add Text'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      addText = false;
                      element = !element;
                      image = false;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: element == true
                              ? Colors.greenAccent
                              : Colors.black,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Elements'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      addText = false;
                      element = false;
                      image = !image;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              image == true ? Colors.greenAccent : Colors.black,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Image'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
