import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';


class Uploader extends StatefulWidget {
   File file;
   Uploader(this.file);
  createState() => _UploaderState();
}


class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://pot-holes.appspot.com');
 TextEditingController Locations = TextEditingController();
   
  StorageUploadTask _uploadTask;
   
  /// Starts an upload task
  void _startUpload() {

    /// Unique file name for the file
    String hole=(Locations.text);
    String filePath = 'images/'+hole+'.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Locations.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(

                children: [
                  if (_uploadTask.isComplete)
                  RaisedButton(
                    child:Text('🎉Thanks for reporting 🎉'),
                    onPressed: (){
                      
                    },
                  ),
                    
                    
                  
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: _uploadTask.resume,
                    ),

                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause),
                      onPressed: _uploadTask.pause,
                    ),

                  // Progress bar
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                  ),
                ],
              );
          }
          );

          
    } else {

      // Allows user to decide when to start the upload
      return Column(

        children: [
         TextField(
           style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w300),
           decoration: InputDecoration(
             hintText: "Enter Location of pothole",
    icon: Icon(Icons.location_on)
  ),
          controller: Locations,
        ),
         FlatButton.icon(
          label: Text('Upload'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload,
        )]);

    }
  }
}