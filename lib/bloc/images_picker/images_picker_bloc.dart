import 'package:block_state_examples/bloc/images_picker/images_picker_event.dart';
import 'package:block_state_examples/bloc/images_picker/images_picker_state.dart';
import 'package:block_state_examples/utils/image_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerStates>{

  final ImagePickerUtils imagePickerUtils ;
  ImagePickerBloc(this.imagePickerUtils): super(const ImagePickerStates()){
    on<CameraCapture>(cameraCapture);
    on<GalleryImageCapture>(pickImageFromGallery);
  }

  void cameraCapture(CameraCapture event, Emitter<ImagePickerStates> emit) async{
    final XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void pickImageFromGallery(GalleryImageCapture event, Emitter<ImagePickerStates> emit) async{
    final XFile? galleryImage = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(galleryImage: galleryImage));
  }
}

