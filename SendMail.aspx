<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMail.aspx.cs" Inherits="AlumniProject.SendMail" %>

<%@Import Namespace="System.Net.Mail"%>
<%@Import Namespace="System"%>
<%
    SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
    smtpClient.UseDefaultCredentials = false;
    smtpClient.Credentials = new System.Net.NetworkCredential("rishitselia@gmail.com", "tovaulsdwxhxnszc");
    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
    smtpClient.EnableSsl = true;
    
    MailMessage mail = new MailMessage();

    mail.From = new MailAddress("rishitselia@gmail.com");
    mail.To.Add(new MailAddress("rishitselia@gmail.com"));
    mail.Subject = "some subject";
    mail.IsBodyHtml = true;
    mail.Body = "<h1> this is heading</h1><b> this is a body</b>";

    smtpClient.Send(mail);
%>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
