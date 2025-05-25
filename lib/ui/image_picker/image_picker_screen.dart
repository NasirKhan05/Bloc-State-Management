import 'dart:io';

import 'package:block_state_examples/bloc/images_picker/images_picker_bloc.dart';
import 'package:block_state_examples/bloc/images_picker/images_picker_event.dart';
import 'package:block_state_examples/bloc/images_picker/images_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Bloc'),
        centerTitle:  true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ImagePickerBloc, ImagePickerStates>(
                builder: (context, state){
                  if(state.file == null){
                    return InkWell(
                      onTap: (){
                        context.read<ImagePickerBloc>().add(CameraCapture());
                      },
                      child: Center(
                        child: CircleAvatar(
                          child: Icon(Icons.camera),
                        ),
                      ),
                    );
                  }else{
                    return Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: FileImage(File(state.file!.path)),
                              fit: BoxFit.cover
                          ),

                        ),
                      ),
                    );
                  }
                }
            ),
            SizedBox(height: 20,),
            BlocBuilder<ImagePickerBloc, ImagePickerStates>(
                builder: (context, state){
                  if(state.galleryImage == null){
                    return InkWell(
                      onTap: (){
                        context.read<ImagePickerBloc>().add(GalleryImageCapture());
                      },
                      child: Center(
                        child: CircleAvatar(
                          child: Icon(Icons.file_copy_outlined),
                        ),
                      ),
                    );
                  }else{
                    return Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: FileImage(File(state.galleryImage!.path)),
                              fit: BoxFit.cover
                          ),

                        ),
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      )
    );
  }
}
