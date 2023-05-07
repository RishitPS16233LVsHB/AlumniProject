<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddData.aspx.cs" Inherits="AlumniProject.AdminPanel.html.scss.AddData" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Security.Cryptography" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<%@Import Namespace="System.Net.Mail"%>
    <%  
        MySqlConnection ConnectToDB()
        {
            try
            {
                string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";
                MySqlConnection connection = new MySqlConnection(ConnectionString);
                return connection;
            }
            catch (Exception error)
            {
                return null;
            }
        }

        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "";

            if (Request["submit1"] != null)
            {
                Query = "insert into tbl_place_of_work(place_of_work,created_by,modified_by)values('" + Request["place_of_work"] + "',2,2)";
                MySqlCommand command = new MySqlCommand(Query, connection);
                command.ExecuteNonQuery();
            }
            else if (Request["submit2"] != null)
            {
                Query = "insert into tbl_technology(technology_name,created_by,modified_by)values('" + Request["technology"] + "',2,2)";
                MySqlCommand command = new MySqlCommand(Query, connection);
                command.ExecuteNonQuery();
            }
            else if (Request["submit3"] != null)
            {
                Query = "insert into tbl_job_title(job_title,created_by,modified_by)values('" + Request["job_title"] + "',2,2)";
                MySqlCommand command = new MySqlCommand(Query, connection);
                command.ExecuteNonQuery();
            }
            else if (Request["submit4"] != null)
            {
                Query = "insert into tbl_batch(batch_name,created_by,modified_by)values('" + Request["batch"] + "',2,2)";
                MySqlCommand command = new MySqlCommand(Query, connection);
                command.ExecuteNonQuery();
            }

            connection.Close();
        }
        catch (Exception error) { }
    %>

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
    <title>Material Pro Lite Template by WrapPixel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/materialpro-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/postActions.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <!-- #Include file="header.aspx"-->
        <!-- #Include file="aside.aspx"-->
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-8 align-self-center">
                        <h3 class="page-title mb-0 p-0">Add Data</h3>
                    </div>
                    <div class="col-md-6 col-4 align-self-center">

                    </div>
                </div>

            </div>
            <!-- =========================================================== -->
            <div class="container-fluid">
                <!-- ============================= -->
                <!-- ===================================-->
                <form class="form-horizontal form-material mx-2" method="post" action="#">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" runat="server" id="place_of_work" placeholder="Location here" class="form-control ps-0 form-control-line" name = "subject">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit1" runat="server" value="Add Location">
                        </div>
                    </div>
                </form>

                <form class="form-horizontal form-material mx-2" method="post" action="#">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" runat="server" id="technology" placeholder="Tech name here" class="form-control ps-0 form-control-line" name = "subject">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit2" runat="server" value="Add Technology">
                        </div>
                    </div>
                </form>


                <form class="form-horizontal form-material mx-2" method="post" action="#">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" runat="server" id="job_title" placeholder="Designation here" class="form-control ps-0 form-control-line" name = "subject">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit3" runat="server" value="Add Designation">
                        </div>
                    </div>
                </form>
                
                <form class="form-horizontal form-material mx-2" method="post" action="#">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" runat="server" id="batch" placeholder="batch name here" class="form-control ps-0 form-control-line" name = "subject">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit4" runat="server" value="Add Batch">
                        </div>
                    </div>
                </form>

            </div>
            <!-- ============================================================== -->
            <!-- #Include file="footer.aspx" -->
        </div>
    </div>

    <script>

    </script>
    <script src="../assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!-- google maps api -->
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="../assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="../assets/plugins/gmaps/jquery.gmaps.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.js"></script>

</body>

</html>