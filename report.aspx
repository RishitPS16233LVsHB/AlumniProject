
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description" content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    
    <link rel="canonical" href="https://www.wrappixel.com/templates/materialpro-lite/" />
    <!-- Favicon icon -->
    <title>Admin Dashboard</title>
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">

        <!-- include header file here -->
        <?php require 'header.php'?>


        <!-- include slide navigation file here -->
        <?php require 'aside.php' ?>

        <!-- ============================================================== -->
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-4 align-self-center">
                        <h3 class="page-title mb-0 p-0">Report</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Report</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-md-6 col-8 align-self-center">
                        <form class="form-horizontal form-material " method="get">
                            <div class="form-group">
                                <div class="input-group">

                                    <!-- declaration for first field -->
                                    <select name="location" style="margin-right:10px;">
                                        <?php DisplayPlaceOfWorkInDropDown(); ?>
                                    </select>
                                    <select name="jobtitle" style="margin-right:10px;">
                                        <?php DisplayJobTitleInDropDown(); ?>
                                    </select>
                                    <select name="technology" style="margin-right:10px;">
                                        <?php DisplayTechnologyInDropDown()?>
                                    </select>

                                    <!-- reducong the gap between them to zero -->
                                    <span class="input-group-btn" style="width:10px;"></span>                                    
                                    <input class="btn btn-success  text-white "  name = "search" type = "submit" style="margin-left: 10px;" value="Search">
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
            </div>



            <?php
                if(isset($_GET['search'])){
                        $connection = ConnectToDB();
                        if(!isset($_GET['location']) || empty($_GET['location']))
                            die("location not selected");
                        $query = "select * from tbl_user,tbl_place_of_work where tbl_user.place_of_work_id = tbl_place_of_work.place_of_work_id and tbl_place_of_work.place_of_work_id = ".$_GET['location']."";
                        $Result1 = mysqli_query($connection,$query);
                        CloseConnection($connection);

                        $connection = ConnectToDB();
                        if(!isset($_GET['jobtitle']) || empty($_GET['jobtitle']))
                            die("location not selected");
                        $query = "select * from tbl_user,tbl_job_title where 
                                    tbl_user.job_title_id = tbl_job_title.job_title_id and 
                                    tbl_job_title.job_title_id = ".$_GET['jobtitle']."";
                        $Result2 = mysqli_query($connection,$query);
                        CloseConnection($connection);

                        $connection = ConnectToDB();
                        if(!isset($_GET['technology']) || empty($_GET['technology']))
                            die("location not selected");
                        $query = "select * from tbl_user,tbl_technology,tbl_user_technology where 
                        tbl_user_technology.user_id = tbl_user.user_id and 
                        tbl_user_technology.technology_id = tbl_technology.technology_id and 
                        tbl_user_technology.technology_id = ".$_GET['technology']."";
                        $Result3 = mysqli_query($connection,$query);     
                        CloseConnection($connection); 
                        
                        $connection = ConnectToDB();
                        $query = "select * from tbl_user where user_id in(select user_id from tbl_user_technology where technology_id = ".$_GET['technology'].") and job_title_id = ".$_GET['jobtitle']." and place_of_work_id = ".$_GET['location']."";
                        $Result4 = mysqli_query($connection,$query);     
                        CloseConnection($connection);   
                    
            ?>

            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <div class="row">
                    <!-- column -->
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                            <hr>
                                <h2>User Record as per who matches all three parameters</h2>
                                <!-- <h6 class="card-subtitle">Add class <code>.table</code></h6> -->
                                <div class="table-responsive">                                    
                                    <table class="table user-table">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">Enrollment_No</th>
                                                <th class="border-top-0">UserName</th>
                                                <th class="border-top-0">Email ID</th>
                                                <th class="border-top-0">Contact Number</th>                                                
                                                <th class="border-top-0">Experience</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                                if(mysqli_num_rows($Result4) != 0)
                                                    foreach($Result4 as $rows){
                                            ?>
                                                <tr>
                                                    <td><?php echo $rows['enrollment_number'];?></td>
                                                    <td><?php echo $rows['User_Name'];?></td>
                                                    <td><?php echo $rows['Email_ID'];?></td>                                                    
                                                    <td><?php echo $rows['Contact_Number'];?></td>
                                                    <td><?php echo $rows['Experience'];?></td>
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                                <!-- <h4 class="card-title">User Record</h4> -->
                                <h2>User Record as per Place of work</h2>
                                <!-- <h6 class="card-subtitle">Add class <code>.table</code></h6> -->
                                <div class="table-responsive">                                    
                                    <table class="table user-table">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">Enrollment_No</th>
                                                <th class="border-top-0">UserName</th>
                                                <th class="border-top-0">Email ID</th>
                                                <th class="border-top-0">Contact Number</th>                                                
                                                <th class="border-top-0">Experience</th>  
                                                <th class="border-top-0">Place of Work</th>                                               
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                                if(mysqli_num_rows($Result1) != 0)
                                                    foreach($Result1 as $rows){
                                            ?>
                                                <tr>
                                                    <td><?php echo $rows['enrollment_number'];?></td>
                                                    <td><?php echo $rows['User_Name'];?></td>
                                                    <td><?php echo $rows['Email_ID'];?></td>                                                    
                                                    <td><?php echo $rows['Contact_Number'];?></td>
                                                    <td><?php echo $rows['Experience'];?></td>
                                                    <td><?php echo $rows['Place_Of_Work'];?></td>                                                    
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>

                                <hr>
                                <h2>User Record as per Job Title</h2>
                                <!-- <h6 class="card-subtitle">Add class <code>.table</code></h6> -->
                                <div class="table-responsive">                                    
                                    <table class="table user-table">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">Enrollment_No</th>
                                                <th class="border-top-0">UserName</th>
                                                <th class="border-top-0">Email ID</th>
                                                <th class="border-top-0">Contact Number</th>                                                
                                                <th class="border-top-0">Experience</th>  
                                                <th class="border-top-0">Job title</th>                                                                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                                if(mysqli_num_rows($Result2) != 0)
                                                    foreach($Result2 as $rows){
                                            ?>
                                                <tr>
                                                    <td><?php echo $rows['enrollment_number'];?></td>
                                                    <td><?php echo $rows['User_Name'];?></td>
                                                    <td><?php echo $rows['Email_ID'];?></td>                                                    
                                                    <td><?php echo $rows['Contact_Number'];?></td>
                                                    <td><?php echo $rows['Experience'];?></td>
                                                    <td><?php echo $rows['Job_Title'];?></td>
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>


                                <hr>
                                <h2>User Record as per Technology in use by user</h2>
                                <!-- <h6 class="card-subtitle">Add class <code>.table</code></h6> -->
                                <div class="table-responsive">                                    
                                    <table class="table user-table">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">Enrollment_No</th>
                                                <th class="border-top-0">UserName</th>
                                                <th class="border-top-0">Email ID</th>
                                                <th class="border-top-0">Contact Number</th>                                                
                                                <th class="border-top-0">Experience</th>       
                                                <th class="border-top-0">Technology</th>                                            
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                                if(mysqli_num_rows($Result3) != 0)
                                                    foreach($Result3 as $rows){
                                            ?>
                                                <tr>
                                                    <td><?php echo $rows['enrollment_number'];?></td>
                                                    <td><?php echo $rows['User_Name'];?></td>
                                                    <td><?php echo $rows['Email_ID'];?></td>                                                    
                                                    <td><?php echo $rows['Contact_Number'];?></td>
                                                    <td><?php echo $rows['Experience'];?></td>
                                                    <td><?php echo $rows['Technology_Name'];?></td>
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>


                <div class="col-sm-12 d-flex">
                    <!-- <button class="btn btn-success mx-auto mx-md-0 text-white">Generate
                        Report</button> -->
                </div>
            </div>
                    <?php } ?>

            <!-- include footer file here -->
            <!-- <?php //require 'footer.php' ?> -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="../assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.js"></script>
</body>

</html>