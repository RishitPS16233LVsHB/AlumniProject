<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherUserProfile.aspx.cs" Inherits="AlumniProject.OtherUserProfile" %>

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
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
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
                            director.bmiit@utu.ac.in</a>
                    </div>
                    <div class="top-header-block">
                        <a href="tel:+91 2622 290562" itemprop="telephone"><i class="fas fa-phone"></i> +91 2622
                            290562</a>
                    </div>
                </div>
                <div class="top-header-right">
                    <div class="social-block">
                        <ul class="social-list">
                            <li><a href=""><i class="fab fa-viber"></i></a></li>
                            <li><a href=""><i class="fab fa-google-plus-g"></i></a></li>
                            <li><a href=""><i class="fab fa-facebook-square"></i></a></li>
                            <li><a href=""><i class="fab fa-facebook-messenger"></i></a></li>
                            <li><a href=""><i class="fab fa-twitter"></i></a></li>
                            <li><a href=""><i class="fab fa-skype"></i></a></li>
                        </ul>
                    </div>
                    <div class="login-block">
                        <a href="LogoutSession.aspx" id="logOut">Log Out</a>
                        <span style="color : white">|</span>
                        <a href="setting.aspx">Settings</a>
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
                            <li><a href="PersonalMail.aspx?email_id_of_other_person=<%
                                    if (Request["userid"] != null)
                                    {
                                        string query = "select email_id from tbl_user where user_id = " + Request["userid"] + "";
                                        MySqlConnection connection = ConnectToDB();
                                        connection.Open();
                                        MySqlCommand command = new MySqlCommand(query, connection);
                                        MySqlDataReader data = command.ExecuteReader();
                                        if (data.HasRows)
                                            while (data.Read())
                                            {
                                                Response.Write(data.GetString(0));
                                                break;
                                            }
                                        data.Close();
                                        connection.Close();
                                    }
                                    %>">Email this Person</a>
                            </li>
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
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <div class="card-body pb-2">
                            <%
                                DataRow GetUserData()
                                {
                                    try
                                    {
                                        if (!string.IsNullOrEmpty(Request["userid"].ToString()))
                                        {

                                            int userID = Convert.ToInt32(Request["userid"]);
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
                                <%if (UserRow != null)
                                    {
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
                                            if (!string.IsNullOrEmpty(Request["userid"].ToString()))
                                            {
                                                MySqlConnection connection = ConnectToDB();
                                                connection.Open();
                                                string query = "select distinct technology_name from tbl_technology where technology_id in(select technology_id from tbl_user_technology where user_id = 74)";
                                                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                                                DataTable techSet = new DataTable();
                                                adp.Fill(techSet);
                                                string[] tech = new string[1];
                                                foreach (DataRow r in techSet.Rows)
                                                    Response.Write(r["technology_name"].ToString() + " ");
                                            }
                                        } %></li>
                            </ul>
                            <hr>
                            <% 
                                DataTable GetUserExperience()
                                {
                                    try
                                    {
                                        if (!string.IsNullOrEmpty(Request["userid"].ToString()))
                                        {
                                            int userID = Convert.ToInt32(Request["userid"]);
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
<%--                                        <h5 class="title text-danger"><%=DateTime.Parse(row["start_date"].ToString()).Year%>-<%=DateTime.Parse(row["end_date"].ToString()).Year%></h5>
                                        <h6><%=row["experience_title"]%></h6>
                                        <P class="subtitle"> <%=row["experience_description"]%></P>
                                        <hr>--%>
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
                                        if (!string.IsNullOrEmpty(Request["userid"]))
                                        {
                                            int userID = Convert.ToInt32(Request["userid"]);
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
                            %>   

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
