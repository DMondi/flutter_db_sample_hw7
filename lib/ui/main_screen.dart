import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/model/user.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

   @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late TextEditingController _controllerName;
  late TextEditingController _controllerOld;


  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerOld = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder, BlocConsumer
    return BlocListener<UsersBloc, UsersState>(
      listener: (BuildContext context, state) {
        if (state is UsersLoadedState) {
          print(state.users);
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                icon: Icon(Icons.contacts),
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),

            ),
            TextField(
              controller: _controllerOld,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.numbers_outlined),
                labelText: 'How old?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),

            ),
            ElevatedButton(
              onPressed: _addTestValues,
              child: const Text('Add user'),
            ),
            ElevatedButton(
              onPressed: _printUsers,
              child: const Text('Print users'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTestValues() {
    if (_controllerName.text != '' && _controllerOld.text != ''){
      final bloc = BlocProvider.of<UsersBloc>(context);
      bloc.add(
        AddUserEvent(
          User(
            name: _controllerName.text,
            age: int.parse(_controllerOld.text),
          ),
        ),
      );
      _controllerName.text = '';
      _controllerOld.text = '';
      setState(() {

      });
    }
  }

  void _printUsers() {
    final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(LoadUsersEvent());
  }
}
