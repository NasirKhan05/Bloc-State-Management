import 'package:bloc/bloc.dart';
import 'package:block_state_examples/bloc/switch_examples/switch_event.dart';
import 'package:block_state_examples/bloc/switch_examples/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvents, SwitchStates>{

  SwitchBloc(): super(SwitchStates()){
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotification(EnableOrDisableNotification event, Emitter<SwitchStates> emit){
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchStates> emit){
    emit(state.copyWith(slider: event.slider));
  }
}