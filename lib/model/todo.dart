class ToDo {
  final String name;
  final Status status;
  final DateTime dueDate;

  const ToDo(this.name, this.status, this.dueDate);
}

enum Status {
  NEW,
  IN_PROGRESS,
  COMPLETE,
  CANCELLED
}