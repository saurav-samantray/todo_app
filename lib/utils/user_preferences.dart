
import '../model/todo.dart';
import '../model/user.dart';

class UserPreferences {
  static const cpUser = User(
    imagePath:
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Saurav Samantray',
    email: 'saurav@company.com',
    about:
    'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );

  static List<ToDo> initialTodos = [
    ToDo("shopping", Status.NEW, DateTime.now().add(Duration(days: 5))),
    ToDo("flight ticket", Status.COMPLETE, DateTime.now().subtract(Duration(days: 5))),
    ToDo("sleeping", Status.CANCELLED, DateTime.now().add(Duration(days: 2))),
    ToDo("programing", Status.IN_PROGRESS, DateTime.now().add(Duration(days: 10))),
    ToDo("travelling", Status.COMPLETE, DateTime.now().add(Duration(days: 10))),
  ];
}