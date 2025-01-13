import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerencia_estado_mobx/screens/stores/login_store.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'stores/list_store.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ListStore listStore = ListStore();
  final TextEditingController todoController = TextEditingController();
  late final LoginStore loginStore;
  @override
  void initState() {
    loginStore = Provider.of<LoginStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        loginStore.logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(
                          builder: (_) {
                            return CustomTextField(
                              controller: todoController,
                              hint: 'Tarefa',
                              onChanged: listStore.setTodoTitle,
                              suffix: Visibility(
                                visible: listStore.isTextValid,
                                child: CustomIconButton(
                                  radius: 32,
                                  iconData: Icons.add,
                                  onTap: () {
                                    listStore.addTodo();
                                    todoController.clear();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return ListView.separated(
                                itemCount: listStore.todoList.length,
                                itemBuilder: (_, index) {
                                  final todo = listStore.todoList[index];
                                  return Observer(
                                    builder: (_) {
                                      return ListTile(
                                        title: Text(
                                          'Todo: ${todo.title}',
                                          style: TextStyle(
                                              decoration: todo.done
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              color: todo.done
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                        onTap: todo.toggleDone,
                                        trailing: IconButton(
                                            onPressed: () =>
                                                listStore.removeTodo(index),
                                            icon: const Icon(Icons.delete)),
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return const Divider();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
