
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(InitialState()) {
    getFilesList();
  }

  void getFilesList() async {
    try {
      emit(LoadingState());
      await FileRepository.getFiles();
      emit(LoadedStateFiles(FileRepository.files));
    } catch (e) {
      emit(ErrorState());
    }
  }


}