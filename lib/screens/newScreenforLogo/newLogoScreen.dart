import 'dart:html' as html;
import 'dart:typed_data';

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/screens/main_screen/main_screen.dart';
import 'package:yucatan/screens/onboarding_screen/onboarding_screen.dart';
import 'package:yucatan/utils/check_condition.dart';
import 'package:yucatan/utils/color_utils.dart';
import 'package:yucatan/utils/rive_animation.dart';

import '../../theme/custom_theme.dart';
import '../../utils/theme_model.dart';
import '../../utils/widget_dimensions.dart';

class LogoScreen extends StatefulWidget {
  static const route = '/newScreenforLogo';
  ThemeModel? model;

  LogoScreen({Key? key, this.model}) : super(key: key);

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  final List<String> language = ['English', 'Deutsch'];
  var selectedValue = 'English';
  var initialIndex = 0;
  var box = Hive.box('myBox');
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  html.File? _cloudFile;
  Uint8List? _fileBytes;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Color mycolor = Colors.lightBlue;

// ValueChanged<Color> callback

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.pixels_18,
                  ),
                  Text(
                    'Welcome to AppVenture Demo.',
                    style: TextStyle(
                        fontSize: Dimensions.getScaledSize(17.0),
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: Dimensions.pixels_18,
                  ),
                  const Text(
                    'We will give you a concrete preview of the app for your destination within seconds.\nPlease share the below requsted information.',
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 13,
                                  width: 100,
                                  color: index == initialIndex
                                      ? Provider.of<ThemeModel>(context,
                                              listen: true)
                                          .primaryMainColor
                                      : Colors.grey,
                                ),
                              )),
                    ),
                  ),
                ],
              ),
              initialIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Let us know your configurations'),
                          buildSizedBox(Dimensions.pixels_50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                openGallery();
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(4),
                                  // color: Colors.pink,
                                  border: Border(
                                    // top: BorderSide(
                                    //     width: 1.0,
                                    //     color: Colors.grey.shade600),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black),
                                    // left: const BorderSide(
                                    //     width: 1.0, color: Colors.black),
                                    // right: const BorderSide(
                                    //     width: 1.0, color: Colors.black),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Dimensions.getScaledSize(20.0),
                                      Dimensions.getScaledSize(10.0),
                                      0,
                                      0),
                                  child: const Text(
                                    'Please upload your logo',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          buildSizedBox(Dimensions.pixels_20),
                          Container(
                            height: Dimensions.getHeight(percentage: 25.0),
                            child: FutureBuilder(
                              future:
                                  checkCondition(), // a Future<String> or null
                              builder: (BuildContext context,
                                  AsyncSnapshot<Uint8List> snapshot) {
                                return snapshot.hasData
                                    ? Image.memory(snapshot.data!)
                                    : RiveAnimation(
                                        riveFileName: 'app-start.riv',
                                        riveAnimationName: 'Animation 1',
                                        placeholderImage:
                                            'lib/assets/images/appventure_icon_white.png',
                                        startAnimationAfterMilliseconds: 2,
                                      );

                                // switch (snapshot.connectionState) {
                                //   case ConnectionState.none:
                                //     return Text("See the printed Data${snapshot.data!}");
                                //       // Image(
                                //     // image: FileImage(File(snapshot.data!)),
                                //   // );
                                //   case ConnectionState.waiting: return const Text('Awaiting result...');
                                //   default:
                                //     if (snapshot.hasError) {
                                //       return Text('Error: ${snapshot.error}');
                                //     } else {
                                //       return Text('Result: ${snapshot.data}');
                                //     }
                                // }
                              },
                            ),
                          ),
                          buildSizedBox(Dimensions.pixels_50),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                // model.se
                                // tPrimaryMainColor();
                                // model.setAppbarShadeColor(
                                //     const Color(0xffEB0060));
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: pickerColor,
                                          onColorChanged: (Color color) {
                                            setState(() {
                                              pickerColor = color;
                                              var newPrimaryColor =
                                                  pickerColor.toHex;
                                              Provider.of<ThemeModel>(context,
                                                      listen: false)
                                                  .setPrimaryMainColor(color);
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('Got it'),
                                          onPressed: () {
                                            setState(() =>
                                                currentColor = pickerColor);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(4),
                                  // color: Colors.pink,
                                  border: Border(
                                    // top: BorderSide(
                                    //     width: 1.0,
                                    //     color: Colors.grey.shade600),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black),
                                    // left: const BorderSide(
                                    //     width: 1.0, color: Colors.black),
                                    // right: const BorderSide(
                                    //     width: 1.0, color: Colors.black),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Dimensions.getScaledSize(20.0),
                                      Dimensions.getScaledSize(10.0),
                                      0,
                                      0),
                                  child: const Text(
                                    'Please tell us your primary colors',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // buildSizedBox(Dimensions.pixels_20),
                          // TextField(
                          //   decoration: InputDecoration(
                          //       hintText: 'Please tell us your secondary colors',
                          //       // AppLocalizations.of(context)!
                          //       //     .forgotPasswordScreen_emailHint,
                          //       hintStyle: TextStyle(
                          //         color: Colors.grey[500],
                          //       )),
                          //   // controller: emailController,
                          //   keyboardType: TextInputType.name,
                          // ),
                          buildSizedBox(Dimensions.pixels_20),
                          const Text(
                            'In which language you want to preview the app?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              child: Center(
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 35,
                                  ),
                                  underline: const SizedBox(),
                                  isExpanded: true,
                                  isDense: true,
                                  value: selectedValue,
                                  items: language.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                    if (selectedValue == 'Deutsch') {
                                      Provider.of<ThemeModel>(context,
                                              listen: false)
                                          .setLocale(Locale('de'));
                                    } else {
                                      Provider.of<ThemeModel>(context,
                                              listen: false)
                                          .setLocale(Locale('en'));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : initialIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizedBox(Dimensions.pixels_30),
                              const Text('Contact information'),
                              buildSizedBox(Dimensions.pixels_30),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'First name',
                                          // AppLocalizations.of(context)!
                                          //     .forgotPasswordScreen_emailHint,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                          )),
                                      controller: firstController,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.pixels_30,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Last name',
                                          // AppLocalizations.of(context)!
                                          //     .forgotPasswordScreen_emailHint,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                          )),
                                      controller: lastController,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                              buildSizedBox(Dimensions.pixels_30),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Organization',
                                    // AppLocalizations.of(context)!
                                    //     .forgotPasswordScreen_emailHint,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    )),
                                controller: organizationController,
                                keyboardType: TextInputType.name,
                              ),
                              buildSizedBox(Dimensions.pixels_30),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'E-mail-address',
                                    // AppLocalizations.of(context)!
                                    //     .forgotPasswordScreen_emailHint,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    )),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              buildSizedBox(Dimensions.pixels_30),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Phone No.',
                                    // AppLocalizations.of(context)!
                                    //     .forgotPasswordScreen_emailHint,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    )),
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
              buildSizedBox(Dimensions.pixels_20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor:
                          Provider.of<ThemeModel>(context, listen: true)
                              .primaryMainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minimumSize: Size(
                          MediaQuery.of(context).size.width, 40), //////// HERE
                    ),
                    onPressed: () {
                      setState(() {
                        if (initialIndex == 0) {
                          initialIndex++;
                        } else if (initialIndex == 1) {
                          if (emailController.text.isEmpty ||
                              firstController.text.isEmpty ||
                              lastController.text.isEmpty ||
                              organizationController.text.isEmpty ||
                              phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please Enter Full Data"),
                              duration: Duration(milliseconds: 300),
                            ));
                          } else {
                            initialIndex++;
                          }
                        } else {
                          Navigator.of(context)
                              .pushNamed(OnboardingScreen.route);
                        }
                      });
                    },
                    child: initialIndex == 0
                        ? const Text('Confirm and go to next step')
                        : initialIndex == 1
                            ? const Text('Confirm and see app emulation')
                            : const Text('Start Your App')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox(double pixelValue) {
    return SizedBox(
      height: pixelValue,
    );
  }

  Future<void> openGallery() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String? mimeType = mime(Path.basename(mediaData!.fileName!));
    html.File mediaFile =
        html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _cloudFile = mediaFile;
        _fileBytes = mediaData.data;
        // _imageWidget = Image.memory(mediaData.data!);
      });
    }

    box.put('imageData', _fileBytes);

    var name = box.get('imageData');

    print('Name: $name');
  }
}
