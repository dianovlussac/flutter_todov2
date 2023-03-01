<?php

header("Access-Control-Allow-Origin: *");
include './connection.php';

if (isset($_POST['user_id']) && isset($_POST['title']) && isset($_POST['description'])) {

    $userId = $_POST['user_id'];
    $title = $_POST['title'];
    $description = $_POST['description'];
    $date = date('Y-m-d');

    $sql = "INSERT INTO todos (user_id, title, description, date) VALUES ('$userId', '$title', '$description', '$date')";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        $data = [
            'success' => true,
            'message' => 'Task added successfully'
        ];
    } else {
        $data = [
            'success' => false,
            'message' => 'Task adding failed'
        ];
    }
    echo json_encode($data);
} else {
    $data = [
        'success' => false,
        'message' => 'Please fill all the fields'
    ];
    echo json_encode($data);
}