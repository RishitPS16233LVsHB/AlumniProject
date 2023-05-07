<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OriginalChat.aspx.cs" Inherits="AlumniProject.OriginalChat" %>

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

    Session["OTHER_USER_ID"] = null;
    Session["USER_INDEX"] = null;
    Session["PERSONAL_CHAT_ID"] = null;
    Session["SHOW_USER_NAME"] = null;
    Session["USER_NAME"] = null;


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
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
        integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/HomePage_css/OriginalChatCss.css">
    <meta name="viewport" content="width=device-width">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/all.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/all.min.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/lightbox.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/flexslider.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.carousel.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.theme.default.css">
	<link rel="stylesheet" type="text/css" href="css/HomePage_css/jquery.rateyo.css" />
	<!-- <link rel="stylesheet" type="text/css" href="css/jquery.mmenu.all.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="css/meanmenu.min.css"> -->
	<link rel="stylesheet" type="text/css" href="inner-page-style.css">
	<link rel="stylesheet" type="text/css" href="HomePage_style.css">
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap" rel="stylesheet">
</head>

<body>
    <header class="site-header">
        <div class="top-header">
            <div class="container">
                <div class="top-header-left">
                    <div class="top-header-block">
                        <a href="mailto:info@educationpro.com" itemprop="email"><i class="fas fa-envelope"></i>
                            info@educationpro.com</a>
                    </div>
                    <div class="top-header-block">
                        <a href="tel:+9779813639131" itemprop="telephone"><i class="fas fa-phone"></i> +977
                            9813639131</a>
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
                        <!-- onclick="preventBack()" -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Top header Close -->
        <div class="main-header">
            <div class="container">
                <div class="logo-wrap" itemprop="logo">
                    <!-- <img src="HomePage_images/site-logo.jpg" alt="Logo Image"> -->
                    <!-- <h1>Education</h1> -->
                </div>
                <div class="nav-wrap">
                    <nav class="nav-desktop">
                        <ul class="menu-list">
                            <li><a href="homePage.aspx">Home</a></li>
                            <li class="menu-parent">Create Post
                                <ul class="sub-menu">
                                    <li><a href="CreatePost.aspx">Create Post</a></li>
                                    <li><a href="CreateEvent.aspx">Create Event</a></li>
                                    <li><a href="CreateJob.aspx">Create Jobs</a></li>
                                </ul>
                            </li>                            
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
    <div class="container" id="container">
        <div class=" row comment-box-main p-4 rounded-bottom text-center">
            <h3 class="ChatTitle"> Chats </h3>
            <form action = "#"  runat = "server" method= "post" style = "padding-left:59%;">
            <h4 class="ChatTitle"> Search your friends : </h4>
                <input type = "text"  runat="server" id="Search_val">
                <input type ="submit" runat="server">
            </form>
        </div>
        <%                

            DataTable ChatUser = new DataTable();
            //Response.Write(Request["Search_val"] == null);
            //Response.Write(Session["user_id"] == null);
            try
            {
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    string userID = Session["user_id"].ToString();
                    string query = "";
                    if (Request["Search_val"] != null)
                        query = "select user_id,user_name from tbl_user where user_name like '%" + Request["Search_val"].ToString() + "%' and user_id != " + userID + " and is_enabled = 'y';";
                    else
                        query = "select personal_chat_id,personal_chat_name,user_2,user_1 from tbl_personal_chats where (user_1 = " + userID + " || user_2 = " + userID + ") and is_enabled = 'y'";
                    MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                    adp.Fill(ChatUser);
                    connection.Close();
                    if (ChatUser.Rows.Count == 0)
                        Response.Write("<h2 style = \"color:darkblue;\"><b><i>no chats or user found!</i></b></h2>");
                }
                else
                    Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
            }
            catch (Exception error) { }
        %>
        <% if (Request["Search_val"] != null)
            {%>
            <% foreach (DataRow rows in ChatUser.Rows)
                {%>
                    <div class="chattingWindow">
                        <div class="ChatWin">
                            <!-- this is a left side message -->
                            <ul class="p-0">
                                <li>
                                    <div class="row comments mb-2">
                                        <!-- image div for user profile photo-->
                                        <div class="col-md-1 col-sm-2 col-3 text-center user-img" style = "padding-top:21px">
                                            <!-- <img id="profile-photo" src="http://nicesnippets.com/demo/man04.png" -->
                                                <!-- class="rounded-circle" /> -->
                                        </div>
                                        <!-- message body here-->
                                        <div class="col-md-10 col-sm-5s col-5 comment rounded mb-4" style = "margin-top:12px">
                                            <!-- sender name here-->
                                            <h4 class="m-0"><a href = "OtherUserProfile.aspx?userid=<%=rows["user_id"]%>">@<%=rows["user_name"]%></a></h4>
                                            <!-- <time class="text-white ml-3">1 hours ago</time> -->
                                            <p class="mb-0 text-white">
                                                <a class = "OpenButton" href="CreateChat.aspx?user_id=<%=rows["user_id"]%>&user_name=<%=rows["user_name"]%>">Start a chat 
                                                    <img src="HomePage_images/ChatHere.png" class="sendButton">
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>  
                <% } %>
           <% }
               else
               {
                   string Other_User_ID = "";
                   int UserIndex = 0;
           %>
                <% foreach (DataRow rows in ChatUser.Rows)
                    {
                        if (rows["User_2"].ToString() == Session["user_id"].ToString())
                        {
                            Other_User_ID = rows["User_1"].ToString();
                            UserIndex = 1;
                        }
                        else
                        {
                            Other_User_ID = rows["User_2"].ToString();
                            UserIndex = 2;
                        }
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();
                        string Query = "select user_name,user_id from tbl_user where user_id = " + Other_User_ID + "";
                        DataTable re = new DataTable();
                        MySqlDataAdapter adp = new MySqlDataAdapter(Query, connection);
                        adp.Fill(re);

                        string Other_User_Name = "";

                        foreach (DataRow r in re.Rows)
                        {
                            Other_User_Name = r["user_name"].ToString();
                            Other_User_ID = r["user_id"].ToString();
                        }
                        connection.Close();
                %> 
                    <div class="chattingWindow">
                        <div class="ChatWin">
                            <!-- this is a left side message -->
                            <ul class="p-0">
                                <li>
                                    <div class="row comments mb-2">
                                        <!-- image div for user profile photo-->
                                        <div class="col-md-1 col-sm-2 col-3 text-center user-img" style = "padding-top:21px">
                                            <!-- <img id="profile-photo" src="http://nicesnippets.com/demo/man04.png"
                                                class="rounded-circle" /> -->
                                        </div>
                                        <!-- message body here-->
                                        <div class="col-md-10 col-sm-5s col-5 comment rounded mb-4" style = "margin-top:12px">
                                            <!-- sender name here-->
                                            <h4 class="m-0"><a href = "OtherUserProfile.aspx?userid=<%=Other_User_ID%>">@<%=Other_User_Name%></a></h4>
                                            <p class="mb-0 text-white">
                                                <a class="OpenButton" href = "Chat.aspx?personal_chat_id=<%=rows["personal_chat_id"]%>&user_id=<%=Other_User_ID%>&user_index=<%=UserIndex%>">Open Chat<img
                                                        src="HomePage_images/ChatHere.png" class="sendButton"></a>
                                                <a class="OpenButton" href = "DeleteChat.aspx?chat_id=<%=rows["personal_chat_id"]%>&user_id=<%=Session["user_id"].ToString()%>">Delete chat<img src="HomePage_images/Delete.png"
                                                        class="sendButton"></a>
                                            </p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>  
                <% } %>
            <% } %>
    </div>
    <script type="text/javascript" src="HomePage_js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="HomePage_js/lightbox.js"></script>
    <script type="text/javascript" src="HomePage_js/all.js"></script>
    <script type="text/javascript" src="HomePage_js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="HomePage_js/owl.carousel.js"></script>
    <script type="text/javascript" src="HomePage_js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="HomePage_js/jquery.rateyo.js"></script>
    <!-- <script type="text/javascript" src="js/jquery.mmenu.all.js"></script> -->
    <!-- <script type="text/javascript" src="js/jquery.meanmenu.min.js"></script> -->
    <script type="text/javascript" src="HomePage_js/custom.js"></script>
</body>
<script src='https://cdnjs.cloudflare.com/ajax/libs/vue/0.12.14/vue.min.js'></script>

</html><%} %>