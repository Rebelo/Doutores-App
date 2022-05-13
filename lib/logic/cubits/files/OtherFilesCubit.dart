
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherFilesCubit extends Cubit<FilesState> {
  OtherFilesCubit() : super(InitialStateFiles()) {
    //getFilesList();
  }

  void getOtherFilesList() async {
    try {
      emit(LoadingStateFiles());
      await FileRepository.getOtherFiles();
      emit(LoadedStateFiles(FileRepository.otherFiles));
    } catch (e) {
      emit(ErrorState());
    }
  }


}