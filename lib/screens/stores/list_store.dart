import 'package:gerencia_estado_mobx/screens/stores/todo_store.dart';
import 'package:mobx/mobx.dart';
part 'list_store.g.dart';

class ListStore = ListStoreBase with _$ListStore;

abstract class ListStoreBase with Store {
  @observable
  String todoTitle = "";

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() {
    todoList.insert(0, TodoStore(title: todoTitle));
    todoTitle = '';
  }

  @action
  void removeTodo(int index) => todoList.removeAt(index);

  @action
  void setTodoTitle(String value) => todoTitle = value;

  @computed
  bool get isTextValid => todoTitle.isNotEmpty;
}
