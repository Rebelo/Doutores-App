import 'package:equatable/equatable.dart';

import '../../../data/models/BlogSamplePostModel.dart';

abstract class BlogPostsState extends Equatable {}

class InitialState extends BlogPostsState {
  @override
  List<Object>  get props => [];
}
class LoadingState extends BlogPostsState {
  @override
  List<Object> get props => [];
}

class LoadedStateBlog extends BlogPostsState {
  LoadedStateBlog(this.blogSamples);

  final List<BlogSamplePost> blogSamples;

  @override
  List<Object> get props => [blogSamples];
}

class ErrorState extends BlogPostsState {
  @override
  List<Object> get props => [];
}