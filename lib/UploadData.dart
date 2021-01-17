import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class uploadData extends StatefulWidget {
  @override
  _uploadDataState createState() => _uploadDataState();
}

class _uploadDataState extends State<uploadData> {
  int pro;
  _uploadDataState(){
    FirebaseDatabase firebaseDatabse = FirebaseDatabase.instance;
    firebaseDatabse.reference().child('value').once().then((value) => {
      pro=value.value,
    });
  }
  String productiD = "PRO-IDA-";
  String name,pro_id,o_price,price,details;
  String nothing = "";
  TextEditingController idController= new TextEditingController();
  TextEditingController priceController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController detailController= new TextEditingController();
  TextEditingController o_priceController= new TextEditingController();
  int counter = 0;

  void getValues(){
    name = nameController.text;
    price = priceController.text;
    o_price = o_priceController.text;
    details = detailController.text;
  }

  final picker = ImagePicker();
  File image ;
  File image_3d;

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
                        Container(
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
                  _buildTextField(idController,Icons.format_list_numbered, 'Product ID',true,productiD+pro.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTextField(priceController,Icons.attach_money, 'Price',false,nothing),
                  SizedBox(height: 20,),
                  _buildTextField(o_priceController,Icons.attach_money, 'Old Price',false,nothing),
                  SizedBox(height: 20,),
                  _buildTextField(nameController,Icons.drive_file_rename_outline, 'Product Name',false,nothing),
                  SizedBox(height: 20,),
                  _buildTextField(detailController,Icons.drive_file_rename_outline, 'Details',false,nothing),
                  SizedBox(height: 120,),
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
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if(result != null) {
      image_3d = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }
    Future submitData() async {
    pro++;
    getValues();
    if((idController.toString()==null && priceController.toString() ==null ) || idController.toString() == null || nameController.toString() == null || priceController.toString() == null || image ==null){
      Fluttertoast.showToast(msg: 'Kindly Enter Both Price and ID of the Product and also Image is required' );
    }
    else{
      Firebase.initializeApp();
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
      var demo = firebaseDatabase.reference().child('value');
      demo.set(pro);
      var storage1 = FirebaseStorage.instance.ref('images_3D').child(productiD+pro.toString());
      UploadTask uploadTask = storage1.putFile(image_3d);
      String image_3d_path;
      await uploadTask.whenComplete(() => null).then((value) async{
        await value.ref.getDownloadURL().then((value) => {
          image_3d_path=value,
        });
      });

      var storage = FirebaseStorage.instance.ref('images').child(productiD+pro.toString());
      storage.putFile(image).whenComplete(() => null).then((storageTask) async {
        FirebaseFirestore f_ref=FirebaseFirestore.instance;
        await storageTask.ref.getDownloadURL().then((value) => {
              f_ref.collection('products').doc().set(
            {
              "product ID" : productiD+pro.toString(),
              "price": price,
              "name": name,
              "old price" : o_price,
              "details": details,
              "image_3d path" : image_3d_path,
              "image_path": value,
            })

        });
        Fluttertoast.showToast(msg: 'Data Has been Submitted');
        pro++;
        firebaseDatabase.reference().child('demo').update({
          'value': pro,
        });
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
        onChanged: (text) {
          controller.text=text;
        },
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

