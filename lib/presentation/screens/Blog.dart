import 'package:doutores_app/logic/cubits/blog/BlogContabilidadePostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogEmpreendedorismoPostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogTecnologiaPostsCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../data/models/BlogSamplePostModel.dart';
import '../../logic/cubits/blog/BlogPostsState.dart';
import '../../utils/APPColors.dart';
import '../Widgets/BlogComponent.dart';
import '../Widgets/Drawer.dart';
import '../widgets/LoadingDialog.dart';

class BlogScreen extends StatefulWidget {
  static var tag = "/Blog";

  const BlogScreen({Key? key}) : super(key: key);

  @override
  BlogScreenState createState() => BlogScreenState();
}

int currentIndex = 0;

class BlogScreenState extends State<BlogScreen> {

  final BlogTecnologiaPostsCubit _blogTecnologiaPostsCubit = BlogTecnologiaPostsCubit();
  final BlogEmpreendedorismoPostsCubit _blogEmpreendedorismoPostsCubit = BlogEmpreendedorismoPostsCubit();
  final BlogContabilidadePostsCubit _blogContabilidadePostsCubit = BlogContabilidadePostsCubit();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return
      DefaultTabController(
        length: 3,

        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Blog', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: APPBackGroundColor),),
            backgroundColor: APPColorPrimary,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu, color: APPBackGroundColor),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    }
                );
              },
            ),
            bottom: const TabBar(
              isScrollable: true,
              labelColor: APPBackGroundColor,
              indicatorColor: APPColorSecondary,
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
                bloc: _blogContabilidadePostsCubit,
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
                bloc: _blogEmpreendedorismoPostsCubit,
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
                bloc: _blogTecnologiaPostsCubit,
                builder: (context, state) {
                  List<BlogSamplePost> posts = [];

                  if(state is LoadingStateBlog){
                    LoadingDialog.showLoadingDialog(context);
                  }

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

