import 'package:mobx/mobx.dart';
part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  final String title;

  TodoStoreBase({required this.title});

  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;
}
