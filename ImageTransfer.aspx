<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageTransfer.aspx.cs" Inherits="AlumniProject.ImageTransfer" %>


<%@ Import Namespace ="System.IO"%>
<%@ Import Namespace ="System"%>
<%@ Import Namespace ="System.Net"%>
<%@ Import Namespace ="System.Web"%>
<%@ Import Namespace ="System.Text.RegularExpressions"%>



<%
    if (Request["upload"] != null)
    {
        Response.Write(FileUpload1.FileName);
        string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
        Regex rx = new Regex(Pattern);
        if(rx.IsMatch(FileUpload1.FileName))
            FileUpload1.SaveAs(Server.MapPath("Uploads//"+FileUpload1.FileName));
        else
            Response.Write("<script>if(confirm('Image files are allowed')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
    }

%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" method ="post" enctype="multipart/form-data">
        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <input type ="submit" runat="server" id ="upload">
        </div>
    </form>
</body>
</html>
<%--  --%>