import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/themes.dart';

import '../model/todo.dart';
const EDITABLE_STATUSES = [Status.CANCELLED, Status.IN_PROGRESS];
class ToDoListWidget extends StatefulWidget {
  final List<ToDo> todos;
  Function onToDoUpdate;
  final Function notifyParent;

  ToDoListWidget({Key? key, required this.todos, required this.notifyParent, required this.onToDoUpdate}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  bool _updatingStatus = false;
  String _currentId = "";

  statusUpdate(data, newStatus) {
    setState(() {
      _updatingStatus = true;
      _currentId = data.id;
    });
    //Implement logic here
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      children: widget.todos.map<Widget>((data) {
        return makeSlidableCard(data);
      }).toList(),
    );
  }

  makeSlidableCard(data) => Card(
    //elevation: 8.0,
    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    child: Container(
      // constraints: const BoxConstraints(
      //   maxHeight: 100.0,
      // ),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: makeStartActionSlideMenu(data),
          ),
          // Specify a key if the Slidable is dismissible.
          //key: ValueKey(data.id),

          // The start action pane is the one at the left or the top side.
          // startActionPane: ActionPane(
          //   // A motion is a widget used to control how the pane animates.
          //   motion: const ScrollMotion(),
          //
          //   // A pane can dismiss the Slidable.
          //   dismissible: DismissiblePane(onDismissed: () {}),
          //
          //   // All actions are defined in the children parameter.
          //   children: [
          //     // A SlidableAction can have an icon and/or a label.
          //     SlidableAction(
          //       onPressed: (context) => logger.i(data),
          //       backgroundColor: Color(0xFFFE4A49),
          //       foregroundColor: Colors.white,
          //       icon: Icons.delete,
          //       label: 'Delete',
          //     ),
          //     SlidableAction(
          //       onPressed: (context) => logger.i(data),
          //       backgroundColor: Color(0xFF21B7CA),
          //       foregroundColor: Colors.white,
          //       icon: Icons.share,
          //       label: 'Share',
          //     ),
          //   ],
          // ),

          // The end action pane is the one at the right or the bottom side.
          // endActionPane: ActionPane(
          //   motion: const ScrollMotion(),
          //   children: makeEndActionSlideMenu(data),
          // ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: makeListTile(data),
        )),
  );

  makeStartActionSlideMenu(data) => <Widget>[
    (Status.NEW == data.status || Status.IN_PROGRESS == data.status)
        ? SlidableAction(
      // An action can be bigger than the others.
      //flex: 2,
      onPressed: (context) => statusUpdate(data, Status.CANCELLED),
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.cancel,
      label: 'Cancel',
    ) : const SizedBox.shrink(),
    (Status.COMPLETE == data.status || Status.CANCELLED == data.status) ?
    SlidableAction(
      onPressed: (context) => null,
      backgroundColor: Colors.grey.shade500,
      foregroundColor: Colors.white,
      icon: Icons.stop,
      label: 'No Action',
    ) : const SizedBox.shrink(),
    data.status == Status.IN_PROGRESS
        ? SlidableAction(
      //flex: 2,
      onPressed: (context) => statusUpdate(data, Status.COMPLETE),
      backgroundColor: const Color(0xFF0392CF),
      foregroundColor: Colors.white,
      icon: Icons.publish,
      label: 'Complete',
    )
        : const SizedBox.shrink(),
  ];

  makeListTile(data) => ListTile(
    title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: FractionallySizedBox(
                widthFactor: 0.95,
                //constraints: const BoxConstraints(maxWidth: 180),
                child: Text(
                  data.name,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      //overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Chip(
              padding: EdgeInsets.all(0),
              backgroundColor: Theme.of(context).primaryColor,
              label: Container(
                width: 100,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    _updatingStatus && (data.id == _currentId)
                        ? SizedBox(
                      child: CircularProgressIndicator(color: Colors.white),
                      height: 10.0,
                      width: 10.0,
                    )
                        : SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        Status.COMPLETE == data.status
                            ? "Completed"
                            : data.status.toString().split('.').last,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10
                        )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                alignment: AlignmentDirectional.center,
              ),
            ),
          )
          // SurveyProgress(
          //     percent: (data.responseCount) / data.partCount,
          //     progressColor: Theme.of(context).primaryColor),
        ]),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    // subtitle: Row(
    //   children: <Widget>[
    //     Icon(Icons.linear_scale, color: Theme.of(context).secondaryHeaderColor),
    //     Text(" Intermediate",
    //         style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
    //   ],
    // ),
    // trailing: Icon(Icons.keyboard_arrow_left,
    //     color: Theme.of(context).secondaryHeaderColor, size: 30.0)
  );

  // makeEndActionSlideMenu(data) => <Widget>[
  //   SlidableAction(
  //     // An action can be bigger than the others.
  //     //flex: 2,
  //     onPressed: (context) => Navigator.push(
  //       context,
  //       MaterialPageRoute<void>(
  //         builder: (BuildContext context) => SurveyDetailsPage(id: data.id),
  //       ),
  //     ),
  //     backgroundColor: const Color(0xFF21B7CA),
  //     foregroundColor: Colors.white,
  //     icon: Icons.info,
  //     label: 'Details',
  //   ),
  //   EDITABLE_STATUSES.contains(data.status)
  //       ? SlidableAction(
  //     //flex: 2,
  //     onPressed: (context) {
  //       logger.i("Edit: ${data}");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => CreateSurveyPage(
  //               notifyParent: widget.notifyParent,
  //               id: data.id,
  //               edit: true,
  //             )),
  //       );
  //     },
  //     backgroundColor: const Color(0xFF0392CF),
  //     foregroundColor: Colors.white,
  //     icon: Icons.edit,
  //     label: 'Edit',
  //   )
  //       : const SizedBox.shrink(),
  // ];

}