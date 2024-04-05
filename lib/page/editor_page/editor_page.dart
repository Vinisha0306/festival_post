import 'dart:io';
import 'dart:ui';
import 'package:festival_post/header.dart';
import 'package:festival_post/utills/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  bool addText = false;
  bool element = false;
  bool image = false;
  String text = 'Text';
  Color textColour = Colors.black;
  double textSize = 14;
  File? phoneImage;
  TextStyle FontFamily = festivalFontFamily[0];
  TextEditingController mainText = TextEditingController();

  Future<void> getImage({required ImageSource source}) async {
    ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      phoneImage = File(file.path);
      setState(() {});
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
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
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SelectableText(
                      mainText.text,
                      style: TextStyle(
                        color: textColour,
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    phoneImage != null
                        ? Image(
                            image: FileImage(phoneImage!),
                          )
                        : Container(),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // add text
              Visibility(
                visible: addText == true,
                child: SingleChildScrollView(
                  child: Container(
                    height: 300,
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Edit Text',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        TextField(
                          controller: mainText,
                          decoration: const InputDecoration(
                            hintText: 'Text',
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                        const Text(
                          'Text Style',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              festivalFontFamily.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  FontFamily = festivalFontFamily[index];
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: FontFamily ==
                                              festivalFontFamily[index]
                                          ? Colors.greenAccent
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ABC',
                                    style: festivalFontFamily[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Text Colour',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Colors.primaries.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                textColour = Colors.primaries[index];
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: textColour == Colors.primaries[index]
                                        ? Colors.greenAccent
                                        : Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.primaries[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Text Size',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                textSize--;
                                setState(() {});
                              },
                              icon: const Icon(
                                CupertinoIcons.minus_circle_fill,
                              ),
                            ),
                            Text(
                              '${textSize.toInt()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                textSize++;
                                setState(() {});
                              },
                              icon: const Icon(
                                CupertinoIcons.plus_circle_fill,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // elements
              Visibility(
                visible: element == true,
                child: Container(
                  height: 230,
                  width: 500,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                    ],
                  ),
                ),
              ),
              //images
              Visibility(
                visible: image == true,
                child: Container(
                  height: 230,
                  width: 500,
                  child: Column(
                    children: [
                      const Text(
                        'Choose Source',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              getImage(source: ImageSource.camera);
                            },
                            child: const Text(
                              'Camera',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              getImage(source: ImageSource.gallery);
                            },
                            child: const Text(
                              'Gallery',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
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
                            color: image == true
                                ? Colors.greenAccent
                                : Colors.black,
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
      ),
    );
  }
}
