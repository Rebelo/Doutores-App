import 'package:equatable/equatable.dart';

import '../../../data/models/BlogModel.dart';

abstract class BlogPostsState extends Equatable {}

class InitialStateBlog extends BlogPostsState {
  InitialStateBlog(this.blogSamples);

  final List<Blog> blogSamples;

  @override
  List<Object> get props => [blogSamples];
}

class LoadingStateBlog extends BlogPostsState {
  LoadingStateBlog(this.blogSamples);

  final List<Blog> blogSamples;

  @override
  List<Object> get props => [blogSamples];
}

class LoadedStateBlog extends BlogPostsState {
  LoadedStateBlog(this.blogSamples);

  final List<Blog> blogSamples;

  @override
  List<Object> get props => [blogSamples];
}

class ErrorStateBlog extends BlogPostsState {
  ErrorStateBlog(this.blogSamples);

  final List<Blog> blogSamples;

  @override
  List<Object> get props => [blogSamples];
}

class NoInternetStateBlog extends BlogPostsState {
  @override
  List<Object> get props => [];
}
