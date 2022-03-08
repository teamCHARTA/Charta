
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:charta/functions/database.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
class Addproductpage extends StatefulWidget {
  const Addproductpage({Key? key}) : super(key: key);

  @override
  _AddproductpageState createState() => _AddproductpageState();
}

class _AddproductpageState extends State<Addproductpage> {
  var formkey= GlobalKey<FormState>();
  var quantity=0;
  var usedpersent=0;
  String image1url="";
  String image2url="";
  UploadTask? task1;
  UploadTask? task2;
  File? file1;
  File? file2;

  @override
  Widget build(BuildContext context) {
    final fileName1 = file1 != null ?basename(file1!.path) : " ";
    final fileName2 = file2 != null ?basename(file2!.path) : " ";
    return Scaffold(
      appBar: AppBar(title: Text("Addpaper"),),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Row(
                  children:[
                    TextButton(onPressed: (){
                      selectFile1();
                      setState(() {

                      });
                    }, child: Text("Select Image")),
                    SizedBox(height: 4),
                    Text(
                      fileName1,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 3,),
                  ]
                ),
                SizedBox(height: 20),
                task1 != null ? buildUploadStatus(task1!) : Container(),
                Row(
                    children:[
                      TextButton(
                          onPressed: (){
                            selectFile2();

                          }, child: Text("Select Image")),
                      SizedBox(height: 4),
                      Text(
                        fileName2,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 3,),
                    ]
                ),
                SizedBox(height: 20),
                task2 != null ? buildUploadStatus(task2!) : Container(),



              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText:"Quantity",
                  labelText:"paper quantity",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(8.0)
                  )
                ),
                validator: (text){
                  if(text!.isEmpty){
                    return "please enter the Quantity";
                  }
                  else{
                    quantity=int.parse(text);
                    return null;
                  }
                },

              ),
              SizedBox(height: 5,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText:"used persent",
                      labelText:"persentage of used space",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(8.0)
                      )
                  ),
                  validator:(text){
                    if(text!.isEmpty){
                      return "please enter the Quantity";
                    }
                    else{
                      usedpersent=int.parse(text);
                      return null;
                    }
                  },

                ),
                SizedBox(height: 5,),
              Row(
                children: [
                  TextButton(onPressed: (){

                      if(formkey.currentState!.validate()&&file1!=null&&file2!=null){

                        uploadFile(file1,file2);





                      }
                      else{
                        print("error");
                        final message='Enter the every data';
                        final snackbar=SnackBar(content: Text(message));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }


                    }, child: Text("submit")),
                  SizedBox(width: 15,),
                  TextButton(onPressed: (){
                    formkey.currentState!.reset();
                    setState(() {
                      file1 =null;
                      file2 =null;
                      usedpersent=0;
                      quantity=0;
                      task1=null;
                      task2=null;

                    });
                  }, child: Text("Clear")),


                ],
              )

            ],),
          ),
        ),
      ) ,

    );





  }

  Future selectFile1() async {
    ImageSource source = ImageSource.gallery;
    final ImagePicker _picker = ImagePicker();
    final pickedimage = await _picker.pickImage(source: source);
    if (pickedimage == null) return;
    var result = await ImageCropper().cropImage(sourcePath: pickedimage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));


    if (result == null) return;
    final path = result.path;

    setState(() => file1 = File(path));
  }

  Future selectFile2() async {
    ImageSource source = ImageSource.gallery;
    final ImagePicker _picker = ImagePicker();
    final pickedimage = await _picker.pickImage(source: source);
    if (pickedimage == null) return;
    var result = await ImageCropper().cropImage(sourcePath: pickedimage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));


    if (result == null) return;
    final path = result.path;

    setState(() => file2 = File(path));
  }


  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);
        if(percentage=="100.00"){

          return  Text(
            'Completed ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        }
        else{
          return  Text(
            '$percentage %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        }


      } else {
        return Container();
      }
    },
  );

  Future uploadFile(image1,image2) async {
    if (image1 == null) return;
    if (image1 == null) return;

    final fileName1 = basename(image1!.path);
    final fileName2 = basename(image2!.path);
    final destination1 = 'Images/$fileName1';
    final destination2 = 'Images/$fileName2';

    task1 = Database.uploadFile(destination1, image1!);
    task2 = Database.uploadFile(destination2, image2!);
    setState(() {});

    if (task1 == null) return;
    if (task2 == null) return;

    final snapshot1 = await task1!.whenComplete(() {});
    final snapshot2 = await task2!.whenComplete(() {});
    final urlDownload1 = await snapshot1.ref.getDownloadURL();
    final urlDownload2 = await snapshot2.ref.getDownloadURL();


    setState(() {
      image1url=urlDownload1;
      image2url=urlDownload2;
    });

    Database().WritePaperData(quantity, usedpersent,image1url,image2url);


  }


}

