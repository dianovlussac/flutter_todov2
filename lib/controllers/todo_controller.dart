import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todov2/utils/baseurl.dart';
import 'package:flutter_todov2/utils/custom_snackbar.dart';
import 'package:flutter_todov2/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import '../models/user.dart';

class TodoController extends GetxController {
  List<Todo> todos = [];
  List<Todo> filteredTodo = [];

  late TextEditingController titleController, descriptionController;

  @override
  void onInit() {
    super.onInit();
    fetchMyTodos();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    descriptionController.dispose();
  }

  fetchMyTodos() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http
        .post(Uri.parse(baseurl + 'todos.php'), body: {"user_id": user.id});
    var res = await json.decode(response.body);

    if (res['success']) {
      todos = AllTodos.fromJson(res).todo!;
      filteredTodo = AllTodos.fromJson(res).todo!;
      update();
    } else {
      customSnackbar("Error", "Failed to fetch task", "error");
    }
  }

  search(String val) {
    if (val.isEmpty) {
      filteredTodo = todos;
      update();
      return;
    }
    filteredTodo = todos.where((todo) {
      return todo.title!.toLowerCase().contains(val.toLowerCase());
    }).toList();
    update();
  }

  addTodo() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'add_todo.php'), body: {
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionController.text,
    });

    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionController.text = "";
      fetchMyTodos();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  editTodo(id) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'edit_todo.php'), body: {
      "id": id,
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionController.text,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionController.text = "";
      fetchMyTodos();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  deleteTodo(id) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response =
        await http.post(Uri.parse(baseurl + 'delete_todo.php'), body: {
      "id": id,
      "user_id": user.id,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      fetchMyTodos();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }
}
