<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddReplyToPost.aspx.cs" Inherits="AlumniProject.AddReplyToPost" %>

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

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {


        if (Request["post_id"] != null)
            Session["postID"] = Request["post_id"];
        else
            Response.Write("<script>alert('server error please retry');document.location = 'homePage.aspx';</script>");



        if (Request["submit"] != null)
        {
            if (Session["postID"] != null)
            {
                Response.Write(Request["reply"]);
                string PostID = Session["postID"].ToString();
                string PostReply = Request["reply"];
                string UserID = Session["user_id"].ToString();

                try
                {
                    MySqlConnection connection = ConnectToDB();
                    connection.Open();
                    string Query = "insert into tbl_reply_to_post(community_post_id,replier_id,content_of_reply,created_by,modified_by)values" +
                                "(" + PostID + "," + UserID + ",'" + PostReply + "'," + UserID + "," + UserID + ")";
                    Response.Write(Query);
                    MySqlCommand command = new MySqlCommand(Query, connection);
                    command.ExecuteNonQuery();
                    //Response.End();
                    Response.Write("<script>document.location = 'posts.aspx';</script>");
                    connection.Close();
                }
                catch (Exception error)
                {
                    Response.Write("<script>alert('" + error.Message + "');document.location = 'homePage.aspx';</script>");
                }
                Session["postID"] = null;
            }
        }
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
</head>

<body>
    <!-- <div class="conatiner-fluid"> -->
    <div class="conatiner-fluid">
        <div class="row comment-box-main p-4 rounded-bottom">
            <a href="Posts.aspx"> <img class="BackButton" src="Images/BackButton.png"> </a>
            <h3 class="ChatTitle"> Add Reply </h3>
            <%--<a class="Username" href="#"> @Rishit Selia </a>--%>
        </div>


        <div class="chattingWindow">
            <div class="ChatWin">
                <div class="container">
                    <form class="form-horizontal" action="#" method="post" runat="server" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="focusedInput">Your reply</label>
                            <textarea class="form-control" id="reply" placeholder="your reply here" runat="server" name = "reply"
                                cols="100" rows="5"></textarea><br>
                        </div>
                        <br>                        
                        <br>
                            <input class = "submitbtn" type = "submit" id ="submit" runat="server" value = "POST!">
                    </form>
                </div>
            </div>
        </div>
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

</html>
<%} %>