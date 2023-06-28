import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Color backgroundColor = const Color(0xfff1f1f1);

  bool scanning = false;

  XFile? imageFile;

  String? scannedText = '';

  // 0xff

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white70,
      body: SizedBox(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Container(
                //     margin: const EdgeInsets.symmetric(
                //       horizontal: 20,
                //     ),
                //     padding: const EdgeInsets.only(
                //       left: 20,
                //       right: 20,
                //       top: 5,
                //       bottom: 5,
                //     ),
                //     decoration: const BoxDecoration(
                //       color: Colors.black87,
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(20),
                //       ),
                //     ),
                //     child: Text(
                //       "Text Recognition App",
                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.tajawal().copyWith(
                //         fontSize: 20,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                imageFile != null
                    ? Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: mediaQuery.height / 4,
                            width: mediaQuery.width,
                            margin: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                              ),
                              child: Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 24),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  imageFile = null;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_rounded,
                                size: 40,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: mediaQuery.height / 4,
                        width: mediaQuery.width,
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!
                                .showBottomSheet<void>((context) {
                              return Container(
                                height: mediaQuery.height / 4,
                                decoration: const BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 50,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: _buttomSheetContainers(
                                                icon: Icons.photo_camera,
                                                text: 'Take Photo',
                                                onPressed: () {
                                                  getImage(ImageSource.camera);
                                                }),
                                          ),
                                          Expanded(
                                            child: _buttomSheetContainers(
                                                text: 'Gallery',
                                                icon: Icons.photo,
                                                onPressed: () {
                                                  getImage(ImageSource.gallery);
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                        ),
                      ),
                scanning
                    ? Transform.translate(
                        offset: const Offset(0, 50),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : scannedText!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: SelectableText(
                              "NO TEXT FOUND ",
                              style: GoogleFonts.tajawal().copyWith(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 20, right: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  scannedText!,
                                  textStyle: GoogleFonts.tajawal().copyWith(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttomSheetContainers({
    required IconData icon,
    required String text,
    required void Function() onPressed,
  }) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black45,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: 40,
              color: Colors.black54,
            ),
            onPressed: onPressed,
          ),
          Text(
            text,
            style: GoogleFonts.tajawal().copyWith(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        scanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      scanning = false;
      imageFile = null;
      scannedText = "Error Occured While Scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    RecognizedText? recognisedText =
        await textRecognizer.processImage(inputImage);

    textRecognizer.close();
    scannedText = "";

    await Future.delayed(const Duration(milliseconds: 400));

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    scanning = false;
    setState(() {});
  }
}
