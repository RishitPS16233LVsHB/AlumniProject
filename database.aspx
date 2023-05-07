<?php 
    if(isset($_POST['query'])){
        $conn = mysqli_connect("localhost" , "root","" , "temp");
        // In this below variable we will store firstName values
        $data = array();
        $condition = preg_replace('/[^A-Za-z0-9\-]/' , " " , $_POST['query']);
        $sql = "SELECT firstName from temporary WHERE firstName LIKE '%".$condition."%' ORDER BY DESC LIMIT 10";

        $result = mysqli_query($conn , $sql);

        $replaceString = '<b> ' . $condition . '</b>';
        foreach ($result  as $row) {
            $data[] = array(
                'firstName' => str_ireplace($condition , $replaceString , $row['firstName'])
            );
        }

        echo json_encode(($data));
    }
?>