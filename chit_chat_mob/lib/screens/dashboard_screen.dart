import 'package:chit_chat_mob/screens/MyBottomNavigationBar.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBottomNavigationBar(),
    );
  }
}



// the below code we used in the upload image case..................
//  final ImagePicker imagePicker = ImagePicker();
//   String filePath = '';
//   double uploadProgress = 0.0;
//   bool hasUploadStarted = false;

//   void setProgress(double value) async {
//     setState(() {
//       uploadProgress = value;
//     });
//   }

//   Future<void> uploadVideo() async {
//     if (filePath.isEmpty) {
//       print('Please select a video file');
//       return;
//     }
//     Dio dio = Dio();
//     try {
//       String url =
//           'https://720d-124-253-63-147.ngrok-free.app/api/upload-video';
//       dio.options.headers['Authorization'] =
//           'Bearer eyJhbGciOiJIUzUxMiJ9.eyJSb2xlIjoiVXNlciIsInVzZXJJZCI6IjY1ODkzNDQ2MmYzY2QyNGIyNGRlMGI2MyIsInN1YiI6InVzZXJAZ21haWwuY29tIiwiaWF0IjoxNzA0NjIwMzQyLCJleHAiOjE3MDQ2MjAzNDI2NjF9.78vIhtuUyeCA92Xk6fl6cTqMN-TJqXQGaubdHPnbphShdTUrIt02XEPWUaugWxLh-xvtMjK0hyOwku2P0HUhbw';
//       dio.options.headers['Content-Type'] = "multipart/form-data";
//       var data = dio.options.headers;
//       FormData formData = FormData.fromMap({
//         'videoFile':
//             await MultipartFile.fromFile(filePath, filename: 'video.mp4'),
//       });

//       await dio.post(
//         url,
//         data: formData,
//         onSendProgress: (int sent, int total) {
//           setState(() {
//             double data = sent / total;
//             uploadProgress = data;
//           });
//         },
//       );

//       print('Video uploaded successfully');
//     } catch (e) {
//       print('Error uploading video: $e');
//     }
//   }

//   void showSuccessSnackBar(BuildContext context, String message) {
//     showSnackBar(context, message, backgroundColor: Colors.green);
//   }

//   void showErrorSnackBar(BuildContext context, String message) {
//     showSnackBar(context, message,
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 60),
//         showCloseIcon: true);
//   }

//   void showSnackBar(BuildContext context, String message,
//       {Color? backgroundColor,
//       Duration duration = const Duration(seconds: 4),
//       bool showCloseIcon = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: backgroundColor,
//         duration: duration,
//         showCloseIcon: showCloseIcon,
//       ),
//     );
//   }

//   _vidoeSelect() async {
//     var selectedVideo =
//         await imagePicker.pickVideo(source: ImageSource.gallery);
//     if (selectedVideo != null) {
//       setState(() {
//         filePath = selectedVideo.path;
//         hasUploadStarted = true;
//       });
//       await uploadVideo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( 
//         backgroundColor: Color.fromARGB(255, 31, 34, 31),
//         appBar: AppBar(
//           title: const Text(
//             "Upload Video Screen",
//             style: TextStyle(color: Colors.white, fontSize: 25),
//           ),
//           backgroundColor: const Color.fromARGB(234, 80, 77, 77),
//           shadowColor: const Color.fromARGB(255, 253, 253, 253),
//           toolbarHeight: 70,
//           centerTitle: true,
//         ),
//         body: Center(
//             child: hasUploadStarted == false
//                 ? ElevatedButton(
//                     onPressed: () async {
//                       await _vidoeSelect();
//                     },
//                     child: const Icon(
//                       Icons.upload,
//                       size: 50,
//                       color: Colors.orange,
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       LinearProgressIndicator(value: uploadProgress),
//                       Text(
//                         'Upload Progress: ${(uploadProgress * 100).toStringAsFixed(2)}%',
//                         style: const TextStyle(color: Colors.white),
//                       )
//                     ],
//                   )));
//   }
