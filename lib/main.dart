import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // 0xff

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      body: SizedBox(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Text Recognition App",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal().copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: mediaQuery.height / 4,
                width: mediaQuery.width,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(
                  //   color: Colors.black,
                  //   style: BorderStyle.solid,
                  // ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBottomSheet<void>((context) {
                      return Container(
                        height: mediaQuery.height / 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: Colors.black,
                          //   style: BorderStyle.solid,
                          // ),
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
                            const Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ButtomSheetContainer(
                                      icon: Icons.photo_camera,
                                      text: 'Take Photo',
                                    ),
                                  ),
                                  Expanded(
                                    child: ButtomSheetContainer(
                                      text: 'Gallery',
                                      icon: Icons.photo,
                                    ),
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
              Expanded(
                child: Container(
                  width: mediaQuery.width,
                  margin: const EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtomSheetContainer extends StatelessWidget {
  const ButtomSheetContainer({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
}
