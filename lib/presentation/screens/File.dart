
import 'package:doutores_app/logic/cubits/files/ImpostosCubit.dart';
import 'package:doutores_app/logic/cubits/files/FilesState.dart';
import 'package:doutores_app/logic/cubits/files/OtherFilesCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/APPColors.dart';
import '../Widgets/Alerts.dart';
import '../Widgets/Drawer.dart';
import '../widgets/FileComponent.dart';
import '../widgets/LoadingDialog.dart';
import 'package:doutores_app/data/models/FileModel.dart';

class FileScreen extends StatefulWidget {
  static var tag = "/files";

  const FileScreen({Key? key}) : super(key: key);

  @override
  FileScreenState createState() => FileScreenState();
}

class FileScreenState extends State<FileScreen> {

  late ImpostosCubit _impostosCubit;
  late OtherFilesCubit _otherFilesCubit;

  List<String> tabList = [
    'DARF',
    'FGTS',
    'Cert. Dig.',
    'Folha',
    'Notas Fiscais',
    'Simples'
  ];

  Future<void> _pullRefresh() async {
    _impostosCubit.getImpostosList();
    _otherFilesCubit.getOtherFilesList();
  }

  BlocBuilder<ImpostosCubit, FilesState> getImpostosBlocBuilder(String type){
    return BlocBuilder<ImpostosCubit, FilesState>(
      bloc: _impostosCubit,
      builder: (context, state) {

        List<File> filesList = [];

        if(state is NoInternetStateFiles){
          Alerts.noInternetError(context);
          return const Center(child: Text('Sem Dados'));
        }
        else if (state is LoadingStateFiles){
          return LoadingDialog.showLittleLoading();
        }

        if (state is LoadedStateFiles){
          filesList = state.files;


          if(filesList.isEmpty){
            return const Center(child: Text('Sem Dados'));
          }else {
            return RefreshIndicator(
              onRefresh: () => _pullRefresh(),
              child: FileComponent(
                  filesList: filesList.where((i) => i.type == type).toList()
              ),
            );
          }
        }

        return const Center(child: Text('Sem Dados'));
      },
    );
  }

  BlocBuilder<OtherFilesCubit, FilesState> getOtherFilesBlocBuilder(String type){
    return BlocBuilder<OtherFilesCubit, FilesState>(
      bloc: _otherFilesCubit,
      builder: (context, state) {

        List<File> filesList = [];

        if (state is LoadingStateFiles){
          return LoadingDialog.showLittleLoading();
        }

        if (state is LoadedStateFiles){
          filesList = state.files;

          return RefreshIndicator(
            onRefresh: () => _pullRefresh(),
            child: FileComponent(
                filesList: filesList.where((i) => i.type == type).toList()
            ),
          );
        }

        return const Center(child: Text('Sem Dados'));
      },
    );
  }

  int selectedTab = 0;


  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    _impostosCubit = BlocProvider.of<ImpostosCubit>(context);
    if(_impostosCubit.state is InitialStateFiles)_impostosCubit.getImpostosList();

    _otherFilesCubit = BlocProvider.of<OtherFilesCubit>(context);
    if(_otherFilesCubit.state is InitialStateFiles)_otherFilesCubit.getOtherFilesList();


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: APPBackGroundColor,
        appBar: AppBar(
          title: const Text('Arquivos', style: TextStyle(
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

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              HorizontalList(
                spacing: 2,
                padding: const EdgeInsets.all(16),
                itemCount: tabList.length,
                itemBuilder: (context, index) {
                  return AppButton(
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius(8)),
                    text: tabList[index],
                    textStyle: boldTextStyle(
                        color: selectedTab == index ? Colors.white : Colors
                            .black87, size: 14),
                    onTap: () {
                      selectedTab = index;
                      setState(() {});
                    },
                    elevation: 0,
                    color: selectedTab == index ? APPColorSecondary : const Color.fromRGBO(248, 248, 248, 1),
                  );
                },
              ),
              (tabList[selectedTab] == "DARF" || tabList[selectedTab] == "FGTS" || tabList[selectedTab] == "Simples")
              ? getImpostosBlocBuilder(tabList[selectedTab])
              : getOtherFilesBlocBuilder(tabList[selectedTab])
            ],
          ),
        ),
        drawer: const T2Drawer(),
      ),
    );
  }
}
