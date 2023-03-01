<?php

header("Access-Control-Allow-Origin: *");
include './connection.php';

if(isset($_POST['name']) && isset($_POST['contact']) && isset($_POST['address']) && isset($_POST['email']) && isset($_POST['password'])){

  $name = $_POST['name'];
  $contact = $_POST['contact'];
  $address = $_POST['address'];
  $email = $_POST['email'];
  $password = password_hash($_POST['password'], PASSWORD_DEFAULT);


  $checkSql = "SELECT * from users where email = '$email'";
  $checkResult = mysqli_query($conn, $checkSql);
  
  if($checkResult->num_rows >0){
    $data = [
        'success' => false,
        'message' => 'Email already used!'
    ];
    echo json_encode($data);
  } else {  
  $sql = "INSERT INTO users (name, contact, address, email, password) VALUES ('$name', '$contact', '$address', '$email', '$password')";

    if (mysqli_query($conn, $sql)) {
        $data = [
            'success' => true,
            'message' => 'Sign up Successful'
        ];
    } else {
        $data = [
            'success' => false,
            'message' => 'Sign up Failed'
        ];
    }
    echo json_encode($data);
  } 
}