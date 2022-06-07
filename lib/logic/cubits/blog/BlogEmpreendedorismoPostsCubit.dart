import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogEmpreendedorismoPostsCubit extends Cubit<BlogPostsState> {
  BlogEmpreendedorismoPostsCubit() : super(InitialStateBlog(BlogRepository.empreendedorismoPosts));

  void getBlogPostsList() async {
    try {
      emit(LoadingStateBlog(BlogRepository.empreendedorismoPosts));
      await BlogRepository.getEmpreendedorismoPosts() ? emit(LoadedStateBlog(BlogRepository.empreendedorismoPosts)) : emit(ErrorStateBlog(BlogRepository.empreendedorismoPosts));

    } catch (e) {
      emit(ErrorStateBlog(BlogRepository.empreendedorismoPosts));
    }
  }


}