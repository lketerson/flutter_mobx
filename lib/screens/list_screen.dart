import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
                              hint: 'Tarefa',
                              onChanged: listStore.setTodoTitle,
                              suffix: Visibility(
                                visible: listStore.isTextValid,
                                child: CustomIconButton(
                                  radius: 32,
                                  iconData: Icons.add,
                                  onTap: listStore.addTodo,
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
                                  return ListTile(
                                    title: Text(
                                      'Todo: ${listStore.todoList[index]}',
                                    ),
                                    onTap: () {},
                                    trailing: IconButton(
                                        onPressed: () =>
                                            listStore.removeTodo(index),
                                        icon: const Icon(Icons.delete)),
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
