
import 'package:doutores_app/logic/cubits/blog/BlogPostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentState.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentCubit.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:doutores_app/logic/cubits/files/FilesCubit.dart';

import 'package:doutores_app/data/models/PaymentModel.dart';
import 'package:doutores_app/data/models/FileModel.dart';
import 'package:doutores_app/presentation/widgets/BlogComponent.dart';
import 'package:doutores_app/presentation/widgets/DriveComponent.dart';
import 'package:doutores_app/presentation/widgets/PagamentosComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../data/models/BlogSamplePostModel.dart';
import '../widgets/NotificationIcon.dart';
import 'Blog.dart';

import 'package:doutores_app/presentation/widgets/Drawer.dart';
import 'package:doutores_app/utils/AppWidget.dart';

class HomeScreen extends StatefulWidget {
  static var tag = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

int currentIndex = 0;

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue[10],
      appBar: AppBar(
        title: Text('Início', style: boldTextStyle(color: black)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.menu, color: black),
                onPressed: () { _scaffoldKey.currentState!.openDrawer(); }
            );
          },
        ),
        actions: const [ NotificationIcon() ],
        backgroundColor: white,
      ),
      body: SafeArea(
          left: true,
          top: true,
          right: true,
          bottom: true,
          minimum: const EdgeInsets.all(2.0),
          child: Observer(
            builder: (_) => Stack(
              fit: StackFit.expand,
              children: [
                Expanded(
                  //color: Colors.lightBlue[0],
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                            child: text("Mensalidades", textColor: Colors.black, fontFamily: 'Bold', fontSize: 24.0),
                          ),
                          BlocBuilder<PaymentCubit, PaymentState>(

                            builder: (context, state) {

                              List<Payment> paymentsList = [];

                              if (state is LoadedStatePayment){
                                paymentsList = state.payments;
                              }

                              return PagamentosComponent(list: paymentsList);
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(

                              onPressed: (){
                                BlogScreen().launch(context);
                              },
                              child: const Text(
                                'Ver mais...',

                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: text("Impostos", textColor: Colors.black, fontFamily: 'Bold', fontSize: 24.0),
                          ),
                          BlocBuilder<FilesCubit, FilesState>(

                            builder: (context, state) {

                              List<File> filesList = [];

                              if (state is LoadedStateFiles){
                                filesList = state.files;
                              }

                              return DriveComponent(list: filesList);
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: (){
                                BlogScreen().launch(context);
                              },
                              child: const Text(
                                'Ver mais...',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5),
                            child: text("Blog", textColor: Colors.black, fontFamily: 'Bold', fontSize: 24.0),
                          ),
                          //BlogComponent(lblogLastPoststory.blogSamplePosts),
                          BlocBuilder<BlogPostsCubit, BlogPostsState>(

                            builder: (context, state) {

                              List<BlogSamplePost> blogsList = [];

                              if (state is LoadedStateBlog){
                                blogsList = state.blogSamples;
                              }

                              return BlogComponent(blogList: blogsList);
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: (){
                                BlogScreen().launch(context);
                              },
                              child: const Text(
                                'Ver mais...',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      drawer: const T2Drawer(),
    );
  }
}
