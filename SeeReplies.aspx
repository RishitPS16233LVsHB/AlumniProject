<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeeReplies.aspx.cs" Inherits="AlumniProject.SeeReplies" %>
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

    void CloseConnection(ref MySqlConnection connection)
    {
        try
        {
            if(connection != null)
                connection.Close();
        }
        catch(Exception error)
        { }
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


        if (Request["post_id"] != null)
            Session["postID"] = Request["post_id"];
        else
            Response.Write("<script>alert('server error please retry');window.open('homePage.aspx','_blank').focus();window.close();</script>");



    
%>


<html lang="en">

<head>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
        integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="CreatePostCss.css">
    <style>
        .card-body{
                border-bottom:2px solid #1c3961;

        }
        .card-body a{
            color:#1c3961;
        }
    </style>
</head>

<body>
    <!-- <div class="conatiner-fluid"> -->
    <div class="conatiner-fluid">
        <div class="row comment-box-main p-4 rounded-bottom">
            <a href="Posts.aspx"> <img class="BackButton" src="Images/BackButton.png"> </a>
            <h3 class="ChatTitle"> Replies to this post....</h3>
            <%--<a class="Username" href="#"> @Rishit Selia </a>--%>
        </div>
                <div class="col-md-6 col-lg-12">
                <div class="container">
                <%            
                    try
                    {
                        string query = "select                                                                         " +
                        "tbl_user.user_id,                                                                              " +
                        "tbl_user.user_name,                                                                            " +
                        "tbl_user.profile_photo_path,                                                                   " +
                        "tbl_reply_to_post.content_of_reply,tbl_reply_to_post.reply_to_post_id,                          " +
                        "tbl_reply_to_post.upload_time                                                                  " +
                        "    from tbl_user,tbl_reply_to_post where tbl_user.user_id = tbl_reply_to_post.replier_id and  " +
                        "   tbl_reply_to_post.community_post_id = " + Request["post_id"] + " and " +
                        "    tbl_reply_to_post.is_enabled = 'y' order by tbl_reply_to_post.upload_time desc;";

                        MySqlConnection connection = ConnectToDB();
                        connection.Open();
                        DataTable ReplySet = new DataTable();
                        MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                        adp.Fill(ReplySet);

                        if (ReplySet != null)
                        {
                            foreach (DataRow row in ReplySet.Rows)
                            {%>
                    <div class="card-body" style="width:100%">
                        
                        <h5 class="title  text-danger"><b><a class="username"
                            href="OtherUserProfile.aspx?userid=<%= row["user_id"]%>">@<%= row["user_name"]%></a></b>
                        </h5>
                        <p class="postTime"><%= row["upload_time"]%></p>
                        <P class="subtitle" style="font-size:large;"> <%= row["content_of_reply"]%></P>
                    </div>
                    <%
                                }
                                connection.Close();
                            }
                        }
                        catch (Exception error)
                        {
                            Response.Write(error.Message);
                        }
                    %>
                </div>

            </div>
            <script type="text/javascript" src="HomePage_js/jquery-3.3.1.min.js"></script>
            <script type="text/javascript" src="HomePage_js/lightbox.js"></script>
            <script type="text/javascript" src="HomePage_js/all.js"></script>
            <script type="text/javascript" src="HomePage_js/isotope.pkgd.min.js"></script>
            <script type="text/javascript" src="HomePage_js/owl.carousel.js"></script>
            <script type="text/javascript" src="HomePage_js/jquery.flexslider.js"></script>
            <script type="text/javascript" src="HomePage_js/jquery.rateyo.js"></script>
            <script type="text/javascript" src="HomePage_js/custom.js"></script>


    </div>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="js/lightbox.js"></script>
    <script type="text/javascript" src="js/all.js"></script>
    <script type="text/javascript" src="js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="js/owl.carousel.js"></script>
    <script type="text/javascript" src="js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="js/jquery.rateyo.js"></script>
    <!-- <script type="text/javascript" src="js/jquery.mmenu.all.js"></script> -->
    <!-- <script type="text/javascript" src="js/jquery.meanmenu.min.js"></script> -->
    <script type="text/javascript" src="js/custom.js"></script>
</body>
<script src='https://cdnjs.cloudflare.com/ajax/libs/vue/0.12.14/vue.min.js'></script>

</html><%} %>