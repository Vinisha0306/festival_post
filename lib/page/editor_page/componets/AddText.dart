import 'package:festival_post/header.dart';
import 'package:flutter/cupertino.dart';

Widget AddText({
  required getState,
}) {
  return StatefulBuilder(
    builder: (context, setState) => Visibility(
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
                    getState();
                  }),
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
                        getState();
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: FontFamily == festivalFontFamily[index]
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
                      getState();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: textColour == Colors.primaries[index]
                            ? Border.all(
                                color: Colors.black,
                                width: 2,
                              )
                            : null,
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
  );
}
