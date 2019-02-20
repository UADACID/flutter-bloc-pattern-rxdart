import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/blocProvider.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/todoList.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/todoListBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoListBloc>(
      bloc: TodoListBloc(),
      child: MaterialApp(
        title: 'Demo',
        home: TodoList(),
      ),
    );
  }
}
