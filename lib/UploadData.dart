import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class uploadData extends StatefulWidget {
  @override
  _uploadDataState createState() => _uploadDataState();
}

class _uploadDataState extends State<uploadData> {

  TextEditingController idController, priceController, nameController;
  int counter = 0;

  final picker = ImagePicker();
  File image ;
  CollectionReference imgRef;
  String url;
  Color primaryColor = Colors.black87;
  Color secondaryColor = Colors.white;
  Color logoColor  =   Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Welcome to Admin Controls',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'You can add new products and also modify the products details as well',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 30),
                image != null ? Image.file(
                    image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ): Container(
                  height: 100,
                  width: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(idController,Icons.format_list_numbered, 'Product ID'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(priceController,Icons.attach_money, 'Price'),
                SizedBox(height: 20,),
                _buildTextField(nameController,Icons.drive_file_rename_outline, 'Product Name'),
                SizedBox(height: 20,),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  color: Colors.green,
                  onPressed: chooseImage,
                  child: Text('Choose Image',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: submitData,
                  color: Colors.red,
                  child: Text('Submit Data',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),

              ],
            ),
          ),
        ));

  }
  _buildFooterLogo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            'images/logo.png',
            height: 40,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Future  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null)
        {
          image = File(pickedFile.path);
        }
      });
    }
    Future submitData() async {
    if((idController.toString()==null &&priceController.toString() ==null ) || idController.toString() == null || nameController.toString() == null || priceController.toString() == null || image ==null){
      Fluttertoast.showToast(msg: 'Kindly Enter Both Price and ID of the Product and also Image is required' );
    }
    else{
      var storage = FirebaseStorage.instance.ref('images').child(image.path.toString());
      storage.putFile(image).whenComplete(() => null).then((storageTask) async {
        await storageTask.ref.getDownloadURL().then((value) => {
          imgRef.add({'url': value})
        });
        Fluttertoast.showToast(msg: 'Data Has been Submitted');
      });

    }
    initState(){
      super.initState();
      imgRef =FirebaseFirestore.instance.collection('ImageURL');
    }

    }
   Widget _buildTextField(TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black87),
            icon: Icon(
              icon,
              color: Colors.black87,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );


  }

  }

