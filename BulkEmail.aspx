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
            smtpClient.Credentials = new System.Net.NetworkCredential("rishitselia@gmail.com", "tovaulsdwxhxnszc");
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


%>

<%

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

        try
        {
            if (Request["mail_body"] != null && Request["mail_subject"] != null)
            {
                MySqlConnection Connection = ConnectToDB();
                if (Connection == null)
                    Response.Write("not connected");
                else
                {
                    Connection.Open();
                    string Query = "select Email_ID from tbl_user";
                    string[] email = { " " };
                    MySqlDataAdapter adp = new MySqlDataAdapter(Query, Connection);
                    DataTable EmailIDs = new DataTable();
                    adp.Fill(EmailIDs);

                    foreach (DataRow rows in EmailIDs.Rows)
                        email.Append<string>(rows["Email_ID"].ToString());

                    Connection.Close();
                    if (SendMail(Request["mail_subject"], Request["mail_body"], email))
                        Response.Write("<script>alert('mail sent successfully')</script>");
                    else
                        Response.Write("<script>alert('mail not sent')</script>");
                }
            }
        }
        catch (Exception exception)
        {
            Response.Write("not found the db " + exception.Message);
        }
    }
%>