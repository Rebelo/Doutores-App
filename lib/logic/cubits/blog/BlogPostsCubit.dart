
import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class BlogPostsCubit extends Cubit<BlogPostsState> {
  BlogPostsCubit() : super(InitialStateBlog(BlogRepository.last3Posts)) {
    //getBlogPostsList();
  }

  Future getBlogPostsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStateBlog());

      }else {
        emit(LoadingStateBlog(BlogRepository.last3Posts));
        await BlogRepository.getLast3Posts() ? emit(
            LoadedStateBlog(BlogRepository.last3Posts)) : emit(
            ErrorStateBlog(BlogRepository.last3Posts));
      }
    } catch (e) {
      emit(ErrorStateBlog(BlogRepository.last3Posts));
    }
  }

  void goToInitialState(){
    emit(InitialStateBlog(BlogRepository.last3Posts));
  }


}