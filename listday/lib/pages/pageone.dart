import 'package:flutter/material.dart';

//arquivos de fora
import 'package:listday/widgets/Item_ListDay.dart';
import 'package:listday/models/date_time_ListDay.dart';

class Listdayapp extends StatefulWidget {
  const Listdayapp({super.key});

  @override
  State<Listdayapp> createState() => _ListdayappState();
}

class _ListdayappState extends State<Listdayapp> {
  // ignore: non_constant_identifier_names
  final TextEditingController ControladorListDay = TextEditingController();

  //Lista com "Todo" Data e Hora, e "Task" que sigfica a lista.
  List<Todo> tasks = [];
  Todo? deletedTodo;
  int? deleteTodoPosition;

  // Recuperar algo apagado

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ROW 1
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ControladorListDay,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 255, 0)),
                          ),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex: Vacinar o cachorro",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: addButton,
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: Color.fromARGB(255, 0, 255, 0),
                        padding: const EdgeInsets.all(13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 10),

                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo task in tasks)
                        //Parametro da outra tela
                        ItemListDay(
                          todo: task,
                          onDelete: onDelete,
                          onEdit: onEdit,
                        ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // ROW 2
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tasks.length == 1
                            ? "Você possui 1 tarefa pendente."
                            : "Você possui ${tasks.length} tarefas pendentes.",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: removeAllButton,
                      style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Color.fromARGB(255, 255, 0, 0),
                          padding: EdgeInsets.all(8.0)),
                      child: Text("Limpar Tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FUNCTIONS

  // MARK: BOTÃO DE ADCIONAR
  void addButton() {
    String text = ControladorListDay.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        Todo newTodo = Todo(
          title: text,
          dateTime: DateTime.now(),
        );

        tasks.add(newTodo);
      });
      ControladorListDay.clear();
    } else {
      // Exibir uma SnackBar informando que o campo está vazio
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira uma tarefa!')),
      );
    }
  }

  // MARK: BOTÃO DE REMOVER TUDO

  void removeAllButton() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Deseja remover tudo ?"),
        content: Text("Ao fazer isso, todas as tarefas serão excluídas!"),
        actions: [
          // Button cancelar removeAllButton
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text("Cancelar"),
          ),

          // Button apagar tudo removeAllButton
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              removeAllButtonTalks();
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text("Limpar Tudo"),
          ),
        ],
      ),
    );
  }

  void removeAllButtonTalks() {
    setState(() {
      tasks.clear();
    });
  }

  // MARK: BOTÃO DE DELETAR

  void onDelete(Todo task) {
    deletedTodo = task;
    deleteTodoPosition = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarefa ${task.title}, foi removida com sucesso!"),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            setState(() {
              tasks.insert(deleteTodoPosition!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // MARK: BOTÃO DE EDITAR AÇÃO
  void onEditTitle(Todo task, String newTitle) {
    setState(() {
      task.title = newTitle;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Modificação concluida!"),
      backgroundColor: Colors.blue,
    ));
  }

  void onEdit(Todo task) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        controller.text = task.title;

        return AlertDialog(
          title: Text("Editar Tarefa"),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onEditTitle(
                    task,
                    controller
                        .text); // Chame a função de edição com o novo título
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
}
