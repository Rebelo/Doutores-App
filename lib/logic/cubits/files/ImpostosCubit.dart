
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImpostosCubit extends Cubit<FilesState> {
  ImpostosCubit() : super(InitialStateFiles()) {
    //getFilesList();
  }

  void getImpostosList() async {
    try {
      emit(LoadingStateFiles());
      await FileRepository.getImpostos();
      emit(LoadedStateFiles(FileRepository.impostos));
    } catch (e) {
      emit(ErrorState());
    }
  }




}