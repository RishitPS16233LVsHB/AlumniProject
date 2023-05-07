<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="AlumniProject.settings" %>
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
    int DoLoginWithID(int ID, string password,ref string errormsg)
    {
        try
        {
            SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
            byte[] Bytes = Encoding.ASCII.GetBytes(password);
            byte[] HashedPassword = EncryptionAlgo.ComputeHash(Bytes);


            MySqlConnection connection = ConnectToDB();
            connection.Open();
            String query = "select count(*) from tbl_user where user_id = " + ID + " and password = '" + BitConverter.ToString(HashedPassword).Replace("-", "") + "' and  is_enabled = 'y'";
            Response.Write(query);

            errormsg = query;
            MySqlCommand command = new MySqlCommand(query, connection);
            int result = Convert.ToInt32(command.ExecuteScalar());
            Response.Write("<br><br>" + result + "<br><br>");
            CloseConnection(ref connection);

            return result;
        }
        catch (Exception error)
        {
            return 0;
        }
    }
    void ChangePassword(string OldPassword, string Password, string ConfirmPassword)
    {
        try
        {
            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
            {
                if (ConfirmPassword != Password)
                    Response.Write("<script>if(confirm('password and confirm password should be same')) document.location = 'profile.aspx';else  document.location = 'profile.aspx';</script>");

                int userID = (int)Session["user_id"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string e = "";
                int res = DoLoginWithID(userID, OldPassword,ref e);
                if (res == 1)
                {
                    SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
                    byte[] Bytes = Encoding.ASCII.GetBytes(Password);
                    byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
                    string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

                    string query = "update tbl_user set password = '" + HashedPassword + "' , modified_by = "+userID+"  where user_id = "+userID+" and is_enabled = 'y'";
                    MySqlCommand command = new MySqlCommand(query, connection);


                    if (command.ExecuteNonQuery() != 0)
                    {
                        Response.Write("<script>alert('password changed');window.open('profile.aspx','_blank').focus();window.close();</script>");
                    }
                    else
                        Response.Write("<script>alert('changes not made');window.open('homePage.aspx','_blank').focus();window.close();</script>");
                    CloseConnection(ref connection);
                }
                else
                    Response.Write("<script>alert('old password cannot be new password');window.open('homePage.aspx','_blank').focus();window.close();</script>");
            }
            else
                Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
        }
        catch (Exception error) { }
    }

    void UpdateCompanyDetails(string CompanyName,string Designation,int Package,int Experience,int Location)
    {
        try
        {
            if (Session["user_id"] != null && Session["user_id"] != "")
            {
                int UserID = (int)Session["user_id"];
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
            if (Session["user_id"] != null && (int)Session["user_id"] != -1)
            {
                int UserID = (int)Session["user_id"];
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
    void InsertIntoUserTechnologyTable(int technologyID)
    {
        try
        {
            if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
            {
                int userID = Convert.ToInt32(Session["user_id"]);
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_user_technology(technology_id,user_id,created_by,modified_by)values(" + technologyID + ","+userID+","+userID+","+userID+")";
                MySqlCommand command = new MySqlCommand(query,connection);

                if (command.ExecuteNonQuery() != 0)
                {
                    connection.Close();
                    Response.Redirect("profile.aspx");
                }
                else
                {
                    connection.Close();
                    Response.Write(query);
                }
            }
            else
                Response.Write("<script>alert('Not in Session');document.location='LogOutSession.aspx'</script>");
        }
        catch (Exception error)
        {
            Response.Write(error.Message);
        }
    }
    void InsertIntoUserExperienceTable(DateTime StartDate, DateTime EndDate, string ExperienceDescription, string ExperienceTitle)
    {
        try
        {
            if (Session["user_id"] != null && (int)Session["user_id"] != -1)
            {
                int UserID = (int)Session["user_id"];
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
        catch (Exception error) {
        }
    }
    void InsertIntoUserAchievementTable(FileUpload fileUploadControl, DateTime AchievementDate, string AchievementTitle, string AchievementDescription)
    {
        try
        {
            if (Session["user_id"] != null && (int)Session["user_id"] != -1)
            {

                int UserID = (int)Session["user_id"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_user_achievement(achievement_date,achievement_title,achievement_description,user_id,created_by,modified_by)values('" + AchievementDate.ToString("yyyy-MM-dd HH:mm:ss") + "','" + AchievementTitle + "','" + AchievementDescription + "'," + UserID + "," + UserID + "," + UserID + ")";
                MySqlCommand command = new MySqlCommand(query, connection);

                if (command.ExecuteNonQuery() != 0)
                {
                    if (fileUploadControl != null)
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


    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {


        if (Request["submit1"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit1"].ToString()))
            {
                UpdatePersonalDetails(
                                        FileUpload1,
                                        Request["username"].ToString(),
                                        Request["email"].ToString(),
                                        DateTime.Parse(Request["dob"].ToString()),
                                        Request["cnum"].ToString()
                                     );
            }
        }
        if (Request["submit2"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit2"].ToString()))
            {
                UpdateCompanyDetails(
                                        Request["company"].ToString(),
                                        Request["designation"].ToString(),
                                        Convert.ToInt32(Request["package"]),
                                        Convert.ToInt32(Request["experience"]),
                                        Convert.ToInt32(Request["location"])
                                    );
            }
        }
        if (Request["submit3"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit3"].ToString()))
            {
                ChangePassword(
                                Request["opass"].ToString(),
                                Request["pass"].ToString(),
                                Request["cpass"].ToString()
                            );
            }
        }
        if (Request["submit4"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit4"].ToString()))
            {
                InsertIntoUserExperienceTable(
                    DateTime.Parse(Request["start_date"].ToString()),
                    DateTime.Parse(Request["end_date"].ToString()),
                    Request["experience_description"].ToString(),
                    Request["experience_title"].ToString()
                                            );
            }
        }
        if (Request["submit5"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit5"].ToString()))
            {
                InsertIntoUserTechnologyTable(Convert.ToInt32(Request["technology"].ToString()));
            }
        }
        if (Request["submit6"] != null)
        {
            if (!string.IsNullOrEmpty(Request["submit6"].ToString()))
            {
                InsertIntoUserAchievementTable(
                        null,
                        DateTime.Parse(Request["achievement_date"].ToString()),
                        Request["achievement_title"].ToString(),
                        Request["achievement_description"].ToString()
                    );
            }
        }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link rel="stylesheet" href="CreatePostCss.css">

    <title>Settings </title>
    <style>
        .leftPanel {
            height: 100%;
            width: 35%;
            /* float: left; */
            /* background-color: red; */
        }

        .rightPanel {
            width: 65%;
            height: 100%;
            /* float: right; */
            background-color: red;
        }

        /* .profileImage{
            margin: 5px 10px ;
            padding: 5px 10px;
            width: 20%;
            height: 60px;
            border: 2px solid black;
            border-radius: 30px;
           
        } */
        .profileImage i {
            /* object-fit: fill; */
            font-size: xx-large
        }

        .SocialIcons {
            font-size: 23px;
            opacity: 0.7;
        }

        .SocialIcons:hover {
            opacity: 1;
            cursor: pointer;
        }

        input {
            width: 60%;
            border-top-style: hidden;
            border-right-style: hidden;
            border-left-style: hidden;
            border-bottom-style: groove;
        }

        select {
            width: 60%;
            border-top-style: hidden;
            border-right-style: hidden;
            border-left-style: hidden;
            border-bottom-style: groove;
        }

        label {
            margin-top: 5px;
        }

        .updateInformation {
            /* width: 200px; */
            border: none;
            height: 50px;
            background-color: #1c3961;
            border: 2px solid white;
            color: white;
            /* float: right; */
            font-weight: 600;
            cursor: pointer;
            /* margin-top: 10px; */
            transition-duration: 0.7s;
            margin-bottom: 20px;
        }

        .updateInformation:hover {
            background-color: white;
            border: 3px solid #1c3961;
            color: #1c3961;
        }

        .passwordForm {
            margin-bottom: 20px;
        }

        .nav-link {
            color: #1c3961;
            font-weight: 600;
        }

        .nav-link:hover {
            color: #1c3961;
            /* font-weight: 600; */
        }

        .nav-tabs .nav-item .nav-link {
            background-color: #0080FF;
            color: #FFF;
        }

        .nav-tabs .nav-item .nav-link.active {
            color: #1c3961;
            /* color: red; */

        }

        .nav-pills .nav-link.active,
        .nav-pills .show>.nav-link {
            color: #fff;
            /* background-color: #007bff; */
            background-color: #1c3961;
            box-shadow: rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px;
        }

        .tab-content {
            border: 1px solid white;
            border-top: transparent;
            padding: 15px;
        }
    </style>
</head>

<body>
<%  
%>    

    <div class="row comment-box-main-job2 p-4 rounded-bottom" style = "color : black">
        <a href="profile.aspx"> <img class="BackButton" src="HomePage_images/BackButton.png" style="
        width: 50px; height: 50px; padding-left: 3px; filter: grayscale(100%);"> </a>
        <h2 class="ml-4">Settings</h2>
    </div>

    <div class="container" style="box-shadow: rgba(0, 0, 0, 0.2) 0px 60px 40px -7px;background-color: rgb(239, 244, 253);">
        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="true">Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-company-tab" data-toggle="pill" href="#pills-company" role="tab" aria-controls="pills-company" aria-selected="false">Company Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-account-tab" data-toggle="pill" href="#pills-account" role="tab" aria-controls="pills-account" aria-selected="false">Change Password</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-bio-tab" data-toggle="pill" href="#pills-bio" role="tab" aria-controls="pills-bio" aria-selected="false">Bio</a>
            </li>
        </ul>
        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active row" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
            <div class=" row">
                <!-- <div class="col mb-5" style="max-width: 100%;">
                    <div class="profileImage  mt-4">
                        <img src="images/userImage.png" alt="" height="80px">
                    </div>
                    <h5 class="mt-3 ">Update Picture</h5>
                    <form action="" class="socialLinks">
                        <i class="fa-brands fa-facebook  mb-1 mt-4 mr-2 SocialIcons"></i> <input type="link" placeholder="Facebook" border-bottom-style: groove; border:none;"><br>
                        <i class="fa-brands fa-github  mb-1 mt-4 SocialIcons mr-2"></i> <input type="link" placeholder="Github"><br>
                        <i class="fa-brands fa-linkedin  mb-1 mt-4 mr-2 SocialIcons"></i> <input type="link" placeholder="LinkedIn"><br>
                    </form>
                    <i class="fa-brands fa-facebook ml-4 mb-2 mt-4 mr-2 SocialIcons"></i> <input type="link" placeholder="Link Facebook" style="outline:none;border-top-style: hidden; border-right-style: hidden; border-left-style: hidden; border-bottom-style: groove; border:none;">
                </div> -->
                <div class="col" style="max-width: 100%;" >
                    <form action="#" method="post" runat="server" enctype="multipart/form-data">
                        <b><label for="username">Username</label></b><br>
                        <input type="text" id="username" name="username" runat="server" placeholder="Username"> <br>
                        <b><label for="email">Email</label></b><br>
                        <input type="email" id="email" name="email" runat="server" placeholder="Email"><br>
                        <b><label for="number">Number</label></b><br>
                        <input type="tel" id="cnum" name="cnum" runat="server" placeholder="Change Number"><br>
                        <b><label for="dob">Birth Date</label></b><br>
                        <input type="date" id="dob" name="dob" runat="server"><br>
                        <b><label for="city">Profile photo</label></b><br>
                        <asp:FileUpload ID="FileUpload1" runat="server" /><br>
                        <br>
                        <input id="submit1" type="submit" runat="server" style = "padding-left:20%;padding-right:20%" class="mt-4 updateInformation"  value="Update!"> 
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="pills-company" role="tabpanel" aria-labelledby="pills-company-tab">
        <form action="#" method="post">
            <div class="row">
                <div class="col mb-5" style="max-width: 100%;">
                    <!-- <h2>prfile picture here</h2> -->
                    <div class="profileImage  mt-4">
                        <img src="images/userImage.png" alt="" height="80px">
                    </div>

                        <b><label for="companyName">Company Name</label></b><br>
                        <input type="text" runat="server"  id="company" name="company" placeholder="Company name" required><br>
                        <b><label for="jobTitle">Job Title</label></b><br>
                        <select id="designation" name="designation" required>
							<% 
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
                                DisplayJobTitleInDropDown();
                                %>
						</select><br>   
                        <b><label for="package">Average Package</label></b><br>
                        <input type="number" runat="server" min="1" id="package" name="package" required><br>
                </div>
                <div class="col ml-0 " style="max-width: 100%;">

                        <b><label for="workPlace">Place of work</label></b><br>
                        <select name="location" id="location" required>
							<% 
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
                                DisplayPlaceOfWorkInDropDown();
                             %>
						</select><br>
                        <b><label for="experience">Experience (years)</label></b><br>
                        <input type="number" runat="server" id="experience" name="experience" min="1" max="15" placeholder="Experience submitter must have?" required><br>
                        <br>
                        <input type="submit" runat="server" id="submit2" style = "padding-left:20%;padding-right:20%" class="mt-4 updateInformation" value="Update!"> 
                    </div>  
                </div>
            </form>
        </div>
        <div class="tab-pane fade" id="pills-account" role="tabpanel" aria-labelledby="pills-account-tab">
            <div class="container">
                <form action="#" class="passwordForm  mb-4" method="post">
                    <b><label for="opass">Old Password</label></b><br>
                    <input type="password" id="opass" name="opass" placeholder="Enter old password you remember" required><br>
                    <b><label for="pass">New Password</label></b><br>
                    <input type="password" id="pass" name="pass" placeholder="Enter your new password" required><br>
                    <b><label for="cpass">Confirm new password</label></b><br>
                    <input type="password" id="cpass" name="cpass" placeholder="Re-enter new password" required><br>
                    <br>
                    <input type="submit" id="submit3" runat="server" class="mt-4 updateInformation" value="Change Password">
                </form>
            </div>

        </div>
        <div class="tab-pane fade" id="pills-bio" role="tabpanel" aria-labelledby="pills-bio-tab">
            <div class="row">
                <div class="col " style="max-width: 100%;">
                    <h3 style="color: #1c3961;">Add Experience</h3>
                    <form action="#" class="passwordForm" method = "post">
                        <b><label for="Company">Experience title</label></b><br>
                        <input type="text" id="experience_title" runat="server" name="exptitle" placeholder="Describe your experience" required><br>
                        <b><label for="startdate">Start Date</label></b><br>
                        <input type="date" id="start_date" runat="server" name="startdate" placeholder="Enter start date of your job" required><br>
                        <b><label for="enddate">End Date</label></b><br>
                        <input type="date" id="end_date" runat="server" name="enddate" placeholder="Enter end date of your job"><br>
                        <b><label for="expdescription">Description</label></b> <br>
                        <textarea name="expdescription" runat="server" id="experience_description" cols="30" rows="5" placeholder="Enter 200 words about this experience" required></textarea>
                        <br>
                        <input type="submit" runat="server" id="submit4" class="mt-4 updateInformation" value=" Add experiences!">
                    </form>
                </div>
                <div class="col " style="max-width: 100%;">
                    <h3 style="color: #1c3961;">Add Skills</h3>
                    <form action="#" method="post" class="passwordForm ">
                        <h4>Tech Skills</h4>
                        <b><label for="techSkill">Skill</label></b><br>
                        <select id="technology" name="technology" required>
						    <%                                
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
                                DisplayTechnologyInDropDown();
                                %>
						</select>
                        <br>
                        <input type="submit" id="submit5" runat="server" class="mt-4 updateInformation" value="Add tech skills! "> 
                    </form>
                </div>
                <div class="col " style="max-width: 100%;">
                    <h3 style="color: #1c3961;">Add Achievements</h3>
                    <form action="#" class="passwordForm" method="post" enctype = "multipart/form-data" >                        
                        <b><label for="achievementtitle">Achievement title</label></b><br>
                        <input type="text" runat="server" id="achievement_title" name="achievementtitle" placeholder="Describe your achievment" required><br>
                        <b><label for="achievementdate">Achievement Date</label></b><br>
                        <input type="date" runat="server" id="achievement_date" name="achievementdate" required><br>
                        <b><label for="achievementdescription">Description</label></b><br>
                        <textarea name="achievementdescription" runat="server" id="achievement_description" cols="30" rows="3" placeholder="Tell us something about your achievements" required></textarea><br>
                        <b><label for="file">Certificate</label></b><br>
                        <input type="submit" id="submit6" runat="server" class="mt-4 updateInformation" value="Add Achievments! ">
                    </form>
                </div>
            </div>

        </div>
    </div>
    </div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html><%} %>