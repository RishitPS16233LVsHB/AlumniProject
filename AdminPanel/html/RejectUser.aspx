<%@ Page Language="C#"%>
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
            smtpClient.Credentials = new System.Net.NetworkCredential("rishitselia@gmail.com", "kmqzwelhebtxbmoi");
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


    if (Request["id"] != null)
    {
        MySqlConnection connection = ConnectToDB();
        connection.Open();
        string Query1 = "update tbl_user set is_enabled = 'n' where user_id = " + Request["id"] + "";
        MySqlCommand command = new MySqlCommand(Query1, connection);
        command.ExecuteNonQuery();
        string Query2 = "select * from account_request where user_id = " + Request["id"] + "";
        command.CommandText = Query2;
        string request_id = "", user_email = "";
        MySqlDataAdapter adp = new MySqlDataAdapter(command.CommandText,connection);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            request_id = row["request_id"].ToString();
            user_email = row["user_email"].ToString();
        }
        SendMail("User Verification", "Alas dear user you have not been verified and cannot be a part of our community...:(", new string[] { user_email });
        string Query3 = "delete from account_request where request_id = " + request_id + "";
        command.CommandText = Query3;
        command.ExecuteNonQuery();
        Response.Redirect("index.aspx");
        connection.Close();
    }
    else
    {
        Response.Write("<script>alert('incomplete datas');document.location.href='index.aspx';</script>");
    }
%>
