import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogContabilidadePostsCubit extends Cubit<BlogPostsState> {
  BlogContabilidadePostsCubit() : super(InitialStateBlog(BlogRepository.contabilidadePosts));

  void getBlogPostsList() async {
    try {
      emit(LoadingStateBlog(BlogRepository.contabilidadePosts));
      await BlogRepository.getContabilidadePosts() ? emit(LoadedStateBlog(BlogRepository.contabilidadePosts)) : emit(ErrorStateBlog(BlogRepository.contabilidadePosts));

    } catch (e) {
      emit(ErrorStateBlog(BlogRepository.contabilidadePosts));
    }
  }

}