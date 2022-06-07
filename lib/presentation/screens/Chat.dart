import 'package:doutores_app/logic/cubits/messages/GetMessagesCubit.dart';
import 'package:doutores_app/logic/cubits/messages/GetMessagesState.dart';
import 'package:doutores_app/logic/cubits/messages/SendMessageState.dart';
import 'package:doutores_app/logic/cubits/messages/SendMessagesCubit.dart';
import 'package:doutores_app/utils/APPColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../data/models/MessageModel.dart';
import '../../data/models/UserModel.dart';
import '../widgets/ChatMessage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {


  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {



  ScrollController scrollController = ScrollController();
  TextEditingController msgController = TextEditingController();
  FocusNode msgFocusNode = FocusNode();

  var personName = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  sendDocument() async {

  }

  sendClick() async {

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final id = arguments['id'];
    final name = arguments['name'];

    final _sendMessagesCubit = BlocProvider.of<SendMessagesCubit>(context);
    final _sendFileCubit = BlocProvider.of<SendFileCubit>(context);
    final _messagesCubit = BlocProvider.of<GetMessagesCubit>(context);
    _messagesCubit.getMessagesList(id);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPColorPrimary,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(radius: 16, child: Image.asset('assets/images/app/placeholder.jpg'),),
            10.width,
            Text(
              name!.split(" ")[0]+" "+name!.split(" ")[1],
              style: boldTextStyle(color: APPBackGroundColor, size: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 16),
              icon: const Icon(
                  Icons.attach_file, color: APPBackGroundColor, size: 20),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles();
                if (result != null) {
                  _sendFileCubit.sendFile(result.files.single.path!, id);
                }
              }
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<GetMessagesCubit, GetMessagesState>(
            bloc: _messagesCubit,
            builder: (context, state) {

              List<Message> messagesList = [];

              if(state is LoadedState){

                messagesList = state.messages;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(color: context.cardColor),
                  child: ListView.separated(
                    separatorBuilder: (_, i) =>
                    const Divider(color: Colors.transparent),
                    shrinkWrap: true,
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 70),
                    itemBuilder: (_, index) {
                      Message data = messagesList[messagesList.length - 1 - index];
                      var isMe = (data.authorId == data.userId);

                      return ChatMessageWidget(isMe: isMe, data: data);
                    },
                  ),
                );
              }

              else if(state is InitialState){
                return Container();
              }

              else if(state is ErrorState){
                return Container();
              }

              else {
                return Container();
              }

            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: context.cardColor, boxShadow: defaultBoxShadow()),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: msgController,
                    focusNode: msgFocusNode,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Escreva sua mensagem',
                      hintStyle: primaryTextStyle(),
                    ),
                    style: primaryTextStyle(),
                  ).expand(),
                  IconButton(
                    icon: const Icon(Icons.send, size: 25),
                    onPressed: () async {
                      _sendMessagesCubit.sendMessages(msgController.text.trim(), id, _messagesCubit);
                      msgController.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
