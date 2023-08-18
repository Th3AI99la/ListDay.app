// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:listday/models/date_time_ListDay.dart';

//CODE:

class ItemListDay extends StatelessWidget {
  const ItemListDay({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
  });

  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  @override
  Widget build(BuildContext context) {
    // Configura o idioma local para português (Brasil)
    initializeDateFormatting('pt_BR', null);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.50, // tamanho da caixa
          children: const [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Arquivar',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.50, // tamanho da caixa
          children: [
            SlidableAction(
              backgroundColor: Color.fromARGB(255, 33, 150, 243),
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              icon: Icons.edit,
              label: 'Editar',
              onPressed: (BuildContext context) {
                 onEdit(todo);
              },
            ),
            SlidableAction(
              backgroundColor: Color.fromARGB(255, 255, 0, 0),
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              icon: Icons.delete,
              label: 'Deletar',
              onPressed: (BuildContext context) {
                onDelete(todo);
              },
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                // DateFormat editável
                DateFormat("dd/MM/yyyy - HH:mm EE", 'pt_BR')
                    .format(todo.dateTime),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
