import 'package:equatable/equatable.dart';

import '../../../data/models/BlogSamplePostModel.dart';

abstract class BlogPostsState extends Equatable {}

class InitialStateBlog extends BlogPostsState {
  @override
  List<Object>  get props => [];
}
class LoadingStateBlog extends BlogPostsState {
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