import 'package:doutores_app/logic/cubits/blog/BlogContabilidadePostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogEmpreendedorismoPostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogTecnologiaPostsCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../data/models/BlogSamplePostModel.dart';
import '../../logic/cubits/blog/BlogPostsCubit.dart';
import '../../logic/cubits/blog/BlogPostsState.dart';
import '../Widgets/BlogComponent.dart';
import '../../data/repositories/BlogRepository.dart';
import '../Widgets/Drawer.dart';

class BlogScreen extends StatefulWidget {
  static var tag = "/Blog";

  const BlogScreen({Key? key}) : super(key: key);

  @override
  BlogScreenState createState() => BlogScreenState();
}

int currentIndex = 0;

class BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return
      DefaultTabController(
        length: 3,

        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Blog', style: boldTextStyle(color: black)),
            backgroundColor: white,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu, color: black),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    }
                );
              },
            ),
            bottom: const TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              indicatorColor: Colors.black12,
              tabs: [
                Tab(text: "Contabilidade"),
                Tab(text: "Empreendedorismo"),
                Tab(text: "Tecnologia e Futuro dos Negócios"),
              ],
            ),

          ),
          body: TabBarView(
            children: [
              BlocBuilder<BlogContabilidadePostsCubit, BlogPostsState>(
                builder: (context, state) {

                  List<BlogSamplePost> posts = [];

                  if (state is LoadedStateBlog) {
                    posts = state.blogSamples;
                  }

                  return BlogComponent(
                      blogList: posts,
                  );
                },
              ),
              BlocBuilder<BlogEmpreendedorismoPostsCubit, BlogPostsState>(
                builder: (context, state) {
                  List<BlogSamplePost> posts = [];

                  if (state is LoadedStateBlog) {
                    posts = state.blogSamples;
                  }

                  return BlogComponent(
                    blogList: posts,
                  );
                },
              ),
              BlocBuilder<BlogTecnologiaPostsCubit, BlogPostsState>(
                builder: (context, state) {
                  List<BlogSamplePost> posts = [];

                  if (state is LoadedStateBlog) {
                    posts = state.blogSamples;
                  }

                  return BlogComponent(
                    blogList: posts,
                  );
                },
              ),
            ],
          ),
          drawer: const T2Drawer(),
        ),
      );
  }
}

