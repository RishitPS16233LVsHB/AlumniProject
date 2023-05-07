<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreatePosts.aspx.cs" Inherits="AlumniProject.CreatePosts" %>

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
    void InsertIntoPostTable(string Title, string Description, FileUpload fileUploadControl)
    {
        try
        {
            if (Session["user_id"] != null)
            {
                if ((int)Session["user_id"] != -1 || !string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    if (Title != "" && Description != "")
                    {
                        int UserID = (int)Session["user_id"];
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();
                        string Query = "insert into tbl_community_post" +
                                    "(post_title,content,user_id,created_by,modified_by)" +
                                    "values" +
                                    "('" + Title + "','" + Description + "'," + UserID + "," + UserID + "," + UserID + ")";
                        MySqlCommand command = new MySqlCommand(Query, connection);
                        command.ExecuteNonQuery();
                        long LastInsertID = command.LastInsertedId;

                        // if there is an image file
                        if (fileUploadControl.FileName != null || fileUploadControl.FileName != "")
                        {
                            string EnrollmentNumber = Session["enrollment_number"].ToString();
                            string Path = Server.MapPath("Uploads//" + UserID + "-User-" + EnrollmentNumber + "//" + fileUploadControl.FileName);
                            Path = Path.Replace("\\","/");
                            string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                            Regex rx = new Regex(Pattern);

                            if (fileUploadControl.FileName != "" && FileUpload1.FileName != null)
                            {
                                if (rx.IsMatch(fileUploadControl.FileName))
                                {
                                    Query = "update tbl_community_post set post_image = '" + Path + "' where community_post_id = " + LastInsertID + "";
                                    command.CommandText = Query;
                                    command.ExecuteNonQuery();
                                    fileUploadControl.SaveAs(Path);
                                    Response.Write("<script>alert('post created successfully');document.location.href='Posts.aspx';</script>");
                                }
                                else
                                    Response.Write("<script>if(confirm('only image files allowed')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                            }
                        }
                        else                            
                            Response.Write("<script>alert('post created successfully');document.location.href='Posts.aspx';</script>");
                        CloseConnection(ref connection);
                    }
                    else
                        Response.Write("<script>if(confirm('Post Title or Description empty')) document.location = 'CreatePost.aspx';else  document.location = 'CreatePost.aspx';</script>");
                }
                else
                    Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error)
        { }
    }

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

        if (Request["submit"] != null)
        {
            string PostTitle = "";
            string PostDescription = "";

            Response.Write(Request["description"]);
            Response.Write(Request["subject"]);
            if (!string.IsNullOrEmpty(Request["description"]) && !string.IsNullOrEmpty(Request["subject"]))
            {
                PostDescription = Request["description"];
                PostTitle = Request["subject"];
                InsertIntoPostTable(PostTitle, PostDescription, FileUpload1);
            }
            else
                Response.Write("<script>alert('some fields were empty')</script>");
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
            <a href="homePage.aspx"> <img class="BackButton" src="Images/BackButton.png"> </a>
            <h3 class="ChatTitle"> Create Post </h3>
        </div>


        <div class="chattingWindow">
            <div class="ChatWin">
                <div class="container">
                    <form class="form-horizontal" action="#" method="post" runat="server" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="focusedInput fw-bold">Post Subject</label>
                            <input class="form-control" id="subject" placeholder="Post title here..." runat="server" type="text" name = "posttitle">
                        </div><br>
                        <div class="form-group">
                            <label for="focusedInput">Post Description</label>
                            <textarea class="form-control" id="description" placeholder="Post description..." runat="server" name = "postdescription"
                                cols="100" rows="5"></textarea><br>
                        </div>
                        <div class="form-group">
                            <label for="focusedInput fw-bold">Attach some media</label>
                            <asp:FileUpload ID="FileUpload1" runat="server" class="form-control"/>
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