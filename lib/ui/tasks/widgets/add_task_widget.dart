import 'package:app_tasks_challenge/domain/models/task.dart';
import 'package:app_tasks_challenge/ui/tasks/viewmodels/tasks_viewmodel.dart';
import 'package:flutter/material.dart';

class AddTaskWidget extends StatefulWidget {
  final TasksViewModel viewModel;
  const AddTaskWidget({
    super.key,
    required this.viewModel,
  });

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();

  final SizedBox verticalGap = const SizedBox(
    height: 16,
  );

  @override
  void initState() {
    widget.viewModel.addTask.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.viewModel.addTask.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const IntrinsicHeight(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else {
      if (widget.viewModel.addTask.completed) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Tarefa adicionada com sucesso!'),
          ),
        );
      }
      if (widget.viewModel.addTask.completed) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao adicionar a tarefa.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    widget.viewModel.addTask.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(
                children: [Text('Adicione uma nova tarefa.')],
              ),
              verticalGap,
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Digite o título',
                  border: OutlineInputBorder(),
                  label: Text('Título'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              verticalGap,
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'add note...',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição.';
                  }
                  return null;
                },
              ),
              verticalGap,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var task = Task(
                      title: nameController.text,
                      description: nameController.text,
                    );
                    widget.viewModel.addTask.execute(task);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
