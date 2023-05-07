    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobApply.aspx.cs" Inherits="AlumniProject.JobApply" %>

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
    void InsertIntoJobApplyTable(int JobAlertID)
    {
        try
        {
            if (Session["user_id"] != null)
            {
                if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    if (JobAlertID > 0)
                    {
                        string UserID = Session["user_id"].ToString();
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();

                        string Query = "select count(job_apply_id) from tbl_job_apply where applicant_id = " + UserID + " and job_alert_id = " + JobAlertID + " and is_enabled = 'y' ";
                        MySqlCommand command = new MySqlCommand(Query, connection);
                        int TotalRows = Convert.ToInt32(command.ExecuteScalar());

                        if (TotalRows > 0)
                            Response.Write("<script>alert('not in session');window.open('homePage.aspx','_blank').focus();window.close();</script>");
                        else
                        {
                            Query = "insert into tbl_job_apply(job_alert_id,applicant_id,created_by,modified_by)values(" + JobAlertID + "," + UserID + "," + UserID + "," + UserID + ")";
                            command.CommandText = Query;
                            command.ExecuteNonQuery();                            
                            Response.Write("<script>alert('job applied successfully');document.location.href='Jobs.aspx';</script>");
                        }
                        CloseConnection(ref connection);
                    }
                    else
                        Response.Write("<script>alert('not in session');window.open('homePage.aspx','_blank').focus();window.close();</script>");
                }
                else
                    Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
            }
            else
                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
        }
        catch (Exception error)
        {
            Response.Write(error.Message + " " + error.StackTrace);
        }
    }


%>

<%            
    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    else
    {

        try
        {
            if (!string.IsNullOrEmpty(Request["job_alert_id"]))
            {
                int ID = Convert.ToInt32(Request["job_alert_id"]);
                InsertIntoJobApplyTable(ID);
                //Response.Redirect("profile.aspx");
            }
            else
                Response.Write("<script>alert('not in session');window.open('homePage.aspx','_blank').focus();window.close();</script>");
        }
        catch (Exception error)
        {

        }
    }
%>