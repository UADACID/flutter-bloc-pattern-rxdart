import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/blocProvider.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/todoListBloc.dart';

class TodoList extends StatelessWidget {
  final _textEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoListBloc = BlocProvider.of<TodoListBloc>(context);

    Column _buildTextInputWithButton() {
      print('build text input');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
              controller: _textEditController,
              decoration: InputDecoration(border: OutlineInputBorder())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                onPressed: () {},
                child: StreamBuilder(
                  stream: todoListBloc.outCounterDone,
                  // initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'completed Todo ${snapshot.data}',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return Text(
                      'completed Todo 0',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  var text = _textEditController.text;
                  if (text.length > 0) {
                    todoListBloc.onSubmitTodo.add(text);
                    _textEditController.clear();
                  }
                },
                child: Icon(Icons.add),
              ),
            ],
          )
        ],
      );
    }

    StreamBuilder _buildListOfTodo() {
      print('build list of todo');
      return StreamBuilder(
        stream: todoListBloc.outList,
        initialData: <Todo>[],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data.length == 0) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Text('No Todo to do'),
                ),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 180.0,
                              child: Text(snapshot.data[index].title,
                                  // maxLines: 5,
                                  softWrap: true,
                                  style: TextStyle(
                                      decoration: snapshot.data[index].done
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none)),
                            ),
                            Checkbox(
                              value: snapshot.data[index].done,
                              onChanged: (value) {
                                todoListBloc.onDoneTodo.add(index);
                              },
                            )
                          ],
                        ),
                        // Icon(Icons.delete)
                        IconButton(
                          onPressed: () {
                            todoListBloc.onDeleteTodo.add(index);
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            ),
          );
        },
      );
    }

    StreamBuilder _buildProgressOverflow() {
      return StreamBuilder(
        stream: todoListBloc.outLoading,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data) {
            return Container(
              color: Colors.black12,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC Todo List'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _buildTextInputWithButton(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildListOfTodo(),
                ],
              ),
            ),
            _buildProgressOverflow(),
          ],
        ),
      ),
    );
  }
}
