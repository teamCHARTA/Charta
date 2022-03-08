import 'dart:io';
import 'dart:typed_data';

import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future pickimage() async{
  ImageSource source=ImageSource.camera;
final ImagePicker _picker = ImagePicker();
final  pickedimage =await _picker.pickImage(source:source);
if(pickedimage==null)return;
var file= await ImageCropper().cropImage(sourcePath:pickedimage.path,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
File? _image = file;
firebaseuploadpic("image1", _image);
}
Future firebaseuploadpic(imagename,file)async{
  final ref=FirebaseStorage.instance.ref('Images/$imagename');
  final uploadTask = await ref.putFile(await file);
  return(await uploadTask.ref.getDownloadURL());




}