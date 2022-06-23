import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

import '../model/todo.dart';

class ToDoListFilterWidget extends StatefulWidget {
  final List<ToDo> todos;
  List<ToDo> filteredToDos;
  Function onSearch;
  ToDoListFilterWidget({
    Key? key,
    required this.todos,
    required this.onSearch,
    required this.filteredToDos}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoListFilterWidgetState();

}

class _ToDoListFilterWidgetState extends State<ToDoListFilterWidget> {
  TextEditingController searchController = TextEditingController();


  _onItemChanged(String value) {
    log.d("Search Initiated with value: $value");
    widget.onSearch(widget.todos
        .where((todo) =>
        todo.name.toLowerCase().contains(value.toLowerCase()))
        .toList());

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
        child: Card(
          //color: Colors.white,
            elevation: 0.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                    flex: 6,
                    child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            //isDense: true,
                              icon: Icon(Icons.search),
                              labelText: 'Search...',
                              contentPadding: EdgeInsets.all(0.0),
                              border: InputBorder.none
                          ),
                          onChanged: _onItemChanged,
                          //controller: searchController,
                        ))),
              ],
            )
        )
    );
  }

}