<?php

header("Access-Control-Allow-Origin: *");
include './connection.php';

if (isset($_POST['id']) && isset($_POST['user_id'])) {

    $id = $_POST['id'];
    $userId = $_POST['user_id'];

    $sql = "DELETE FROM todos WHERE id = '$id' and user_id = '$userId'";
    $result = mysqli_query($conn, $sql);

    if ($result){
        $data = [
            'success' => true,
            'message' => 'Task deleted Successfully'
        ];
    } else {
        $data = [
            'success' => false,
            'message' => 'Task deleting failed'
        ];
    }
    echo json_encode($data);
} else {
    $data = [
        'success' => false,
        'message' => 'Something Wrong Here!'
    ];
    echo json_encode($data);
}