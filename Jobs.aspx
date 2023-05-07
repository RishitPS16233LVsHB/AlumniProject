<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="AlumniProject.Jobs" %>

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

    string trimPath(string Path)
    {
        try
        {
            if (Path != null)
            {
                string[] separatedPath = Path.Split('/');
                string FinalPath = separatedPath[separatedPath.Length - 3] + "/" + separatedPath[separatedPath.Length - 2] + "/" + separatedPath[separatedPath.Length - 1];
                return FinalPath;
            }
            return "";
        }
        catch (Exception error)
        {
            return "";
        }
    }

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    else
    {

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- #include file="Partials/_headerlinks.html"-->

    <link href="HomePage_images/favicon.ico" rel="icon">
    
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <link href="css/HomePage_css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="css/HomePage_css/Jobs.css">

    <style>
        body{
            background-color: rgb(239, 244, 253);
        }
        .scrolltop {
            display: none;
            width: 100%;
            margin: 0 auto;
            position: fixed;
            bottom: 20px;
            right: 10px;
        }

        .scroll {
            position: absolute;
            right: 15px;
            bottom: 40px;
            background: #b2b2b2;
            background: rgba(178, 178, 178, 0.7);
            padding: 20px;
            text-align: center;
            margin: 0 0 0 0;
            cursor: pointer;
            transition: 0.5s;
            -moz-transition: 0.5s;
            -webkit-transition: 0.5s;
            -o-transition: 0.5s;
        }

        .scroll:hover {
            background: rgba(178, 178, 178, 1.0);
            transition: 0.5s;
            cursor: pointer;
            -moz-transition: 0.5s;
            -webkit-transition: 0.5s;
            -o-transition: 0.5s;
        }

        .scroll:hover .fa {
            padding-top: -10px;
        }

        .scroll .fa {
            font-size: 30px;
            margin-top: -5px;
            margin-left: 1px;
            transition: 0.5s;
            -moz-transition: 0.5s;
            -webkit-transition: 0.5s;
            -o-transition: 0.5s;
        }

        /* .btn {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #666565;
            text-align: center;
            vertical-align: middle;
            cursor: pointer;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 2px;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .btn {
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            transition: .5s;
        }

        .btn.btn-primary {
            color: white;
            border: none;
            background-color: #1c3961;
            font-size: large;
        } */
    </style>
</head>

<body>
    <!--#Include file="Partials/_nav.aspx"-->

    <div class="container-fluid py-5" style="background-color: rgb(239, 244, 253);">
        <h1 class="text-center mb-5 wow fadeInUp" data-wow-delay="0.1s">Job Listing</h1>

        <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.3s">
            <div class="tab-content">
                <div id="tab-1" class="tab-pane fade show p-0 active">
                    <% 
                        DataTable JobSet = new DataTable();
                        if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                        {
                            try
                            {
                                int userID = (int)Session["user_id"];
                                MySqlConnection connection = ConnectToDB();
                                connection.Open();
                                string query = "select tbl_job_alert.job_alert_id,                                                 " +
                                                    "tbl_job_title.job_title,                                                      " +
                                                    "tbl_job_alert.company_name,                                                   " +
                                                    "tbl_place_of_work.place_of_work,                                              " +
                                                    "tbl_job_alert.package,                                                        " +
                                                    "tbl_job_alert.date_created,                                                   " +
                                                    "tbl_user.profile_photo_path,                                                  " +
                                                    "tbl_user.user_name,                                                           " +
                                                    "tbl_user.user_id                                                              " +
                                                    "                                                                              " +
                                                    "from tbl_job_alert,tbl_job_title,tbl_place_of_work,tbl_user                   " +
                                                    "where                                                                         " +
                                                    "tbl_job_alert.job_title_id = tbl_job_title.job_title_id and                   " +
                                                    "tbl_job_alert.place_of_work_id = tbl_place_of_work.place_of_work_id and       " +
                                                    "tbl_job_alert.created_by = tbl_user.user_id and                               " +
                                                    "tbl_job_alert.is_enabled = 'y';";

                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                adp.Fill(JobSet);
                                connection.Close();
                            }
                            catch (Exception error)
                            {
                                Response.Write(error.Message);
                            }
                        }
                        else
                            Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                        %>

                    <% foreach (DataRow rows in JobSet.Rows)
                        { %>
                        <div class="job-item p-4 mb-4">
                            <div class="row g-4">                            
                                <div class="col-sm-12 col-md-8 d-flex align-items-center">

                                    <% if (!string.IsNullOrEmpty(rows["profile_photo_path"].ToString()))
                                        {%>
                                        <img class="flex-shrink-0 img-fluid border rounded" src="<%= trimPath(rows["profile_photo_path"].ToString())%>" alt=""  style="width:80px;object-fit:contain; height: 80px;">
                                    <% } %>

                                    <div class="text-start ps-4">
                                        <h2 class="mb-3"><%= rows["job_title"]%></h2>
                                        <h5 class="mb-3"><%= rows["company_name"]%></h5>
                                        <h5 class="mb-3"><b>User name: </b><a href = "OtherUserProfile.aspx?userid=<%= rows["user_id"]%>"><%= rows["user_name"]%></a></h5>
                                        <span class="text-truncate me-3" style="font-size:13px;"><i class="fa fa-map-marker-alt  me-2"></i><%= rows["place_of_work"]%></span>
                                        <span class="text-truncate me-0" style="font-size:13px;"><i class="far fa-money-bill-alt  me-2"></i><%= rows["package"]%></span>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4 d-flex flex-column align-items-start align-items-md-end justify-content-center">
                                    <div class="d-flex mb-3">
                                        <a class="btn btn-primary " href="jobDetails.aspx?job_alert_id=<%= rows["job_alert_id"]%>">See More</a>
                                        <a class="btn btn-primary "  style="margin-left:10px;" href="JobApply.aspx?job_alert_id=<%= rows["job_alert_id"]%>">Apply Now</a>
                                    </div>
                                    <small class="text-truncate " style="font-size:10px;"><i class="far fa-calendar-alt  me-2"></i><%= rows["date_created"]%></small>
                                </div>                            
                            </div>
                        </div>
                    <% } %>
                    <% //require_once 'Partials/footer.aspx' %>
                </div>
               
            </div>                
    <script>
        function jobApply(){
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="css/jobs_css/lib/wow/wow.min.js"></script>
    <script src="css/jobs_css/lib/easing/easing.min.js"></script>
    <script src="css/jobs_css/lib/waypoints/waypoints.min.js"></script>
    <script src="css/jobs_css/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="css/jobs_css/js/main.js"></script>
</body>
</html> <%} %>