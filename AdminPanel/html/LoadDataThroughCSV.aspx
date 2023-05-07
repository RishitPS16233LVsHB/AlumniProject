<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadDataThroughCSV.aspx.cs" Inherits="AlumniProject.AdminPanel.html.LoadDataThroughCSV" %>


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
    void CreateDirectory(string UserID)
    {
        try
        {
            Response.Write("<br><br>"+Server.MapPath("Uploads/" + UserID)+"<br><br>");
            Directory.CreateDirectory(Server.MapPath("/Uploads/" + UserID));
        }
        catch (Exception error) { Response.Write(error.Message); }
    }


    void InsertBulkStudents(string CSVData)
    {
        List<string> Emails = new List<string>();

        string[] LinesInFile = CSVData.Split('\n');

        LinesInFile[0] = "";
        foreach (string s in LinesInFile)
            if (s != "")
            {
                string[] Values = s.Split(',');
                Emails.Add(Values[1]);
                Values[2].Replace('e', ' ').Trim();
                InsertIntoUserTable(Values[0],Values[2].Replace('e', ' ').Trim(),DateTime.Parse(Values[3]),Values[5][0],"",Values[4],Values[1],"password",1,1,1,1,1);
                Response.Write(Values[0]+ "   " + Values[2].Replace('e', ' ').Trim()+ "   " + DateTime.Parse(Values[3]).ToString() + "   " + Values[5][0]+ "   " + ""+ "   " + Values[4]+ "   " + Values[1]+ "   " + "password"+ "   " + 1+ "   " + 1 + "   " + 1+ "   " + 1 + "   " + 1);
                Response.Write("<br>");
            }

        string htmlContent = "<html><body><h1> Automatic enrollment into Alumni association system </h1><p> Hey there you are now part of BMIIT's Alumni association system program to enter into your account please enter your respective enrollment number and for password enter \"password\"</p></body></html >";
        string subject = "Auto enrollment into BMIIT's Alumni association system";
        SendMail(subject,htmlContent,Emails.ToArray(),true);
    }



    void InsertIntoUserTable(string username, string en_no, DateTime dob, char gender, string Current_Company, string contact_num, string email_id, string pass, int job, int work, int batch, int experience,int utype)
    {
        try
        {
            long UserID = 0;
            // we take a guess that every detail passed to this function is correct
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select count(*) from tbl_user where enrollment_number = '" + en_no + "'";
            MySqlCommand command = new MySqlCommand(Query, connection);
            int TotalRows = Convert.ToInt32(command.ExecuteScalar());

            if(TotalRows == 0)
            {
                SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
                byte[] Bytes = Encoding.ASCII.GetBytes(pass);
                byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
                string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

                Query = "insert into tbl_user" +
                        "(user_name,enrollment_number,date_of_birth," +
                        "gender,profile_photo_path," +
                        "current_company_working_in,contact_number," +
                        "email_id,password,job_title_id," +
                        "place_of_work_id,batch_id,experience,Created_by,Modified_by,is_enabled,user_type)" +
                        "values('" + username + "','" + en_no + "','" + dob.ToString("yyyy-MM-dd HH:mm:ss") + "','" + gender + "','','" + Current_Company + "','" + contact_num + "','" + email_id + "','" + HashedPassword + "'," + job + "," + work + "," + batch + "," + experience + ",2,2,'y',"+utype+")";


                Response.Write("<br><br>" + Query + "<br><br>");
                command.CommandText = Query;

                if (command.ExecuteNonQuery() != 0)
                {
                    UserID = command.LastInsertedId;
                    Response.Write(UserID + "-User-" + en_no + "<br><br>");
                    CreateDirectory(UserID + "-User-" + en_no);
                    connection.Close();
                    return;
                }
                else
                {
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                    connection.Close();
                    return;
                }
            }
        }
        catch (Exception error)
        {
            Response.Write("<br>" + error.StackTrace + "---" + error.Message + "<br>");
        }
    }

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <input type="submit" id="submit" runat="server" />
        </div>
    </form>
</body>
</html>

<%

        if (Request["submit"] != null)
        {
            if(FileUpload1.HasFile)
            {
                //String ext = Path.GetExtension(FileUpload1.FileName);
                ////Response.Write(ext);
                //if (ext != "csv")
                //{
                //    Response.Write("<p style='color: red;'>Upload files with .csv extensions only</p>");
                //}
                //else
                //{
                using (StreamReader stream = new StreamReader(FileUpload1.PostedFile.InputStream))
                {
                    // read file data
                    string FileData = stream.ReadToEnd();
                    InsertBulkStudents(FileData);
                    //Response.Redirect("index.aspx");
                }
            

        }
    }
%>
