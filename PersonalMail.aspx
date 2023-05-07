<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalMail.aspx.cs" Inherits="AlumniProject.PersonalMail" %>

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

    bool SendMail(string subject,string body,string[] recipients,bool isHtml = true)
    {
        try
        {
            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("rishitselia@gmail.com", "tovaulsdwxhxnszc");
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.EnableSsl = true;

            MailMessage mail = new MailMessage();

            mail.From = new MailAddress("rishitselia@gmail.com");

            foreach(string mailID in recipients)
                mail.To.Add(new MailAddress(mailID));

            mail.Subject = subject;
            mail.IsBodyHtml = isHtml;
            mail.Body = body;

            smtpClient.Send(mail);
            return true;
        }
        catch (Exception error) { return false; }
    }


    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {


        // when the page is loaded
        if (Session["email_id_of_other_person"] == null)
            Session["email_id_of_other_person"] = Request["email_id_of_other_person"];


        // when the page is submitted 
        if (Request["submit"] != null)
            if (Session["user_id"] != null)
            {
                if (Session["email_id_of_other_person"] != null)
                {
                    string user_id = Session["user_id"].ToString();
                    if (user_id != "")
                    {
                        string toEmail = Session["email_id_of_other_person"].ToString();
                        string MailBody = Request["mail_body"];
                        string MailSubject = Request["mail_subject"];


                        if (SendMail(MailSubject, MailBody, new string[] { toEmail }, false))
                            Response.Write("<script>alert('mail sent successfully')</script>");
                        else
                            Response.Write("<script>alert('mail is not sent')</script>");
                    }
                    else
                        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
                }
                else
                    Response.Write("<script>alert('not in session');window.open('homePage.aspx','_blank').focus();window.close();</script>");
            }
            else
                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();<script>");
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
            <h3 class="ChatTitle"> Email </h3>
        </div>


        <div class="chattingWindow">
            <div class="ChatWin">
                <div class="container">
                    <form class="form-horizontal" action="#" method="post" runat="server" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="focusedInput fw-bold">Post Subject</label>
                            <input class="form-control" id="mail_subject" placeholder="Email subject here..." runat="server" type="text" name = "posttitle" required>
                        </div><br>
                        <div class="form-group">
                            <label for="focusedInput">Post Description</label>
                            <textarea class="form-control" id="mail_body" placeholder="Post description..." runat="server" name = "postdescription" cols="100" rows="5" required></textarea><br>
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

</html><%} %>