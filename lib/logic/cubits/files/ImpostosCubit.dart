
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class ImpostosCubit extends Cubit<FilesState> {
  ImpostosCubit() : super(InitialStateFiles());

  Future getImpostosList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStateFiles());

      }else {
        emit(LoadingStateFiles());

        await FileRepository.getImpostos() ? emit(
            LoadedStateFiles(FileRepository.impostos)) : emit(
            ErrorStateFiles());
      }

    } catch (e) {
      emit(ErrorStateFiles());
    }
  }

}