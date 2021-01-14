import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class uploadData extends StatefulWidget {
  @override
  _uploadDataState createState() => _uploadDataState();
}

class _uploadDataState extends State<uploadData> {
  int pro=0;
  String productiD = "PRO-IDA-";
  String nothing = "";
  TextEditingController idController, priceController, nameController,detailController,o_priceController;
  int counter = 0;

  final picker = ImagePicker();
  File image,image_3d ;
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
        body: SingleChildScrollView(
          child: Container(
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
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      children: [
                        image != null ? Image.file(
                          image,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ): Container(
                          height: 100,
                          width: 100,
                          child: InkWell(
                            onTap: ()=> {
                              chooseImage(),
                            },
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 120,),
                        image_3d != null ? Image.file(
                          image_3d,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ): Container(
                          height: 100,
                          width: 100,
                          child: InkWell(
                            onTap: ()=> {
                              chooseImage_3d(),
                            },
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],

                    ),
                  ),

                  SizedBox(height: 20),
                  _buildTextField(idController,Icons.format_list_numbered, 'Product ID',true,productiD),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTextField(priceController,Icons.attach_money, 'Price',false,nothing),
                  SizedBox(height: 20,),
                  _buildTextField(o_priceController,Icons.attach_money, 'Old Price',false,nothing),
                  SizedBox(height: 20,),
                  _buildTextField(nameController,Icons.drive_file_rename_outline, 'Product Name',false,nothing),
                  SizedBox(height: 20,),
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
  Future  chooseImage_3d() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null)
      {
        image_3d = File(pickedFile.path);
      }
    });
  }
    Future submitData() async {
    pro++;
    String name,price;
    name=nameController.toString();
    price=priceController.toString();
    if((idController.toString()==null && priceController.toString() ==null ) || idController.toString() == null || nameController.toString() == null || priceController.toString() == null || image ==null){
      Fluttertoast.showToast(msg: 'Kindly Enter Both Price and ID of the Product and also Image is required' );
    }
    else{
      Firebase.initializeApp();
      var storage = FirebaseStorage.instance.ref('images').child(productiD+pro.toString());
      storage.putFile(image).whenComplete(() => null).then((storageTask) async {
        FirebaseFirestore f_ref=FirebaseFirestore.instance;
        await storageTask.ref.getDownloadURL().then((value) => {
              f_ref.collection('products').doc().set(
            {
              "product ID" : value,
              "price": price,
              "name": name
            })
        });
        Fluttertoast.showToast(msg: 'Data Has been Submitted');
      });

    }
    initState(){
      super.initState();
      imgRef =FirebaseFirestore.instance.collection('ImageURL');
    }

    }
   Widget _buildTextField(TextEditingController controller, IconData icon, String labelText, bool readOnly , String initialValue) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.blue)),
      child: TextFormField(
        readOnly: readOnly,
        initialValue: initialValue+pro.toString() ,
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

