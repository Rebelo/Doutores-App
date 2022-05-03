import 'package:doutores_app/data/models/FileModel.dart';
import 'package:equatable/equatable.dart';

abstract class FilesState extends Equatable {}

class InitialState extends FilesState {
  @override
  List<Object> get props => [];
}
class LoadingStateFiles extends FilesState {
  @override
  List<Object> get props => [];
}

class LoadedStateFiles extends FilesState {
  LoadedStateFiles(this.files);

  final List<File> files;

  @override
  List<Object> get props => [files];
}

class ErrorState extends FilesState {
  @override
  List<Object> get props => [];
}