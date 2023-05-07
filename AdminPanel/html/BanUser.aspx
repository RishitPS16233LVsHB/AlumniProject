<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BanUser.aspx.cs" Inherits="AlumniProject.AdminPanel.html.BanUser" %>
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
 %>
<%
    if(!string.IsNullOrEmpty(Request["user_id"]))
    {
        string ID = Request["user_id"];
        MySqlConnection connection = ConnectToDB();
        connection.Open();
        string query = "update tbl_user set is_enabled = 'n' where user_id = "+ID+"";
        MySqlCommand command = new MySqlCommand(query,connection);
        command.ExecuteNonQuery();
        connection.Close();
        Response.Redirect("user-activity.aspx");
    }
%>