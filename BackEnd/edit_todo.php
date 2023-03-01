<?php

header("Access-Control-Allow-Origin: *");
include './connection.php';

if (isset($_POST['id']) && isset($_POST['user_id']) && isset($_POST['title']) && isset($_POST['description'])) {

    $id = $_POST['id'];
    $userId = $_POST['user_id'];
    $title = $_POST['title'];
    $description = $_POST['description'];

    $sql = "UPDATE todos SET title = '$title', description = '$description' WHERE id = '$id' and user_id = '$userId'";
    $result = mysqli_query($conn, $sql);

    if ($result){
        $data = [
            'success' => true,
            'message' => 'Task updated successfully'
        ];
    } else {
        $data = [
            'success' => false,
            'message' => 'Task updating failed'
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