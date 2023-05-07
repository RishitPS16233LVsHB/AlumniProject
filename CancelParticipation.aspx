<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelParticipation.aspx.cs" Inherits="AlumniProject.CancelParticipation" %>

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
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

        if (!string.IsNullOrEmpty(Request["event_participation_id"]))
        {
            string ID = Request["event_participation_id"];
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string query = "update tbl_event_participation set is_enabled = 'n' where event_participation_id = " + ID + "";
            MySqlCommand command = new MySqlCommand(query, connection);
            command.ExecuteNonQuery();
            connection.Close();
            Response.Redirect("profile.aspx");
        }
    }
%>