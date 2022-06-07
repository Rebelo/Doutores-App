import 'package:doutores_app/logic/cubits/tickets/CreateTicketState.dart';
import 'package:doutores_app/logic/cubits/tickets/TicketsCubit.dart';
import 'package:doutores_app/logic/cubits/tickets/TicketsState.dart';
import 'package:doutores_app/logic/cubits/tickets/CreateTicketCubit.dart';
import 'package:doutores_app/utils/APPColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Widgets/Alerts.dart';
import '../widgets/LoadingDialog.dart';

class NewTicketScreen extends StatefulWidget {

  const NewTicketScreen({Key? key}) : super(key: key);

  @override
  NewTicketScreenState createState() => NewTicketScreenState();
}

class NewTicketScreenState extends State<NewTicketScreen> {

  String _dropdownValue = "";
  int id = 0;
  TextEditingController tituloCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    List <Map> assuntosList = [];

    final _ticketsCubit = BlocProvider.of<TicketsCubit>(context);
    final _createTicketCubit = BlocProvider.of<CreateTicketCubit>(context);

    _ticketsCubit.getCompanyGroups();


    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: APPBackGroundColor),
        centerTitle: true,
        title: const Text('Novo Chamado', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: APPBackGroundColor),
        ),
        elevation: 0,
        backgroundColor: APPColorPrimary,
      ),
      body: BlocListener<CreateTicketCubit, CreateTicketState>(
        listener: (context, state) {
          if(state is NoInternetState){
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/newTicket', (Route<dynamic> route) => false);
            Alerts.noInternetError(context);
          }
          else if(state is SendingState){
            LoadingDialog.showLoadingDialog(context);
          }
          else if(state is SentState){
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/newTicket', (Route<dynamic> route) => false);
            Alerts.showError(context, "teste", "desc", "OK", Icons.check);
          }else if(state is ErrorStateCreateTicket){
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/newTicket', (Route<dynamic> route) => false);
            Alerts.showError(context, "teste", "desc", "OK", Icons.check);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 20,
                children: <Widget>[
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextFormField(
                      controller: tituloCont,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                color: APPTextColorSecondary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(width: 1, color: Colors
                                .black38),
                          ),
                          labelText: "Título",

                          labelStyle: const TextStyle(color: Colors.black54),
                          alignLabelWithHint: true,
                          filled: true),
                      cursorColor: Colors.black38,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'É necessário um título';
                        } else if (value.length > 20) {
                          return 'Deve ter no máximo de 20 caracteres';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  BlocBuilder<TicketsCubit, TicketsState>(
                    bloc: _ticketsCubit,
                    builder: (context, state) {
                      if (state is NoInternetStateTickets) {
                        Alerts.noInternetError(context);
                        assuntosList = [];
                      }
                      else if (state is LoadingStateTickets) {
                        LoadingDialog.showLittleLoading();
                      }

                      else if (state is LoadedStateTickets) {
                        assuntosList = state.groups;
                      }

                      return DropdownButtonFormField<String>(
                        elevation: 16,
                        style: primaryTextStyle(),
                        value: _dropdownValue,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: APPTextColorSecondary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black38),
                            ),
                            hintText: "Assunto",
                            hintStyle: const TextStyle(
                                color: APPTextColorSecondary),
                            alignLabelWithHint: false,
                            filled: true),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                        items: assuntosList.map<DropdownMenuItem<String>>((
                            Map value) {
                          id = value.keys
                              .toList()
                              .first;
                          return DropdownMenuItem<String>(
                            value: value.values
                                .toList()
                                .first,
                            child: Text(value.values
                                .toList()
                                .first),
                          );
                        }).toList(),

                      );
                    },
                  ),
                  TextFormField(
                    style: primaryTextStyle(),
                    controller: descCont,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.black45),
                      ),
                      labelText: "Descrição",
                      labelStyle: const TextStyle(color: Colors.black54),
                      alignLabelWithHint: true,
                      filled: true,
                    ),
                    cursorColor: Colors.black38,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    validator: (value) {
                      if (value != null && value.length > 200) {
                        return 'Deve ter no máximo de 200 caracteres';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: APPColorSecondary,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createTicketCubit.createTicket(
                            tituloCont.text, descCont.text, id);
                      }
                    },
                    child: const Text('Enviar', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
