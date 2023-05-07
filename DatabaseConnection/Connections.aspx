<%@ Language="C#" %>

<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.IO" %>


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

    void CreateDirectory(string UserID)
    {
        try
        {
            Directory.CreateDirectory(Server.MapPath("Uploads/" + UserID));
        }
        catch (Exception error) { }
    }
%>