
import 'package:doutores_app/logic/cubits/blog/BlogPostsCubit.dart';
import 'package:doutores_app/logic/cubits/blog/BlogPostsState.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentState.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentCubit.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:doutores_app/logic/cubits/files/ImpostosCubit.dart';
import '../../logic/cubits/notification/NotificationCubit.dart';
import '../../logic/cubits/notification/NotificationState.dart';

import 'package:doutores_app/data/models/PaymentModel.dart';
import 'package:doutores_app/data/models/FileModel.dart';
import 'package:doutores_app/presentation/widgets/BlogComponent.dart';
import 'package:doutores_app/presentation/widgets/FileComponent.dart';
import 'package:doutores_app/presentation/widgets/PagamentosComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../data/models/BlogSamplePostModel.dart';
import '../../utils/APPColors.dart';
import '../widgets/LoadingDialog.dart';
import '../widgets/NotificationIcon.dart';

import 'package:doutores_app/presentation/widgets/Drawer.dart';

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
    final _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    final _impostosCubit = BlocProvider.of<ImpostosCubit>(context);
    final _paymentCubit = BlocProvider.of<PaymentCubit>(context);
    final _blogPostsCubit = BlocProvider.of<BlogPostsCubit>(context);

    if(_notificationCubit.state is InitialStateNotification)_notificationCubit.getNotificationsList();
    if(_impostosCubit.state is InitialStateFiles)_impostosCubit.getImpostosList();
    if(_paymentCubit.state is InitialStatePayment)_paymentCubit.getPaymentsList();
    if(_blogPostsCubit.state is InitialStateBlog)_blogPostsCubit.getBlogPostsList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: APPBackGroundColor,
      appBar: AppBar(
        title: const Text('Início',  style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: APPBackGroundColor),
        ),
        elevation: 0,
        backgroundColor: APPColorPrimary,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.menu, color: APPBackGroundColor),
                onPressed: () { _scaffoldKey.currentState!.openDrawer(); }
            );
          },
        ),
        actions: const [ NotificationIcon() ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: text("Mensalidades", textColor: Colors.black, fontFamily: 'Bold', fontSize: 24.0),
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mensalidades', style: boldTextStyle(size: 24)),
                            Text('Mostrar Mais', style: boldTextStyle(color: APPColorSecondary)).onTap(
                                  () {
                                Navigator.pushNamed(context, '/blog');
                              },
                            ),
                          ],
                        ).paddingOnly(left: 16, right: 16, top: 25, bottom: 20),

                        BlocBuilder<PaymentCubit, PaymentState>(
                          bloc: _paymentCubit,
                          builder: (context, state) {

                            List<Payment> paymentsList = [];

                            if (state is LoadingStatePayment){
                              return LoadingDialog.showLittleLoading();
                            }

                            if (state is LoadedStatePayment){
                              paymentsList = state.payments;
                              return PagamentosComponent(paymList: paymentsList, size: 3);
                            }

                            return const Center(child: Text('Sem Dados'));
                          },
                        ),10.height,
                        /*const Divider(
                          color: Colors.black26,
                          thickness: 0,
                          height: 5,
                          indent: 50,
                          endIndent: 50,
                        ),*/
                        10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Impostos', style: boldTextStyle(size: 24)),
                            Text('Mostrar Mais', style: boldTextStyle(color: APPColorSecondary)).onTap(
                                  () {
                                Navigator.pushNamed(context, '/files');
                              },
                            ),
                          ],
                        ).paddingOnly(left: 16, right: 16, top: 16, bottom: 0),
                        BlocBuilder<ImpostosCubit, FilesState>(
                          bloc: _impostosCubit,
                          builder: (context, state) {

                            List<File> filesList = [];

                            if (state is LoadingStateFiles){
                              return LoadingDialog.showLittleLoading();
                            }

                            if (state is LoadedStateFiles){
                              filesList = state.files;
                              return FileComponent(filesList: filesList, size: 3);
                            }

                            return const Center(child: Text('Sem Dados'));
                          },
                        ),2.height,
                      /*const Divider(
                        color: Colors.black26,
                        thickness: 0,
                        height: 5,
                        indent: 50,
                        endIndent: 50,
                      ),*/
                      5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Blog', style: boldTextStyle(size: 24)),
                            Text('Mostrar Mais', style: boldTextStyle(color: APPColorSecondary)).onTap(
                                  () {
                                    Navigator.pushNamed(context, '/blog');
                              },
                            ),
                          ],
                        ).paddingOnly(left: 16, right: 16, top: 20, bottom: 16),
                        BlocBuilder<BlogPostsCubit, BlogPostsState>(
                          bloc: _blogPostsCubit,
                          builder: (context, state) {

                            List<BlogSamplePost> blogsList = [];

                            if(state is LoadingStateBlog){
                              return LoadingDialog.showLittleLoading();
                            }

                            if (state is LoadedStateBlog){
                              blogsList = state.blogSamples;
                              return BlogComponent(blogList: blogsList);
                            }

                            return const Center(child: Text('Sem Dados'));

                          },
                        ),
                      ],
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
