import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerStates extends Equatable{

  final XFile? file ;
  final XFile? galleryImage;
  const ImagePickerStates({this.file, this.galleryImage});

  ImagePickerStates copyWith ({XFile? file, XFile? galleryImage}){
    return ImagePickerStates(
        file: file ?? this.file,
      galleryImage: galleryImage ?? this.galleryImage
    );
  }

  @override
  List<Object> get props => [];
}