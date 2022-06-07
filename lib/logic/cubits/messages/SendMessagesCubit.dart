
import 'dart:convert';

import 'package:doutores_app/data/models/MessageModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../messages/GetMessagesCubit.dart';

import '../../../data/repositories/MessagesRepository.dart';

import 'SendMessageState.dart';
import 'dart:io';

class SendMessagesCubit extends Cubit<SendMessageState> {
  SendMessagesCubit() : super(InitialStateMessage());

  void sendMessages(String message, int id, GetMessagesCubit cubit) async {
    try {
      emit(SendingState());

      Response response = await MessagesRepository.sendMessage(message, id);
      if(response.statusCode == 200){
        emit(SentState());

        final parsedJson = json.decode(response.body);

        var obj = Message(parsedJson['id'], parsedJson['message'], parsedJson['created'], parsedJson['ownerId'], parsedJson['userId'], null);

        MessagesRepository.addMessageObj(obj);

        cubit.emitInitialState();
        cubit.emitLoadedState();
      }else{
        emit(ErrorStateMessage());
        cubit.emitInitialState();
        cubit.emitLoadedState();
      }
    } catch (e) {
      emit(ErrorStateMessage());
      cubit.emitInitialState();
      cubit.emitLoadedState();
    }
  }
}


class SendFileCubit extends Cubit<SendMessageState> {
  SendFileCubit() : super(InitialStateMessage());

  void sendFile(String path, int id) async {
    try {
      emit(SendingState());
      Response response = await MessagesRepository.sendMessage("Arquivo", id);
      final parsedJson = json.decode(response.body);
      bool success = await MessagesRepository.sendFile(path, parsedJson['id']);
      if(success){
        emit(SentState());
      }else{
        emit(ErrorStateMessage());
      }
    } catch (e) {
      emit(ErrorStateMessage());
    }
  }


}