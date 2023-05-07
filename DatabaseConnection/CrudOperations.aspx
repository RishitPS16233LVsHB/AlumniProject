<%@ Page Language="C#" %>

<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.Security.Cryptography" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="System.Text.RegularExpressions" %>


<%
    void DeleteFromOTPTable(int OTPID)
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "delete from tbl_otp_information where otpid = " + OTPID;
            MySqlCommand command = new MySqlCommand(Query, connection);
            command.ExecuteNonQuery();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        {
        }
    }

    void InsertIntoPostTable(string Title, string Description, FileUpload fileUploadControl)
    {
        try
        {
            if (Session["user_id"] != null)
            {
                if ((int)Session["user_id"] != -1 || !string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    if (Title != "" && Description != "")
                    {
                        int UserID = (int)Session["user_id"];
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();
                        string Query = "insert into tbl_community_post" +
                                    "(post_title,content,user_id,created_by,modified_by)" +
                                    "values" +
                                    "('" + Title + "','" + Description + "'," + UserID + "," + UserID + "," + UserID + ")";
                        MySqlCommand command = new MySqlCommand(Query, connection);
                        command.ExecuteNonQuery();
                        long LastInsertID = command.LastInsertedId;

                        // if there is an image file
                        if (fileUploadControl.FileName != null || fileUploadControl.FileName != "")
                        {
                            string EnrollmentNumber = Session["enrollment_number"].ToString();
                            string Path = Server.MapPath("Uploads//" + UserID + "-User-" + EnrollmentNumber + "//" + fileUploadControl.FileName);

                            string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                            Regex rx = new Regex(Pattern);

                            if (rx.IsMatch(fileUploadControl.FileName))
                            {
                                Query = "update tbl_community_post set post_image = '" + Path + "' where community_post_id = " + LastInsertID + "";
                                command.CommandText = Query;
                                command.ExecuteNonQuery();
                                fileUploadControl.SaveAs(Path);
                            }
                            else
                                Response.Write("<script>if(confirm('only image files allowed')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");

                        }
                        CloseConnection(ref connection);
                    }
                    else
                        Response.Write("<script>if(confirm('Post Title or Description empty')) document.location = 'CreatePost.aspx';else  document.location = 'CreatePost.aspx';</script>");
                }
                else
                    Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error)
        { }
    }

    void InsertIntoEventParticipationTable(int EventID)
    {
        try
        {
            if (Session["user_id"] != null)
            {
                if ((int)Session["user_id"] != -1 || !string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    if (EventID > 0)
                    {
                        int UserID = (int)Session["user_id"];
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();

                        string Query = "select count(event_participation_id) from tbl_event_participation where participant_id = " + UserID + " and event_id = " + EventID + " and is_enabled = 'y'";
                        MySqlCommand command = new MySqlCommand(Query, connection);
                        int TotalRows = (int)command.ExecuteScalar();

                        if (TotalRows > 0)
                            Response.Write("<script>if(confirm('Already Participated in that Event')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                        else
                        {
                            Query = "insert into tbl_event_participation(event_id,participant_id,created_by,modified_by)values(" + EventID + "," + UserID + "," + UserID + "," + UserID + ")";
                            command.CommandText = Query;
                            command.ExecuteNonQuery();
                        }
                        CloseConnection(ref connection);
                    }
                    else
                        Response.Write("<script>if(confirm('Event not found')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                }
                else
                    Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error)
        { }
    }

    void InsertIntoJobApplyTable(int JobAlertID)
    {
        try
        {
            if (Session["user_id"] != null)
            {
                if ((int)Session["user_id"] != -1 || !string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    if (JobAlertID > 0)
                    {
                        int UserID = (int)Session["user_id"];
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();

                        string Query = "select count(job_apply_id) from tbl_job_apply where applicant_id = " + UserID + " and job_alert_id = " + JobAlertID + " and is_enabled = 'y' ";
                        MySqlCommand command = new MySqlCommand(Query, connection);
                        int TotalRows = (int)command.ExecuteScalar();

                        if (TotalRows > 0)
                            Response.Write("<script>if(confirm('Already Participated in that Event')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                        else
                        {
                            Query = "insert into tbl_job_apply(job_alert_id,applicant_id,created_by,modified_by)values(" + JobAlertID + "," + UserID + "," + UserID + "," + UserID + ")";
                            command.CommandText = Query;
                            command.ExecuteNonQuery();
                        }
                        CloseConnection(ref connection);
                    }
                    else
                        Response.Write("<script>if(confirm('Job Alert not found')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                }
                else
                    Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error)
        { }
    }

    void ActivateAccount(int UserID)
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "update tbl_user set is_enabled = 'y' where user_id = " + UserID + "";
            MySqlCommand command = new MySqlCommand(Query, connection);
            command.ExecuteNonQuery();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        { }
    }

    void DisplayJobTitleInDropDown()
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select job_title_id,job_title from tbl_job_title where is_enabled = 'y'";
            MySqlCommand command = new MySqlCommand(Query, connection);

            MySqlDataReader DTR = command.ExecuteReader();

            if (DTR.HasRows)
                while (DTR.Read())
                    Response.Write("<option value=\"" + DTR.GetInt32(0) + "\">" + DTR.GetString(1) + "</option>");
            DTR.Close();
            DTR.Dispose();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        { }
    }

    void DisplayBatchInDropDown()
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select batch_id,batch_name from tbl_batch where is_enabled = 'y'";
            MySqlCommand command = new MySqlCommand(Query, connection);

            MySqlDataReader DTR = command.ExecuteReader();

            if (DTR.HasRows)
                while (DTR.Read())
                    Response.Write("<option value=\"" + DTR.GetInt32(0) + "\">" + DTR.GetString(1) + "</option>");
            DTR.Close();
            DTR.Dispose();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        { }
    }

    void DisplayTechnologyInDropDown()
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select technology_id,technology_name from tbl_technology where is_enabled = 'y'";
            MySqlCommand command = new MySqlCommand(Query, connection);

            MySqlDataReader DTR = command.ExecuteReader();

            if (DTR.HasRows)
                while (DTR.Read())
                    Response.Write("<option value=\"" + DTR.GetInt32(0) + "\">" + DTR.GetString(1) + "</option>");
            DTR.Close();
            DTR.Dispose();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        { }
    }

    void DisplayPlaceOfWorkInDropDown()
    {
        try
        {
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select place_of_work_id,place_of_work from tbl_place_of_work where is_enabled = 'y'";
            MySqlCommand command = new MySqlCommand(Query, connection);

            MySqlDataReader DTR = command.ExecuteReader();

            if (DTR.HasRows)
                while (DTR.Read())
                    Response.Write("<option value=\"" + DTR.GetInt32(0) + "\">" + DTR.GetString(1) + "</option>");
            DTR.Close();
            DTR.Dispose();
            CloseConnection(ref connection);
        }
        catch (Exception error)
        { }
    }

    void InsertIntoEventTable(FileUpload fileUploadControl, string EventTitle, string EventDescription, string OrganizerName, DateTime EventTime, string Venue, string Contact1, string Contact2, string Email1, string Email2)
    {
        try
        {
            if (Session["userid"] != null && (int)Session["userid"] != -1)
            {
                int userID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_event(" +
                            "event_name" +
                            "event_description" +
                            "organizer_name" +
                            "venue" +
                            "email_address_1" +
                            "email_address_2" +
                            "contact_number_1" +
                            "contact_number_2" +
                            "event_time" +
                            "organizing_member_id" +
                            "created_by" +
                            "modified_by)" +
                "values('" + EventTitle + "','" + EventDescription + "','" + OrganizerName + "','" + Venue + "','" + Email1 + "','" + Email2 + "','" + Contact1 + "','" + Contact2 + "','" + EventTime.ToString("yyyy-MM-dd HH:mm:ss") + "'," + userID + "," + userID + "," + userID + ")";
                MySqlCommand command = new MySqlCommand(query, connection);

                if (command.ExecuteNonQuery() != 0)
                {
                    long EventID = command.LastInsertedId;
                    if (fileUploadControl.FileName != null && fileUploadControl.FileName != "")
                    {
                        string enrollment_number = Session["enrollment_number"].ToString();
                        string path = Server.MapPath("Uploads//" + userID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                        string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                        Regex rx = new Regex(Pattern);

                        if (rx.IsMatch(fileUploadControl.FileName))
                        {
                            query = "update tbl_event set Event_Photo = '" + path + "' where event_id  = " + EventID + "";
                            command.CommandText = query;
                            command.ExecuteNonQuery();
                            fileUploadControl.SaveAs(path);
                        }
                        else
                            Response.Write("<script>if(confirm('only image files allowed')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                    }
                    Response.Redirect("homePage.aspx");
                }
                else
                    Response.Write("<script>if(confirm('server error please retry')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");

                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    int DoLoginWithID(int ID, string password)
    {
        try
        {
            SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
            byte[] Bytes = Encoding.ASCII.GetBytes(password);
            byte[] HashedPassword = EncryptionAlgo.ComputeHash(Bytes);

            if (Session["user_id"] != null && (int)Session["user_id"] != -1)
            {
                int UserID = (int)Session["user_id"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                String query = "select count(*) from tbl_user where user_id = " + UserID + " and password = '" + BitConverter.ToString(HashedPassword).Replace("-", "") + "' and  is_enabled = 'y'";
                MySqlCommand command = new MySqlCommand(query, connection);
                int result = (int)command.ExecuteScalar();
                CloseConnection(ref connection);

                if (result == 1)
                    return 1;
                else
                    return 0;
            }
            else
                return 0;
        }
        catch (Exception error)
        {
            return 0;
        }
    }

    int DoLogin(string enrollment_number, string password)
    {
        try
        {
            SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
            byte[] Bytes = Encoding.ASCII.GetBytes(password);
            byte[] HashedPassword = EncryptionAlgo.ComputeHash(Bytes);

            MySqlConnection connection = ConnectToDB();
            connection.Open();
            String query = "select count(*) from tbl_user where enrollment_number = " + enrollment_number + " and password = '" + BitConverter.ToString(HashedPassword).Replace("-", "") + "' and  is_enabled = 'y'";
            MySqlCommand command = new MySqlCommand(query, connection);
            int result = (int)command.ExecuteScalar();
            CloseConnection(ref connection);

            if (result == 1)
                return 1;
            else
                return 0;
        }
        catch (Exception error)
        {
            return 0;
        }
    }
    void InsertIntoJobAlertTable(string jobAlertTitle, string jobAlertDescription, string company, int location, int technology, int designation, int vacancies, int package, int experience, string cnum, string email)
    {
        try
        {
            if (Session["userid"] != null && (int)Session["userid"] != -1)
            {
                int UserID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_job_alert(job_alert_title,job_description,company_name,company_email,company_contact_number,vacancies,experience,package,technology_id,place_of_work_id,job_title_id,created_by,modified_by)" +
                "values" +
                "('" + jobAlertTitle + "','" + jobAlertTitle + "','" + company + "'," +
                "'" + email + "','" + cnum + "'," + vacancies + "," + experience + "," + package + "," + technology + "," + location + "," + designation + "," + UserID + "," + UserID + ");";
                MySqlCommand command = new MySqlCommand(query, connection);


                if (command.ExecuteNonQuery() != 0)
                    Response.Redirect("homePage.aspx");
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");

                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    int InsertIntoUserTable(FileUpload fileUploadControl, string username, string en_no, DateTime dob, char gender, string Current_Company, string contact_num, string email_id, string pass, int job, int work, int batch)
    {
        try
        {
            int UserID = 0;
            // we take a guess that every detail passed to this function is correct
            MySqlConnection connection = ConnectToDB();
            connection.Open();
            string Query = "select count(*) from tbl_user where enrollment_number = '" + en_no + "'";
            MySqlCommand command = new MySqlCommand(Query, connection);
            int TotalRows = (int)command.ExecuteScalar();

            if (TotalRows >= 1)
            {
                CloseConnection(ref connection);
                Response.Write("<script>if(confirm('User already exists')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                return 0;
            }
            else
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
                        "place_of_work_id,batch_id,Created_by,Modified_by,is_enabled)" +
                        "values('" + username + "'" + en_no + "','" + dob.ToString("yyyy-MM-dd HH:mm:ss") + "','" + gender + "','','" + Current_Company + "','" + contact_num + "','" + email_id + "','" + HashedPassword + "'," + job + "," + work + "," + batch + ",2,2,'n')";

                command.CommandText = Query;
                if (command.ExecuteNonQuery() != 0)
                {
                    UserID = (int)command.LastInsertedId;
                    Session["userid"] = UserID;
                    // now make the folder and store the profile photo there
                    CreateDirectory(UserID + "-User-" + en_no);
                    string enrollment_number = Session["enrollment_number"].ToString();
                    string path = Server.MapPath("Uploads//" + UserID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                    string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                    Regex rx = new Regex(Pattern);

                    if (rx.IsMatch(fileUploadControl.FileName))
                    {
                        Query = "update tbl_user set profile_photo_path = '$path' where user_id = $userID";
                        command.CommandText = Query;
                        command.ExecuteNonQuery();
                        CloseConnection(ref connection);
                        fileUploadControl.SaveAs(path);
                    }
                    else
                    {
                        Response.Write("<script>if(confirm('only image formats are allowed')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                        CloseConnection(ref connection);
                        return 0;
                    }
                }
                else
                {
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                    CloseConnection(ref connection);
                    return 0;
                }
                return UserID;
            }
        }
        catch (Exception error)
        {
            Response.Write("<br>" + error.StackTrace + "---" + error.Message + "<br>");
            return 0;
        }
    }

    void InsertIntoUserExperienceTable(DateTime StartDate, DateTime EndDate, string ExperienceDescription, string ExperienceTitle)
    {
        try
        {
            if (Session["userid"] != null && (int)Session["userid"] != -1)
            {
                int UserID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                string query = "insert into tbl_user_Experience(start_date,end_date,experience_description,experience_title,user_id,created_by,modified_by)values('" + StartDate.ToString("yyyy-MM-dd HH:mm:ss") + "','" + EndDate.ToString("yyyy-MM-dd HH:mm:ss") + "','" + ExperienceDescription + "','" + ExperienceTitle + "'," + UserID + "," + UserID + "," + UserID + ")";
                MySqlCommand command = new MySqlCommand(query, connection);
                connection.Open();
                if (command.ExecuteNonQuery() != 0)
                    Response.Redirect("profile.aspx");
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }
    void InsertIntoUserAchievementTable(FileUpload fileUploadControl, DateTime AchievementDate, string AchievementTitle, string AchievementDescription)
    {
        try
        {
            if (Session["userid"] != null && (int)Session["userid"] != -1)
            {

                int UserID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_user_achievement(achievement_date,achievement_title,achievement_description,user_id,created_by,modified_by)values('" + AchievementDate.ToString("yyyy-MM-dd HH:mm:ss") + "','" + AchievementTitle + "','" + AchievementDescription + "'," + UserID + "," + UserID + "," + UserID + ")";
                MySqlCommand command = new MySqlCommand(query, connection);

                if (command.ExecuteNonQuery() != 0)
                {
                    if (fileUploadControl.FileName != null && fileUploadControl.FileName != "")
                    {
                        long UserAchievementID = command.LastInsertedId;
                        string enrollment_number = Session["enrollment_number"].ToString();
                        string path = Server.MapPath("Uploads//" + UserID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                        string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                        Regex rx = new Regex(Pattern);
                        if (rx.IsMatch(fileUploadControl.FileName))
                        {
                            query = "update tbl_user_achievement set certificate_path = '" + path + "' where user_achievement_id = " + UserAchievementID + "";
                            command.CommandText = query;
                            command.ExecuteNonQuery();
                            fileUploadControl.SaveAs(path);
                        }
                        else
                            Response.Write("<script>if(confirm('only image formats are allowed')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                    }
                    Response.Redirect("profile.aspx");
                }
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    void ChangePassword(string OldPassword, string Password, string ConfirmPassword)
    {
        try
        {
            if (Session["userid"] != null && Session["userid"] != "")
            {
                if (ConfirmPassword != Password)
                    Response.Write("<script>if(confirm('password and confirm password should be same')) document.location = 'profile.aspx';else  document.location = 'profile.aspx';</script>");

                int userID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();

                if (DoLoginWithID(userID, OldPassword) == 1)
                {
                    SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
                    byte[] Bytes = Encoding.ASCII.GetBytes(Password);
                    byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
                    string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

                    string query = "update tbl_user set password = '" + HashedPassword + "' , modified_by = $userID  where user_id = $userID and is_enabled = 'y'";
                    MySqlCommand command = new MySqlCommand(query, connection);

                    if (command.ExecuteNonQuery() != 0)
                        Response.Redirect("profile.aspx");
                    else
                        Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                    CloseConnection(ref connection);
                }
                else
                    Response.Write("<script>if(confirm('old password and user id does not match')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
            }
            else
                Response.Write("<script>if(confirm('not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    void UpdateCompanyDetails(string CompanyName,string Designation,int Package,int Experience,int Location)
    {
        try
        {
            if (Session["userid"] != null && Session["userid"] != "")
            {
                int UserID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "update tbl_user set current_company_working_in = '" + CompanyName + "' , job_title_id = " + Designation + " , salary = " + Package + ", Experience = " + Experience + ", Place_Of_Work_Id = " + Location + ", modified_by = " + UserID + " where user_id = " + UserID + " and is_enabled = 'y'";
                MySqlCommand command = new MySqlCommand(query, connection);

                if (command.ExecuteNonQuery() != 0)
                    Response.Redirect("profile.aspx");
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    void UpdatePersonalDetails(FileUpload fileUploadControl,string Username,string EmailID,DateTime DateOfBirth,string Contact)
    {
        try
        {
            if (Session["userid"] != null && (int)Session["userid"] != -1)
            {
                int UserID = (int)Session["userid"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "update tbl_user set user_name = '" + Username + "' , email_id = '" + EmailID + "' , date_of_birth = '" + DateOfBirth.ToString("yyyy-MM-dd HH:mm:ss") + "' , Contact_Number = '" + Contact + "' , modified_by = " + UserID + " where user_id = " + UserID + "";
                MySqlCommand command = new MySqlCommand(query, connection);

                if (command.ExecuteNonQuery() != 0)
                {
                    if (fileUploadControl.FileName != null && fileUploadControl.FileName != "")
                    {
                        long EventID = command.LastInsertedId;
                        string enrollment_number = Session["enrollment_number"].ToString();
                        string path = Server.MapPath("Uploads//" + UserID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                        string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                        Regex rx = new Regex(Pattern);

                        if (rx.IsMatch(fileUploadControl.FileName))
                        {
                            query = "update tbl_user set profile_photo_path = '" + path + "' where user_id  = " + UserID + " and is_enabled = 'y'";
                            command.CommandText = query;
                            command.ExecuteNonQuery();
                            fileUploadControl.SaveAs(path);
                        }
                        else
                            Response.Write("<script>if(confirm('only image formats allowed')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                    }
                    Response.Redirect("profile.aspx");
                }
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'homePage.aspx';else  document.location = 'homePage.aspx';</script>");
                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        } catch (Exception error){ }
    }
%>