import 'package:doutores_app/data/repositories/BlogRepository.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogEmpreendedorismoPostsCubit extends Cubit<BlogPostsState> {
  BlogEmpreendedorismoPostsCubit() : super(InitialState()) {
    getBlogPostsList();
  }

  void getBlogPostsList() async {
    try {
      emit(LoadingStateBlog());
      await BlogRepository.getEmpreendedorismoPosts();
      emit(LoadedStateBlog(BlogRepository.empreendedorismoPosts));
    } catch (e) {
      emit(ErrorState());
    }
  }


}