import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPostsCubit extends Cubit<BlogPostsState> {
  BlogPostsCubit() : super(InitialState()) {
    getBlogPostsList();
  }

  void getBlogPostsList() async {
    try {
      emit(LoadingState());
      await BlogRepository.getLast3Posts();
      emit(LoadedStateBlog(BlogRepository.last3Posts));
    } catch (e) {
      emit(ErrorState());
    }
  }


}