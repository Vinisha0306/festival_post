import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:festival_post/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

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
  BoxShape imageShape = BoxShape.rectangle;
  File? phoneImage;
  TextStyle FontFamily = festivalFontFamily[0];
  TextEditingController mainText = TextEditingController();
  Offset dxy = Offset(0, 0);
  Offset txy = Offset(0, 0);
  double IHeight = 300;
  double IWidth = 200;

  Future<void> getImage({required ImageSource source}) async {
    ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      phoneImage = File(file.path);
      setState(() {});
    }
  }

  GlobalKey widgetKey = GlobalKey();

  Future<File> getFileFromWidget() async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 2,
    );
    ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List list = data!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(list);

    return file;
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
        actions: [
          IconButton(
            onPressed: () async {
              ImageGallerySaver.saveFile((await getFileFromWidget()).path).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Save in Gallery'),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.save,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async {
              ShareExtend.share((await getFileFromWidget()).path, 'image').then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Save in Gallery'),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 44, 184, 153),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RepaintBoundary(
                key: widgetKey,
                child: Container(
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
                  child: Column(
                    children: [
                      GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(
                            () {
                              txy = txy + details.delta;
                            },
                          );
                        },
                        child: Transform.translate(
                          offset: txy,
                          child: Container(
                            child: SelectableText(
                              mainText.text,
                              style: FontFamily.copyWith(
                                color: textColour,
                                fontSize: textSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      phoneImage != null
                          ? GestureDetector(
                              onPanUpdate: (DragUpdateDetails details) {
                                setState(
                                  () {
                                    dxy = dxy + details.delta;
                                  },
                                );
                              },
                              child: Container(
                                child: Transform.translate(
                                  offset: dxy,
                                  child: Container(
                                    height: IHeight,
                                    width: IWidth,
                                    decoration: BoxDecoration(
                                      shape: imageShape,
                                      image: DecorationImage(
                                        image: FileImage(phoneImage!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
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

              //images
              Visibility(
                visible: image == true,
                child: Container(
                  height: 230,
                  width: 500,
                  child: SingleChildScrollView(
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
                            Visibility(
                              visible: phoneImage != null,
                              child: TextButton(
                                onPressed: () {
                                  phoneImage = null;
                                  setState(() {});
                                },
                                child: const Text(
                                  'Remove Image',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: phoneImage != null,
                          child: Column(
                            children: [
                              const Text(
                                'Image Shape',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      imageShape = BoxShape.rectangle;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color:
                                              imageShape == BoxShape.rectangle
                                                  ? Colors.greenAccent
                                                  : Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      imageShape = BoxShape.circle;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: imageShape == BoxShape.circle
                                              ? Colors.greenAccent
                                              : Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: phoneImage != null,
                          child: Column(
                            children: [
                              const Text(
                                'Change Image Size',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Height',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      IHeight -= 5;
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.minus_circle_fill,
                                    ),
                                  ),
                                  Text(
                                    '${IHeight.toInt()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      IHeight += 5;
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.plus_circle_fill,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Width',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      IWidth -= 5;
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.minus_circle_fill,
                                    ),
                                  ),
                                  Text(
                                    '${IWidth.toInt()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      IWidth += 5;
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
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      addText = !addText;
                      element = false;
                      image = false;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
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
                  GestureDetector(
                    onTap: () {
                      addText = false;
                      element = false;
                      image = !image;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(5),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
