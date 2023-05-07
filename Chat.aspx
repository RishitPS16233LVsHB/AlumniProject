<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="AlumniProject.Chat" %>

<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Security.Cryptography" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<%@Import Namespace="System.Net.Mail"%>
<%
    // declaration and reseting of page variables
    string Show_user_name = "";
    string user_name = "";
    string user_id= "";
    string Current_ID = "";
    string personal_chat_id = "";
    string user_index = "";
    string current_id = "";
    Response.Write("here");


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

    string trimPath(string Path)
    {
        try
        {
            if (Path != null)
            {
                string[] separatedPath = Path.Split('/');
                string FinalPath = separatedPath[separatedPath.Length - 3] + "/" + separatedPath[separatedPath.Length - 2] + "/" + separatedPath[separatedPath.Length - 1];
                return FinalPath;
            }
            return "";
        }
        catch (Exception error)
        {
            return "";
        }
    }

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {


        // part where we add the message
        if (Request["SUBMIT"] != null)
        {
            string message = Request["message"];
            Response.Write("Here 4");
            if (Session["OTHER_USER_ID"] != null &&
                Session["USER_NAME"] != null &&
                Session["PERSONAL_CHAT_ID"] != null &&
                Session["SHOW_USER_NAME"] != null &&
                Session["USER_INDEX"] != null)
            {
                string User_id = Session["OTHER_USER_ID"].ToString();
                string User_name = Session["USER_NAME"].ToString();
                string Personal_chat_id = Session["PERSONAL_CHAT_ID"].ToString();
                string show_user_name = Session["SHOW_USER_NAME"].ToString();
                string User_index = Session["USER_INDEX"].ToString();
                Response.Write(message + " - " + User_id + " - " + User_name + " - " + Personal_chat_id + " - " + show_user_name + " - " + User_index);
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string QUERY = "insert into tbl_chat_message(personal_chat_id,content,sender_id,sender_name,created_by,modified_by)values(" + Personal_chat_id + ",'" + message + "'," + User_id + ",'" + User_name + "'," + User_id + "," + User_id + ")";
                Response.Write(QUERY);
                MySqlCommand command = new MySqlCommand(QUERY, connection);
                command.ExecuteNonQuery();
                QUERY = "update tbl_personal_chats set read_user_1 = 1 , read_user_2 = 1 where personal_chat_id = personal_chat_id";
                command.CommandText = QUERY;
                command.ExecuteNonQuery();
                connection.Close();
                //Response.Redirect("Chat.aspx?user_id=" + User_id + "&user_name=" + User_name + "&personal_chat_id=" + Personal_chat_id + "&show_user_name=" + show_user_name + "&user_index=" + User_index + "");
            }
        }
        else
            Response.Write("the data was null" + (Request["message"] == null));
        DataTable result = new DataTable();
        DataTable result1 = new DataTable();

        Response.Write("here2");

        // first time init
        try
        {
            if (Session["OTHER_USER_ID"] == null ||
                Session["USER_INDEX"] == null ||
                Session["PERSONAL_CHAT_ID"] == null ||
                Session["SHOW_USER_NAME"] == null ||
                Session["USER_NAME"] == null)
            {
                Response.Write("here3");
                // user_id is not you
                Session["OTHER_USER_ID"] = Request["user_id"];
                string query = "";
                // Current_id is you
                current_id = Session["user_id"].ToString();
                Session["PERSONAL_CHAT_ID"] = Request["personal_chat_id"];
                Session["USER_INDEX"] = Request["user_index"];

                MySqlConnection connection = ConnectToDB();
                connection.Open();
                if (Request["user_index"] == "1")
                    query = "update tbl_personal_chats set read_user_2 = 0 where personal_chat_id = " + Request["personal_chat_id"] + "";
                else if (Request["user_index"] == "2")
                    query = "update tbl_personal_chats set read_user_1 = 0 where personal_chat_id = " + Request["personal_chat_id"] + "";

                Response.Write(query);

                MySqlCommand command1 = new MySqlCommand(query, connection);
                command1.ExecuteNonQuery();


                query = "select user_name from tbl_user where user_id = " + Request["user_id"] + "";
                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                adp.Fill(result);
                query = "select user_name from tbl_user where user_id = " + current_id + "";
                adp = new MySqlDataAdapter(query, connection);
                adp.Fill(result1);

                if (result != null)
                {
                    foreach (DataRow r in result.Rows)
                        Session["SHOW_USER_NAME"] = r["user_name"].ToString();
                    foreach (DataRow r in result1.Rows)
                        Session["USER_NAME"] = r["user_name"].ToString();
                    connection.Close();
                }
                else
                    connection.Close();

                // always setting 
                Show_user_name = Session["SHOW_USER_NAME"].ToString();
                user_name = Session["USER_NAME"].ToString();
                user_id = Session["OTHER_USER_ID"].ToString();
                user_index = Session["USER_INDEX"].ToString();
                personal_chat_id = Session["PERSONAL_CHAT_ID"].ToString();
                current_id = Session["user_id"].ToString();

                Response.Write(Show_user_name + " " + user_name + " " + user_id + " " + user_index + " " + personal_chat_id + " " + current_id);
            }
        }
        catch (Exception error)
        {
            Response.Write(error.Message + " " + error.StackTrace);
        }

%> 



<!DOCTYPE html>

<!doctype html>
<html lang="en">

<head>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
        integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="Chatcss.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
</head>

<body>
    <div class="row comment-box-main p-4 rounded-bottom mb-2">
        <a class="BackButton" href="OriginalChat.aspx"> <img src="Images/BackButton.png" class="BackButton"></a>
        <h3 class="ChatTitle"> <%=Show_user_name %> </h3>        
    </div>

   




    <div class="chattingWindow">
        <div class="ChatWin">
            <%            try
                {
                    MySqlConnection Connection = ConnectToDB();
                    Connection.Open();
                    string Query = "select content,sender_name from tbl_chat_message where personal_chat_id = " + Session["PERSONAL_CHAT_ID"].ToString() + "";
                    Response.Write(Query);
                    DataTable Result = new DataTable();
                    MySqlDataAdapter Adp = new MySqlDataAdapter(Query, Connection);
                    Adp.Fill(result);
                    Connection.Close();
                    foreach (DataRow rows in result.Rows)
                    {
            %>
            <ul class="p-0">
                <li>
                    <div class="row comments mb-2">
                        <div class="col-md-8 col-sm-5 col-5 comment rounded mb-2">
                            <h4 class="m-0"><a href="#"><%=rows["sender_name"]%></a></h4>
                            <p class="mb-0 text-white"><%=rows["content"]%></p>
                        </div>
                    </div>
                </li>
            </ul>            
            <% }
                }
                catch (Exception error) { Response.Write(error.Message + " " + error.StackTrace); }%>
        </div>
    </div>  

    <div class="row comment-box-main p-3 rounded-bottom Chatmessage">
        <form action = "#" runat="server" method = "post">
            <div class="col-md-9 col-sm-9 col-9 pr-0 comment-box" style = "padding-right:100px">       
                <input type="text"  runat="server" style = "width:1000px;" class="form-control"  id = "message" required>
            </div>
            <asp:Button ID="SUBMIT" runat="server" Text="Button" />
        </form>
    </div>

</body>
<script src='https://cdnjs.cloudflare.com/ajax/libs/vue/0.12.14/vue.min.js'></script>

</html>
<%} %>