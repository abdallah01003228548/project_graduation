import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_section_state.dart';

class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(const AppSectionState(currentIndex: 0));

  void changeIndex(int index) {
    emit(AppSectionState(currentIndex: index));
  }
}
