<?php 
    function ConnectToDB()
    {
        $user = "root";
        $pass = "root";
        $server = "localhost";
        $database = "Student_verse_Database";

            $connection = mysqli_connect($server,$user,$pass,$database);
            if($connection)
            {
                //echo "connected<br>";
                return $connection;
            }
            else{
                die("failed to connect to database");
            }
    }
    function CloseConnection($connection)
    {
        if($connection)
        {
            mysqli_close($connection);
            //echo "disconnected";
        }
        else
            echo "connection is null";  
    }


    $connection = ConnectToDB();
    // group table maa group name and group id che
    $query = "select * from tbl group_table";
    $result = mysqli_query($connection,$query);    
    CloseConnection($connection);

    if(mysqli_num_rows($result))
    {
        foreach($result as $rows){
?>
    <!-- Group_Chats.php ae ae php file che jema taara particular group chats render thase -->
            <a href = "Group_Chats.php?Chat_ID =<?php echo $rows['group_id'];?>"> <?php echo $rows['group_name'];?></a>
<?php } ?>

