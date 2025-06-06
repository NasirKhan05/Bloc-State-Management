import 'package:equatable/equatable.dart';

abstract class SwitchEvents {
  SwitchEvents();
  @override
  List<Object> get props => [];
}

class EnableOrDisableNotification extends SwitchEvents{}

class SliderEvent extends SwitchEvents{
  double slider ;
  SliderEvent({required this.slider});

  @override
  List<Object> get props => [slider];
}
