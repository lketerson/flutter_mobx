import 'package:mobx/mobx.dart';
part 'list_store.g.dart';

class ListStore = ListStoreBase with _$ListStore;

abstract class ListStoreBase with Store {
  @observable
  String todoTitle = "";

  ObservableList<String> todoList = ObservableList<String>();

  @action
  void addTodo() {
    todoList.add(todoTitle);
  }

  @action
  void removeTodo(int index) => todoList.removeAt(index);

  @action
  void setTodoTitle(String value) => todoTitle = value;

  @computed
  bool get isTextValid => todoTitle.isNotEmpty;
}
