﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateChat.aspx.cs" Inherits="AlumniProject.CreateChat" %>

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


    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();

            if (Request["user_id"] != null && Request["user_name"] != null && Session["user_id"] != null)
            {
                string user_name = Request["user_name"];
                string id = Request["user_id"];
                string userID = Session["user_id"].ToString();
                string query = "select * from tbl_personal_chats where user_1 = " + userID + " and user_2 = " + id + " and is_enabled = 'y'";
                int personal_chat_id = 0;
                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                DataTable DT = new DataTable();
                adp.Fill(DT);

                if (DT.Rows.Count >= 1)
                {
                    Response.Write("<script>alert('you are already in touch with that member');document.location=homePage.aspx");
                }
                else
                {
                    query = "insert into tbl_personal_chats(personal_chat_name,user_1,user_2,created_by,modified_by)values('" + user_name + "'," + userID + "," + id + "," + userID + "," + userID + ")";
                    MySqlCommand command = new MySqlCommand(query, connection);
                    if (Convert.ToInt32(command.ExecuteNonQuery()) == 1)
                    {
                        personal_chat_id = (int)command.LastInsertedId;
                        //header("location: Chat.aspx?user_id=id&user_name=user_name&personal_chat_id=personal_chat_id");
                        Response.Redirect("OriginalChat.aspx");
                    }
                    else
                        Response.Write("<script>alert('error occured');document.location='homePage.aspx'<script>");
                }
                connection.Close();
            }
            else
                Response.Write("<script>alert('not in session');document.location='Login.aspx'<script>");
            //CloseConnection(connection);
        }
        catch (Exception error)
        {
            Response.Write(error.Message + " " + error.StackTrace);
        }
    }
%>