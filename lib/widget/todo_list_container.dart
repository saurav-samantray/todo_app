import 'dart:core';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widget/todo_list_filter.dart';
import 'package:todo_app/widget/todo_list_widget.dart';

import '../main.dart';
import '../utils/user_preferences.dart';

class ToDoListContainer extends StatefulWidget {

  final Function notifyParent;

  const ToDoListContainer({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoListContainerState();
  
}

class _ToDoListContainerState extends State<ToDoListContainer> {
  List<ToDo> todos = UserPreferences.initialTodos;
  List<ToDo> filtered = UserPreferences.initialTodos;
  void _onSearch(List<ToDo> td) {
    log.d("Updated List $td");
    setState(() {
      filtered = td;
    });
  }

  void _onToDoUpdate(List<ToDo> updatedToDos) {
    setState(() {
      todos = updatedToDos;
      filtered = updatedToDos;
    });
    //logger.i("Current selection: ${widget.selectedFilters} and survey items ${widget.filteredSurveys}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
          ToDoListFilterWidget(
            todos: todos,
            filteredToDos: filtered,
            onSearch: _onSearch,
          ),
          Expanded(
            child: ToDoListWidget(
              todos: filtered,
              onToDoUpdate: _onToDoUpdate,
              notifyParent: widget.notifyParent,
            ),
          )
        ],
      ),
    );
  }
  
}