import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_iai/models/task.dart';
import 'package:todo_list_iai/services/task_service.dart';

class AddTaskScreen extends StatefulWidget {
  Task? task = Task(date: DateTime.now(), titre: "", description: "");
  AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // on va creer un variable formKey
  final formKey = GlobalKey<FormState>();
  //ici on va declarer les controller qui vont nous permettre de recuperer les valeurs entrer dans input en declarant de controller
  TextEditingController titleController = TextEditingController();
  TextEditingController desciptionController = TextEditingController();
  // pour le controller de la date il faut initialiser en mettant le date actuel au lancement de la page
  TextEditingController? dateController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.task!.titre;
    desciptionController.text = widget.task!.description;
    dateController = TextEditingController(text: widget.task!.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AJOUTER UN TASK"),
        //centerttitle pour centrer le text au centre de appbar
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // le widget Form va nous permettre de faire la validation du formulaire
          child: Form(
            // la variable formKey qu'on a declarer on affecte au form
            key: formKey,
            child: Column(
              children: [
                // le widget pour le champ titre ici c'est un TextFormField par ce que c'est dans un widget Form
                TextFormField(
                    // ici maintenant il faut affecter les controller
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: "Titre du task",
                    ),
                    // on va afficher les messages d'erreur dans le ça d'un champ vide
                    validator: (value) {
                      // dans le cas où le champ title est vide on retourne ce message
                      if (value!.isEmpty) {
                        return "Le titre est requit";
                      }
                      return null;
                    }),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: desciptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: "Description du task",
                    ),
                    validator: (value) {
                      // dans le cas où le champ title est vide on retourne ce message
                      if (value!.isEmpty) {
                        return "La description est requit";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                // le widget pour la date pour ça on va utiliser unn package pour le champ date donc il faut allez sur pub.dev et chercher Date_time_picker
                DateTimePicker(
                  // controller: dateController,
                  decoration: InputDecoration(
                      labelText: "Date du task",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),

                const SizedBox(
                  height: 20,
                ),
                // le widget Align pour aligner un element
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.redAccent),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          // lors qu'on va clicker sur le button on va s'assurer que tous les champs sont entré
                          // pour ça il faut utiliser le code suivant
                          // avec la cle du formualire on va utiliser pour la validation

                          // if (formKey.currentState!.validate()) {
                          //   // print("formulaire valider");
                          //   Task task = Task(
                          //       titre: titleController.text,
                          //       description: desciptionController.text,
                          //       date: DateTime.now());

                          //   // print("title : ${task.titre}");
                          //   TaskService.saveTask(task);
                          Navigator.of(context).pop();
                          // } else {}
                        },
                        child: const Text("ANNULER")),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blueAccent),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          // lors qu'on va clicker sur le button on va s'assurer que tous les champs sont entré
                          // pour ça il faut utiliser le code suivant
                          // avec la cle du formualire on va utiliser pour la validation

                          if (formKey.currentState!.validate()) {
                            // print("formulaire valider");
                            Task task = Task(
                                titre: titleController.text,
                                description: desciptionController.text,
                                date: DateTime.now());

                            // print("title : ${task.titre}");
                            TaskService.saveTask(task);
                            Navigator.of(context).pop();
                          } else {}
                        },
                        child: widget.task == null
                            ? const Text("AJOUTER")
                            : const Text("MODIFIER")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
