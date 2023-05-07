<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="AlumniProject.profile" %>

<!DOCTYPE html>
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
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/all.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/lightbox.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/flexslider.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/jquery.rateyo.css" />
    <link rel="stylesheet" type="text/css" href="inner-page-style.css">
    <link rel="stylesheet" type="text/css" href="HomePage_style.css">
    <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/HomePage_css/johndoe.css">
    <title>Document</title>
    <style>
        body{
            background-color: rgb(239, 244, 253);
        }
        .btn-primary {
        color: #fff;
        background-color: #1c3961;
        border-color:1 px solid #fff;
        border-radius:10px;
        font-size:medium;
    }

    .btn-primary {
    color: #fff;
    background-color: #1c3961;
    border-color: #fff;
}

.btn-primary:hover {
        color: #1c3961;
        background-color: transparent;
        border-color:1 px solid #1c3961;
        border-radius:10px;
        font-size:medium;
    }
    .btn-primary:hover {
        color: #1c3961;
        background-color: transparent;
        border-color: 2px solid #1c3961;
        border-radius:10px;
}
.nav-pills .nav-link {
        border-radius: 0.25rem;
        font-size: large;
        }
        a {
            margin-top:3px;
        color: #1c3961;
        text-decoration: none;
        background-color: transparent;
        }
        a:visited{
            color:#1c3961;
        }
        a:hover{
            color:#1c3961;
        }
        .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
        color: #fff;
        /* background-color: #F85C70; */
        border: 1px solid #fff;
        margin-top:10px;
        background-color: #1c3961;
        background-color: none;
        border-radius:10px;
        }
    
    </style>
</head>

<body>
    <header class="site-header" style="background-color: white;">
        <div class="top-header">
            <div class="container">
                <div class="top-header-left">
                    <div class="top-header-block">
                        <a href="mailto:info@educationpro.com" itemprop="email"><i class="fas fa-envelope"></i>
                            bmiit.utu.ac.in</a>
                    </div>
                    <div class="top-header-block">
                        <a href="tel:+91 2622 290562" itemprop="telephone"><i class="fas fa-phone"></i> +91 2622
                            290562</a>
                    </div>
                </div>
                <div class="top-header-right">
                    
                    <div class="login-block">
                        <a href="LogoutSession.aspx" id="logOut">Log Out</a>
                        <span style="color : white">|</span>
                        <a href="settings.aspx">Settings</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Top header Close -->
        <div class="main-header">
            <div class="container">
                <div class="logo-wrap" itemprop="logo">

                </div>
                <div class="nav-wrap">
                    <nav class="nav-desktop">
                        <ul class="menu-list">
                            <li><a href="homePage.aspx">Home</a></li>
                            <%if (Convert.ToInt32(Session["user_type"]) == 1)
                                { %>
                                <li class="menu-parent">Create Post
                                    <ul class="sub-menu">
                                        <li><a href="CreatePosts.aspx">Create Post</a></li>
                                        <li><a href="CreateEvent.aspx">Create Event</a></li>
                                        <li><a href="CreateJobAlert.aspx">Create Jobs</a></li>
                                    </ul>
                                </li>
                            <%} %>
                            <li><a href="Posts.aspx">Posts</a></li>
                            <li><a href="Jobs.aspx">Jobs</a></li>
                            <li><a href="Events.aspx">Events</a></li>
                            <li><a href="OriginalChat.aspx">Chats</a></li>
                            <li><a href="profile.aspx"><%= Session["MY_USER_NAME_AND_IT_IS_FINAL"].ToString() %></a></li>
                        </ul>
                    </nav>
                    <div id="bar">
                        <i class="fas fa-bars"></i>
                    </div>
                    <div id="close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="container-fluid">
        <div class="container" style="background-color: rgb(239, 244, 253);">
        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Personal Info</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Achievements</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Experience</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-events-tab" data-toggle="pill" href="#pills-events" role="tab" aria-controls="pills-events" aria-selected="false">Events</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-posts-tab" data-toggle="pill" href="#pills-posts" role="tab" aria-controls="pills-posts" aria-selected="false">Posts</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-eventsP-tab" data-toggle="pill" href="#pills-eventsP" role="tab" aria-controls="pills-eventsP" aria-selected="false">Events Participation</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-jobAlert-tab" data-toggle="pill" href="#pills-jobAlert" role="tab" aria-controls="pills-jobAlert" aria-selected="false">Job Alerts</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-appliedJob-tab" data-toggle="pill" href="#pills-appliedJob" role="tab" aria-controls="pills-appliedJob" aria-selected="false">Applied Jobs</a>
            </li>
        </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <div class="card-body pb-2">
                            <%
                                DataRow GetUserData()
                                {
                                    try
                                    {
                                        if (Session["user_id"] != null && (int)Session["user_id"] != -1)
                                        {
                                            int userID = Convert.ToInt32(Session["user_id"]);
                                            Response.Write(userID);
                                            MySqlConnection connection = ConnectToDB();
                                            connection.Open();
                                            string query = "select tbl_user.enrollment_number," +
                                                            "tbl_user.user_name," +
                                                            "tbl_user.gender," +
                                                            "tbl_user.profile_photo_path," +
                                                            "tbl_user.contact_number," +
                                                            "tbl_user.email_id," +
                                                            "tbl_user.date_of_birth," +
                                                            "tbl_user.experience," +
                                                            "tbl_user.current_company_working_in," +
                                                            "tbl_batch.batch_name," +
                                                            "tbl_job_title.job_title," +
                                                            "tbl_place_of_work.place_of_work" +
                                                            " from tbl_user,tbl_batch,tbl_place_of_work,tbl_job_title " +
                                                            " where " +
                                                                "tbl_user.user_id = " + userID + " and " +
                                                                "tbl_user.batch_id = tbl_batch.batch_id and " +
                                                                "tbl_user.place_of_work_id = tbl_place_of_work.place_of_work_id and " +
                                                                "tbl_user.job_title_id = tbl_job_title.job_title_id and " +
                                                                "tbl_user.is_enabled = 'y';";

                                            //Response.Write("<br><br>"+query+"<br><br>");
                                            MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                            DataTable ResultTable = new DataTable();
                                            adp.Fill(ResultTable);
                                            DataRow row = ResultTable.Rows[0];
                                            connection.Close();
                                            return row;
                                        }
                                        else
                                        {
                                            Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                            return null;
                                        }
                                    }
                                    catch (Exception error)
                                    {
                                        Response.Write(error.Message);
                                        return null;
                                    }
                                }
                                %>
                                <ul class="mt40 info list-unstyled">

                                <% DataRow UserRow = GetUserData(); %>
                                <%
                                    if (!string.IsNullOrEmpty(UserRow["profile_photo_path"].ToString()))
                                    {
                                        string FinalPath = trimPath(UserRow["profile_photo_path"].ToString());
                                        Response.Write("<li><img class=\"flex-shrink-0 img-fluid border rounded\" src=" + FinalPath + " alt=\"\" style=\"width:auto; height:auto;\"></li>");
                                    }
                                %>

                                <li><span class="details">Enrollment Number</span> : <%=UserRow["enrollment_number"]%></li>
                                <li><span class="details">User Name</span> : <%=UserRow["user_name"]%></li>
                                <li><span class="details">Gender</span> :
                                    <% if (UserRow["gender"].ToString() == "f") Response.Write("female"); else Response.Write("male"); %></li>
                                <li><span class="details">Contact Number</span> : <%=UserRow["contact_number"]%></li>
                                <li><span class="details">Email Address</span> : <%=UserRow["email_id"]%></li>
                                <li><span class="details">Date of birth</span> :<%=UserRow["date_of_birth"].ToString().Split(' ')[0]%></ li>
                                <li><span class="details">Experience</span> : <%=UserRow["experience"]%> </li>
                                <li><span class="details">Current Company</span> :<%=UserRow["current_company_working_in"]%></li>
                                <li><span class="details">Designation</span> : <%=UserRow["job_title"]%></li>
                                <li><span class="details">Place of Work</span> : <%=UserRow["place_of_work"]%></li>
                                <li><span class="details">Batch</span> : <%=UserRow["batch_name"]%></li>
                                <li><span class="details">technologies known:</span> : 
                                    <%
                                        if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                                        {
                                            MySqlConnection connection = ConnectToDB();
                                            connection.Open();
                                            string query = "select distinct technology_name from tbl_technology where technology_id in(select technology_id from tbl_user_technology where user_id = " + Session["user_id"].ToString() + ")";
                                            MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                            DataTable techSet = new DataTable();
                                            adp.Fill(techSet);
                                            foreach (DataRow r in techSet.Rows)
                                                Response.Write(r["technology_name"].ToString() + " ");
                                        }
                                    %></li>
                            </ul>
                            <hr>
                            <% 
                                DataTable GetUserExperience()
                                {
                                    try
                                    {
                                        if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                                        {
                                            int userID = (int)Session["user_id"];
                                            MySqlConnection connection = ConnectToDB();
                                            string query = "select * from tbl_user_experience where user_id = " + userID + " and is_enabled = 'y'";
                                            MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                            DataTable RSet = new DataTable();
                                            adp.Fill(RSet);
                                            connection.Close();
                                            if (RSet.Rows.Count == 0)
                                            {
                                                Response.Write("It seems like you have not shared your experiences with us!!");
                                                return null;
                                            }
                                            return RSet;
                                        }
                                        else
                                        {
                                            Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                            return null;
                                        }
                                    }
                                    catch (Exception error)
                                    {
                                        Response.Write(error.Message);
                                        return null;
                                    }
                                }
                                DataTable ResultSet = GetUserExperience();
                                if (ResultSet != null)
                                {
                                    Response.Write(ResultSet.Rows.Count);
                                    foreach (DataRow row in ResultSet.Rows)
                                    {
                                        if (DateTime.Parse(row["start_date"].ToString()).Year != DateTime.Parse(row["end_date"].ToString()).Year)
                                            Response.Write("<h3><b>" + DateTime.Parse(row["start_date"].ToString()).Year + "-" + DateTime.Parse(row["end_date"].ToString()).Year + "</h3></b>");
                                        else
                                            Response.Write("<h3><b>" + DateTime.Parse(row["start_date"].ToString()).Year);

                                        Response.Write("<br>");
                                        Response.Write("<h5><b>" + row["experience_title"] + "</b></h5>");
                                        Response.Write("<br>");
                                        Response.Write("<h6>" + row["experience_description"] + "</h6>");
                                        Response.Write("<hr>");

                                %>
                                <%  }
                                    }  %>
                        </div>
                </div>
                <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                <div class="card-body">
                            <!--  connection and fetch code here-->
                            <%
                                DataTable GetUserAchievementInfo()
                                {
                                    try
                                    {
                                        if (Session["user_id"] != null && (int)Session["user_id"] != -1)
                                        {
                                            int userID = Convert.ToInt32(Session["user_id"]);
                                            MySqlConnection connection = ConnectToDB();
                                            connection.Open();
                                            string query = "select * from tbl_user_achievement where user_id = " + userID + " and is_enabled = 'y'";
                                            MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                            DataTable resultSet = new DataTable();
                                            adp.Fill(resultSet);
                                            connection.Close();

                                            if (resultSet.Rows.Count == 0)
                                            {
                                                Response.Write("It seems like you have not shared your achievment with us!!");
                                                return null;
                                            }
                                            else
                                                return resultSet;
                                        }
                                        else
                                        {
                                            Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                            return null;
                                        }
                                    }
                                    catch (Exception error) { Response.Write(error.Message); return null; }
                                }
                            %>

                            <% 
                                DataTable result = GetUserAchievementInfo();
                                if (result != null)
                                {
                                    foreach (DataRow achievment_row in result.Rows)
                                    {
                                        //if (achievment_row["certificate_path"] != null && achievment_row["certificate_path"].ToString() != "")
                                        //{
                                        //    string FinalPath = trimPath(achievment_row["certificate_path"].ToString());
                                        //    Response.Write("<img src=" + FinalPath + " alt=\"your certificate or photo was here!!!\" style=\"width: 220px; height: 200px; margin: 3px 0px 10px 0px;\">");
                                        //}

                                        Response.Write("<h1 style=\"text-transform:capitalize;\">" + achievment_row["achievement_title"] + "</h1>");
                                        Response.Write("<P class=\"subtitle\">" + achievment_row["Achievement_Description"] + "</P>");
                                        Response.Write("<h6 class=\"title\" style=\"float:right;color:grey; font-family: Source Sans Pro, sans-serif; font-weight: 600;\"> In year : " + DateTime.Parse(achievment_row["achievement_date"].ToString()).Year.ToString() + "</h6><hr>");
                                    }
                                }
                            %>   

                            </div>
                        </div>
                <%--<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                <div class="card-body">

                    </div>
                </div>--%>


                <div class="tab-pane fade" id="pills-events" role="tabpanel" aria-labelledby="pills-events-tab">
                <div class="card-body">
                    <%
                        DataTable GetUserEvents()
                        {
                            try
                            {
                                if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                                {

                                    int userID = (int)Session["user_id"];
                                    MySqlConnection connection = ConnectToDB();
                                    string query = "select " +
                                                            "tbl_event.event_id, " +
                                                            "tbl_event.event_name, " +
                                                            "tbl_event.event_photo, " +
                                                            "tbl_event.event_description, " +
                                                            "tbl_event.venue, " +
                                                            "tbl_event.upload_time, " +
                                                            "tbl_event.event_time, " +
                                                            "tbl_event.organizer_name, " +
                                                            "tbl_user.profile_photo_path, " +
                                                            "tbl_user.user_name, " +
                                                            "tbl_event.organizing_member_id " +
                                                            "from tbl_event,tbl_user " +
                                                            "where " +
                                                            "tbl_user.user_id = tbl_event.organizing_member_id and " +
                                                            "tbl_event.organizing_member_id = " + userID + " and " +
                                                            "tbl_event.is_enabled = 'y';";

                                    MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                    DataTable User_post_result = new DataTable();
                                    adp.Fill(User_post_result);
                                    return User_post_result;
                                }
                                else
                                {
                                    Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                    return null;
                                }
                            }
                            catch (Exception error)
                            {
                                Response.Write(error.Message);
                                return null;
                            }
                        }
                    %>
                    <% 
                        DataTable eventResult = GetUserEvents();

                        if (eventResult.Rows.Count == 0)
                            Response.Write("no event organized by you perhaps add one..");
                        else
                        {
                            try
                            {
                                if (eventResult != null)
                                {
                                    foreach (DataRow row in eventResult.Rows)
                                    {

                                        MySqlConnection connection = ConnectToDB();
                                        string query = "select tbl_user.user_id , tbl_user.user_name  from tbl_user,tbl_event_participation where  tbl_user.user_id = tbl_event_participation.participant_id and tbl_event_participation.event_id = " + row["event_id"] + " and tbl_event_participation.is_enabled = 'y'";
                                        MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                        DataTable participationResult = new DataTable();
                                        adp.Fill(participationResult);
                                        connection.Close();

                                        Response.Write("<div class=\"row g-4\">");
                                        Response.Write("<div class=\"col-sm-12 col-md-8 d-flex align-items-center\">");
                                        Response.Write("<div class=\"text-start ps-4\">");
                                        Response.Write("<h1 class=\"mb-3\" style=\"margin-left : 10px;\"><b>" + row["event_name"] + "</b></h1><br>");
                                        Response.Write("<h5 class=\"mb-3\" style=\"margin-left : 10px;\">Organized by: " + row["organizer_name"] + "</h5><br>");
                                        Response.Write("<h5 class=\"mb-3\" style=\"margin-left : 10px;\">Total Participation:" + participationResult.Rows.Count + "<br>");
                                        Response.Write("</div></div>");


                                        Response.Write("<div class=\"col-sm-12 col-md-4 d-flex flex-column align-items-start align-items-md-end justify-content-center\">");
                                        Response.Write("<span class=\"text-truncate me-3\" style=\"font-size:13px;\">Venue:<b>" + row["venue"] + "</b></span><br>");
                                        Response.Write("<span class=\"text-truncate me-0\" style=\"font-size:13px;\">Event Time:<b>" + row["event_time"] + "</b></span><br>");
                                        Response.Write("<br><a class=\"btn btn-primary\" href=\"RemoveEvent.aspx?event_id=" + row["event_id"] + "\" style=\"margin-top : 10px;\">Remove Event</a></div>");

                                        Response.Write("<div class=\"LargerDiv\">");
                                        Response.Write("<h5 style=\"text-align:left; margin-left: 15px;padding-left:10px;padding-right:10px;\">" + row["event_description"] + "</h5>");
                                        if (!string.IsNullOrEmpty(row["event_photo"].ToString()))
                                            Response.Write("<img class=\"flex-shrink-0 img-fluid border rounded\" src=\"" + trimPath(row["event_photo"].ToString()) + "\" style=\"width: 220px; height: 250px; margin: 10px 0px 10px 20px;\">");
                                        Response.Write("</div></div></div>");
                                        foreach (DataRow row1 in participationResult.Rows)
                                            Response.Write("<a class=\"btn btn-primary username\" style=\"font-size:large;cursor:pointer\" href=\"OtherUserProfile.aspx?userid=" + row1["user_id"] + "\">" + row1["user_name"] + "</a><br>");
                                    }
                                }
                            }
                            catch (Exception error)
                            {
                                Response.Write(error.Message);
                            }
                        }
                        %>                                             
                </div>
                </div>

                <!-- Post Section -->
                <div class="tab-pane fade" id="pills-posts" role="tabpanel" aria-labelledby="pills-posts-tab">
                <div class="card-body">
                <%
                    DataTable GetUserPost()
                    {
                        try
                        {
                            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                            {

                                int userID = (int)Session["user_id"];
                                MySqlConnection connection = ConnectToDB();
                                string query = "select " +
                                                "tbl_user.user_name, " +
                                                "tbl_user.profile_photo_path, " +
                                                "tbl_community_post.community_post_id, " +
                                                "tbl_community_post.post_title, " +
                                                "tbl_community_post.content, " +
                                                "tbl_community_post.post_image, " +
                                                "tbl_community_post.upload_time " +
                                                    "from tbl_user,tbl_community_post " +
                                                    "where " +
                                                        "tbl_user.user_id = tbl_community_post.user_id and " +
                                                        "tbl_community_post.is_enabled = 'y' and " +
                                                        "tbl_user.user_id = " + userID + " " +
                                                            "order by tbl_community_post.upload_time desc;";
                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                DataTable User_post_result = new DataTable();
                                adp.Fill(User_post_result);
                                return User_post_result;
                            }
                            else
                            {
                                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                return null;
                            }
                        }
                        catch (Exception error)
                        {
                            Response.Write(error.Message);
                            return null;
                        }
                    }
                %>

                <div class="col-md-6 col-lg-12 ">            
                        <div class="container">
                             <hr style="height:2px"> 
                <% 
                    DataTable userPostResult = GetUserPost();
                    if (userPostResult != null)
                    {
                        foreach (DataRow row in userPostResult.Rows)
                        {
                            Response.Write("<div class=\"card-body postcardBody\" style=\"width:100%\">");
                            if (!string.IsNullOrEmpty(row["post_image"].ToString()))
                                Response.Write("<img src = \"" + trimPath(row["post_image"].ToString()) + "\"alt=\"your certificate or photo was here!\" style=\"object-fit:contain;width: 220px; height: 250px;margin-bottom:0px;\">");
                            Response.Write("<b><h2 style = \"font-size:x-large;font-weight:bolder;\">" + row["post_title"] + "</h2></b>");
                            Response.Write("<P class=\"subtitle\"> " + row["content"] + "</P>");
                            Response.Write("<span><p class=\"title\" style=\"float:right;font-size:small;color:grey; font-family: Source Sans Pro, sans-serif;font-weight\">" + row["upload_time"] + "</p></span><br>");
                            Response.Write("<a class=\"btn btn-primary username\" style=\"font-size:large;cursor:pointer\" href=RemovePost.aspx?community_post_id=" + row["community_post_id"] + ">Remove Post</a>");
                            Response.Write("</div><br><hr style=\"height:2px\">");
                        }
                    }
                    else
                        Response.Write("you have not made any posts!");
                %>
                </div>
                </div>

                <!-- ends here -->
                <!-- Events participation -->
                <div class="tab-pane fade" id="pills-eventsP" role="tabpanel" aria-labelledby="pills-eventsP-tab">
                <div class="card-body">
                <%
                    DataTable GetUserEventParticipation()
                    {
                        try
                        {
                            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                            {

                                int userID = (int)Session["user_id"];
                                MySqlConnection connection = ConnectToDB();
                                string query = "select                                                                       " +
                                                    "tbl_event.event_id,                                                     " +
                                                    "tbl_event.event_name,                                                   " +
                                                    "tbl_event.event_photo,                                                  " +
                                                    "tbl_event.event_description,                                            " +
                                                    "tbl_event_participation.event_participation_id,                         " +
                                                    "tbl_event.venue,                                                        " +
                                                    "tbl_event.upload_time,                                                  " +
                                                    "tbl_event.event_time,                                                   " +
                                                    "tbl_event.organizer_name,                                               " +
                                                    "tbl_user.profile_photo_path,                                            " +
                                                    "tbl_user.user_name,                                                     " +
                                                    "tbl_event.organizing_member_id                                          " +
                                                    "from tbl_event,tbl_user,tbl_event_participation                         " +
                                                    "where                                                                   " +
                                                    "tbl_event_participation.participant_id = " + userID + " and             " +
                                                    "tbl_event_participation.event_id = tbl_event.event_id and               " +
                                                    "tbl_event_participation.is_enabled = 'y' and                            " +
                                                    "tbl_event.is_enabled = 'y' and                                          " +
                                                    "tbl_event_participation.participant_id = tbl_user.user_id               " +
                                                    ";";


                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                DataTable User_post_result = new DataTable();
                                adp.Fill(User_post_result);
                                return User_post_result;
                            }
                            else
                            {
                                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                return null;
                            }
                        }
                        catch (Exception error)
                        {
                            Response.Write(error.Message);
                            return null;
                        }
                    }
                    %>

                    <%  
                        DataTable userEventParticipationTable = GetUserEventParticipation();
                        if (userEventParticipationTable != null)
                        {
                            foreach (DataRow row in userEventParticipationTable.Rows)
                            {
                    %>                               
                                <div class="row g-4">
                                    <div class="col-sm-12 col-md-8 d-flex align-items-center">
                                        <div class="text-start ps-4">
                                            <h1 class="mb-3" style="margin-left : 10px;"><%=row["event_name"]%></h1>
                                            <h5 class="mb-3" style="margin-left : 10px;"><b>Organized by:
                                                </b><%=row["organizer_name"]%></h5>
                                        </div>
                                    </div>
                                    <div
                                        class="col-sm-12 col-md-4 d-flex flex-column align-items-start align-items-md-end justify-content-center">
                                        <span class="text-truncate me-3" style="font-size:13px;"><b>Venue:</b>
                                            <%=row["venue"]%></span>
                                        <span class="text-truncate me-0" style="font-size:13px;"><b>Event Time:</b>
                                            <%=row["event_time"]%></span>
                                        <a class="btn btn-primary"
                                            href="CancelParticipation.aspx?event_participation_id=<%=row["event_participation_id"]%>"  style="margin-top : 10px;">Cancel
                                            Participation!</a>
                                    </div>
                                    <div class="LargerDiv">
                                        <h5 style="text-align:left; margin-left: 15px;padding-left:10px;padding-right:10px;">
                                            <%=row["event_description"]%></h5>
                                        <% if (string.IsNullOrEmpty(row["event_photo"].ToString()))
                                            {%>
                                        <img class="flex-shrink-0 img-fluid border rounded" src="
                                            <%=trimPath(row["event_photo"].ToString())%>
                                            " alt="" style="width: 220px; height: 250px; margin: 10px 0px 10px 20px;">
                                        <% } %>
                                        <!-- <img src = "HomePage_images/about-1.jpg" style="width: 200px; height: 200px;"> -->
                                    </div>
                                </div>                                
                            <% 
                                    }
                                }
                                else
                                    Response.Write("You are not currently participated in any event!");
                            %>
                        </div>
                    </div>                                   
                <!-- end here -->

                <!-- Job Alerts Section -->
                <div class="tab-pane fade" id="pills-jobAlert" role="tabpanel" aria-labelledby="pills-jobAlert-tab">
                <div class="card-body">
                <%
                    DataTable GetUserJobAlert()
                    {
                        try
                        {
                            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                            {

                                int userID = (int)Session["user_id"];
                                MySqlConnection connection = ConnectToDB();
                                string query = "select tbl_job_alert.job_alert_id,                                       " +
                                                "tbl_job_title.job_title,                                                " +
                                                "tbl_job_alert.company_name,                                             " +
                                                "tbl_place_of_work.place_of_work,                                        " +
                                                "tbl_job_alert.package,                                                  " +
                                                "tbl_job_alert.date_created,                                             " +
                                                "tbl_user.profile_photo_path                                             " +
                                                "from tbl_job_alert,tbl_job_title,tbl_place_of_work,tbl_user             " +
                                                "where                                                                   " +
                                                "tbl_job_alert.job_title_id = tbl_job_title.job_title_id and             " +
                                                "tbl_job_alert.place_of_work_id = tbl_place_of_work.place_of_work_id and " +
                                                "tbl_job_alert.created_by = tbl_user.user_id and                         " +
                                                "tbl_job_alert.is_enabled = 'y' and                                      " +
                                                "tbl_user.user_id = " + userID + ";";

                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                DataTable User_post_result = new DataTable();
                                adp.Fill(User_post_result);
                                return User_post_result;
                            }
                            else
                            {
                                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                return null;
                            }
                        }
                        catch (Exception error)
                        {
                            Response.Write(error.Message);
                            return null;
                        }
                    }
                %>
                            <%  
                                DataTable JobAlertTable = GetUserJobAlert();
                                if (JobAlertTable != null)
                                {
                                    if (JobAlertTable.Rows.Count != 0)
                                        foreach (DataRow row in JobAlertTable.Rows)
                                        {
                                            MySqlConnection connection = ConnectToDB();
                                            connection.Open();
                                            string query = "select tbl_user.user_id,tbl_user.user_name from tbl_job_apply,tbl_user where tbl_user.user_id = tbl_job_apply.applicant_id and tbl_job_apply.job_alert_id = " + row["job_alert_id"] + " and tbl_job_apply.is_enabled = 'y'";
                                            MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                            DataTable ApplicantsTable = new DataTable();
                                            adp.Fill(ApplicantsTable);
                                            connection.Close();
                            %>
                                    <div class="job-item p-4 mb-4">
                                        <div class="row g-4">
                                           
                                            <div class="col-sm-12 col-md-6 d-flex align-items-center">
                                                <div class="text-start ps-4 ">
                                                    <h2 class="mb-3" style="text-transform:uppercase;"><b><%= row["job_title"]%></b></h2>
                                                    <h2 class="mb-3"><%= row["company_name"]%></h2>
                                                    <span class="text-truncate me-3" style="font-size:17px;"><i
                                                            class="fa fa-map-marker-alt  me-2"
                                                            style="margin-right:10px"></i><%= row["place_of_work"]%></span><br>
                                                    <span class="text-truncate me-0" style="font-size:13px;"><i
                                                            class="far fa-money-bill-alt  me-2"
                                                            style="margin-right:10px"></i><%= row["package"]%></span><br>
                                                </div>
                                            </div>
                                            <div class="col-sm-12 col-md-6 d-flex flex-column align-items-start align-items-md-end justify-content-center" style="float:right;">
                                                <h3 class="text-truncate " style="font-size:10px;color:grey;" ><i
                                                        class="far fa-calendar-alt  me-2"></i><%= row["date_created"]%>
                                                </h3>
                                                <h4 class="mb-3 mt-1"><b>Total Applicants:<%= ApplicantsTable.Rows.Count%></b></h4>
                                                <a class="btn btn-primary"
                                                    href="RemoveJobAlert.aspx?job_alert_id=<%= row["job_alert_id"]%>" style="font-size:medium;">Remove
                                                    this Job Alert</a>
                                            </div>
                                        </div>
                                    </div>
                                    
                             <% 

                                             foreach (DataRow row1 in ApplicantsTable.Rows)
                                                 Response.Write("<a class=\"btn btn-primary username\" style=\"font-size:large;cursor:pointer\" href=\"OtherUserProfile.aspx?userid=" + row1["user_id"] + "\">" + row1["user_name"] + "</a><br>");
                                         }
                                     else
                                         Response.Write("no job alerts posted by you");
                                 }
                            %>
                </div>
                 </div>
                


                <!-- ends here -->

                <!-- Applied job section here -->
                <div class="tab-pane fade" id="pills-appliedJob" role="tabpanel" aria-labelledby="pills-appliedJob-tab">
                <div class="card-body">
                <%
                    DataTable GetUserJobApplication()
                    {
                        try
                        {
                            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                            {

                                int userID = (int)Session["user_id"];
                                MySqlConnection connection = ConnectToDB();
                                string query = "select tbl_job_alert.job_alert_id,                                                   " +
                                                "       tbl_job_apply.job_apply_id,                                                   " +
                                                "      tbl_job_title.job_title,                                                       " +
                                                "      tbl_job_alert.company_name,                                                    " +
                                                "      tbl_place_of_work.place_of_work,                                               " +
                                                "      tbl_job_alert.package,                                                         " +
                                                "      tbl_job_alert.date_created,                                                    " +
                                                "      tbl_user.profile_photo_path                                                    " +
                                                "      from tbl_job_alert,tbl_job_title,tbl_place_of_work,tbl_user,tbl_job_apply      " +
                                                "      where                                                                          " +
                                                "      tbl_job_alert.job_title_id = tbl_job_title.job_title_id and                    " +
                                                "      tbl_job_alert.place_of_work_id = tbl_place_of_work.place_of_work_id and        " +
                                                "      tbl_job_alert.created_by = tbl_user.user_id and                                " +
                                                "      tbl_job_apply.is_enabled = 'y' and                                             " +
                                                "      tbl_job_apply.job_alert_id = tbl_job_alert.job_alert_id and                    " +
                                                "      tbl_job_apply.applicant_id = " + userID + " and                                    " +
                                                "      tbl_job_alert.is_enabled = 'y';";

                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                DataTable User_post_result = new DataTable();
                                adp.Fill(User_post_result);
                                return User_post_result;
                            }
                            else
                            {
                                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                                return null;
                            }
                        }
                        catch (Exception error)
                        {
                            Response.Write(error.Message);
                            return null;
                        }
                    }
                %>
                <%
                    DataTable UserApplication = GetUserJobApplication();
                    if (UserApplication != null)
                    {
                        foreach (DataRow row in UserApplication.Rows)
                        {
                        %>
                                        <div class="job-item p-4 mb-4">
                                            <div class="row g-4">
                                            <div class="col-sm-12 col-md-8 d-flex align-items-center">

                                                <div class="text-start ps-4">
                                                    <h2 class="mb-3" style="text-transform:uppercase;"><b><%= row["job_title"] %></b></h2>
                                                    <h2 class="mb-3"><%= row["company_name"] %></h2>
                                                    <span class="text-truncate me-3" style="font-size:17px;"><i
                                                            class="fa fa-map-marker-alt  me-2"
                                                            style="margin-right:10px"></i><%= row["place_of_work"] %></span><br>
                                                    <span class="text-truncate me-0" style="font-size:13px;"><i
                                                            class="far fa-money-bill-alt  me-2"
                                                            style="margin-right:10px"></i><%= row["package"] %></span><br>
                                                </div>
                                                </div>
                                                <div
                                                class="col-sm-12 col-md-4 d-flex flex-column align-items-start align-items-md-end justify-content-center">
                                                <h2 class="text-truncate" style="font-size:10px;color:grey;"><i
                                                        class="far fa-calendar-alt  me-2" ></i><%= row["date_created"] %>
                                                </h2>
                                                <a class="btn btn-primary"
                                                    href="CancelApplication.aspx?job_apply_id=<%= row["job_apply_id"] %>" style="font-size:medium;">Cancel
                                                    Application!</a>
                                                </div> 
                                            </div>
                                        </div>
                                        <hr>
                                        <% }
                                            } %>

                </div>
                </div>             
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="HomePage_js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="HomePage_js/lightbox.js"></script>
    <script type="text/javascript" src="HomePage_js/all.js"></script>
    <script type="text/javascript" src="HomePage_js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="HomePage_js/owl.carousel.js"></script>
    <script type="text/javascript" src="HomePage_js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="HomePage_js/jquery.rateyo.js"></script>
    <script type="text/javascript" src="HomePage_js/custom.js"></script>
    <script>
        function openNav() {
            document.getElementById("mySidepanel").style.width = "250px";
        }

        function closeNav() {
            document.getElementById("mySidepanel").style.width = "0";
        }
    </script>
</body>

</html><%} %>