import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imageUplod extends StatefulWidget {
  const imageUplod({Key? key}) : super(key: key);

  @override
  State<imageUplod> createState() => _imageUplodState();
}

class _imageUplodState extends State<imageUplod> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('no image select');
    }
  }

  Future<void> uploadeimage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = new http.MultipartRequest('post', uri);
    request.fields['title'] = "Static title";
    var multiport = new http.MultipartFile('image', stream, length);
    // request.fields.add(multiport);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('Uplode image');
    } else {
      print('Filled');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload image"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 350,
                  width: 350,
                  child: image == null
                      ? Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:    AssetImage("assets/nullprofile.png"),
                                  fit: BoxFit.cover)),
                        )
                      : Container(

                          child: Image.file(

                            File(image!.path).absolute,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  uploadeimage();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text("Uploade image"),
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
