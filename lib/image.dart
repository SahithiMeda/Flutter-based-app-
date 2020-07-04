import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'uploading.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
       
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
      );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    
    File selected = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        
      resizeToAvoidBottomPadding: false,
      

      body: ListView(
        children: <Widget>[
             
          if (_imageFile != null) ...[

            Image.file(_imageFile),

            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
                
              ],
            ),

            Uploader(_imageFile)
          ]
          else...[
            
            Column(
            children: <Widget>[
               SizedBox(height: 10),
             Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/pothole.jpg'),
          fit: BoxFit.fill,
        ),
        
      ),
    ),
     SizedBox(height: 20),
    Center(
        child: Text('Report a pothole  and help others have a safe journey',
            textAlign: TextAlign.center,
            style:TextStyle(color: Colors.brown,
      fontWeight: FontWeight.bold,fontSize: 28, )),)
      
      
            ]
            ),
            BottomAppBar(
      
        child: Container(
          
          height: 135,
        child: Row(
          mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
          children: <Widget>[
         
            IconButton(
              iconSize: 40.0,
                padding: EdgeInsets.only(left: 48.0),
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
           
            IconButton(
              iconSize: 40.0,
                padding: EdgeInsets.only(right: 48.0),
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
         ),
      ),),
           
          ]

          
        ],
      ),
    );
  }
}