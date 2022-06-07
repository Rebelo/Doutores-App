
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class OtherFilesCubit extends Cubit<FilesState> {
  OtherFilesCubit() : super(InitialStateFiles());

  void getOtherFilesList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStateFiles());

      }else {
        emit(LoadingStateFiles());

        await FileRepository.getOtherFiles() ? emit(
            LoadedStateFiles(FileRepository.otherFiles)) : emit(
            ErrorStateFiles());
      }
    } catch (e) {
      emit(ErrorStateFiles());
    }
  }


}