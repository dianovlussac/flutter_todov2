import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todov2/controllers/todo_controller.dart';
import 'package:flutter_todov2/routes.dart';
import 'package:flutter_todov2/utils/shared_prefs.dart';
import 'package:flutter_todov2/widgets/custom_button.dart';
import 'package:flutter_todov2/widgets/custom_search.dart';
import 'package:flutter_todov2/widgets/custom_textfield.dart';
import 'package:flutter_todov2/widgets/loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../models/todo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TASK',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 27,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                        child: ManipulateTodo(),
                      ));
            },
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure want to logout?"),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancel")),
                    ElevatedButton(
                        onPressed: () async {
                          await SharedPrefs().removeUser();
                          Get.offAllNamed(GetRoutes.login);
                        },
                        child: const Text("Confirm")),
                  ],
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<TodoController>(builder: (controller) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomSearch(onChanged: (val) {
                controller.search(val);
              }),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredTodo
                        .map(
                          (todo) => Slidable(
                            child: TodoTile(todo: todo),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    controller.titleController.text =
                                        todo.title!;
                                    controller.descriptionController.text =
                                        todo.description!;
                                    controller.update();
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: ManipulateTodo(
                                                edit: true,
                                                id: todo.id!,
                                              ),
                                            ));
                                  },
                                  backgroundColor:
                                      const Color.fromARGB(255, 52, 65, 252),
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.pencil,
                                  label: "Edit",
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Delete Task?"),
                                              content: Text(
                                                  "Are you sure want to delete this task?"),
                                              actions: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await Get.showOverlay(
                                                          asyncFunction: () =>
                                                              controller
                                                                  .deleteTodo(
                                                                      todo.id),
                                                          loadingWidget:
                                                              const Loader());
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Confirm")),
                                              ],
                                            ));
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.trash,
                                  label: "Delete",
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 175, 174, 174),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            todo.date!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color.fromARGB(255, 185, 178, 178),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            todo.description!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: Color.fromARGB(255, 126, 122, 122),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class ManipulateTodo extends StatelessWidget {
  const ManipulateTodo({Key? key, this.edit = false, this.id = ""})
      : super(key: key);

  final bool edit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<TodoController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${edit ? "Edit" : "Add"} Todo",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              hint: "Title",
              controller: controller.titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: "Description",
              controller: controller.descriptionController,
              maxLines: 5,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                label: edit ? "Edit" : "Add",
                onPressed: () async {
                  if (!edit) {
                    await Get.showOverlay(
                        asyncFunction: () => controller.addTodo(),
                        loadingWidget: const Loader());
                  } else {
                    await Get.showOverlay(
                        asyncFunction: () => controller.editTodo(id),
                        loadingWidget: const Loader());
                  }
                  Navigator.pop(context);
                }),
          ],
        );
      }),
    );
  }
}
