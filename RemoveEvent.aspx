<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveEvent.aspx.cs" Inherits="AlumniProject.RemoveEvent" %>

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
    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    else
    {

        if (!string.IsNullOrEmpty(Request["event_id"]))
        {
            string ID = Request["event_id"];
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string query = "update tbl_event set is_enabled = 'n' where event_id = " + ID + "";
            MySqlCommand command = new MySqlCommand(query, connection);
            command.ExecuteNonQuery();
            connection.Close();
            Response.Redirect("profile.aspx");
        }
    }
%>