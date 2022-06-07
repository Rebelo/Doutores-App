import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogTecnologiaPostsCubit extends Cubit<BlogPostsState> {
  BlogTecnologiaPostsCubit() : super(InitialStateBlog(BlogRepository.tecnologiaPosts));

  void getBlogPostsList() async {
    try {
      emit(LoadingStateBlog(BlogRepository.tecnologiaPosts));
      await BlogRepository.getTecnologiaPosts() ? emit(LoadedStateBlog(BlogRepository.tecnologiaPosts)) : emit(ErrorStateBlog(BlogRepository.tecnologiaPosts));

    } catch (e) {
      emit(ErrorStateBlog(BlogRepository.tecnologiaPosts));
    }
  }


}