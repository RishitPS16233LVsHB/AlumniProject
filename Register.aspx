<%@ Page Language="C#"%>

<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="System.Net.Mail" %>


<%

    bool SendMail(string subject, string body, string[] recipients, bool isHtml = true)
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

            foreach (string mailID in recipients)
                mail.To.Add(new MailAddress(mailID));

            mail.Subject = subject;
            mail.IsBodyHtml = isHtml;
            mail.Body = body;

            smtpClient.Send(mail);
            return true;
        }
        catch (Exception error) { Response.Write(error.Message); return false; }
    }


    void CreateDirectory(string UserID)
    {
        try
        {
            Directory.CreateDirectory(Server.MapPath("Uploads/" + UserID));
        }
        catch (Exception error) { }
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

    void CloseConnection(ref MySqlConnection connection)
    {
        try
        {
            if (connection != null)
                connection.Close();
        }
        catch (Exception error)
        { }
    }
    long InsertIntoUserTable(FileUpload fileUploadControl, string username, string en_no, DateTime dob, char gender, string Current_Company, string contact_num, string email_id, string pass, int job, int work, int batch, int experience, int utype)
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

            if (TotalRows >= 1)
            {
                connection.Close();
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
                        "place_of_work_id,batch_id,experience,Created_by,Modified_by,is_enabled,user_type)" +
                        "values('" + username + "','" + en_no + "','" + dob.ToString("yyyy-MM-dd HH:mm:ss") + "','" + gender + "','','" + Current_Company + "','" + contact_num + "','" + email_id + "','" + HashedPassword + "'," + job + "," + work + "," + batch + "," + experience + ",2,2,'n'," + utype + ")";


                //Response.Write("<br><br>" + Query + "<br><br>");
                command.CommandText = Query;
                if (command.ExecuteNonQuery() != 0)
                {
                    UserID = command.LastInsertedId;
                    Session["userid"] = UserID;
                    Session["enrollment_number"] = en_no;
                    Session["user_type"] = 1;
                    Session["registered_user_email"] = email_id;
                    // now make the folder and store the profile photo there    
                    CreateDirectory(UserID + "-User-" + en_no);
                    string enrollment_number = en_no;
                    string path = Server.MapPath("Uploads//" + UserID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                    string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                    Regex rx = new Regex(Pattern);

                    path = path.Replace("\\", "/");
                    Response.Write("<br><br>" + path + "<br><br>");
                    if (fileUploadControl.FileName != null && fileUploadControl.FileName != "")
                    {
                        if (rx.IsMatch(fileUploadControl.FileName))
                        {
                            Query = "update tbl_user set profile_photo_path = '" + path + "' where user_id = " + UserID + "";
                            command.CommandText = Query;
                            command.ExecuteNonQuery();
                            connection.Close();
                            fileUploadControl.SaveAs(path);
                        }
                        else
                        {
                            Response.Write("<script>if(confirm('only image formats are allowed')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                            connection.Close();
                            return 0;
                        }
                    }
                }
                else
                {
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
                    connection.Close();
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



    if (Request["submit"] != null)
    {

        Response.Write("here");
        try
        {
            Response.Write("<br><br>" + (Request["c_pass"] == null) + "<br><br>");

            string first_name = Request["first_name"];
            string last_name = Request["last_name"];
            string contact = Request["phone"];
            string email = Request["email_id"];
            string password = Request["pass_word"];
            string confirm_password = Request["c_pass"];
            string enrollment_number = Request["enrollment_number"];
            char gender = 'm';
            if (Request["f"] != null)
                gender = 'f';
            string date_of_birth = Request["date_of_birth"];
            string current_company = Request["current_company"];
            int technology_id = Convert.ToInt32(Request["technology"]);
            int experience = Convert.ToInt32(Request["experience"]);
            int batch = Convert.ToInt32(Request["batch"]);
            int designation = Convert.ToInt32(Request["designation"]);
            int location = Convert.ToInt32(Request["location"]);
            int uType = Convert.ToInt32(Request["user_type"]);

            Response.Write("<br>password" + Request["c_pass"] + "<br><br>");


            //Response.Write("first name:- " + (string.IsNullOrEmpty(first_name)) + "last name:- " + (string.IsNullOrEmpty(last_name)) + "password:- " + (string.IsNullOrEmpty(confirm_password)) + "email:- " + (string.IsNullOrEmpty(email)) + "enrollment_number:- " + (string.IsNullOrEmpty(enrollment_number)) + "date of birth " + (string.IsNullOrEmpty(date_of_birth)) + "contact:- " + (string.IsNullOrEmpty(contact)) + "current company:- " + (string.IsNullOrEmpty(current_company)));
            //Response.Write(string.IsNullOrEmpty(email) + " <" + email + ">");
            //Response.Write(string.IsNullOrEmpty(password) + " <" + password + ">");
            if
            (
                (string.IsNullOrEmpty(first_name)) ||
                (string.IsNullOrEmpty(last_name)) ||
                (string.IsNullOrEmpty(confirm_password)) ||
                (string.IsNullOrEmpty(email)) ||
                (string.IsNullOrEmpty(enrollment_number)) ||
                (string.IsNullOrEmpty(date_of_birth)) ||
                (string.IsNullOrEmpty(contact)) ||
                (string.IsNullOrEmpty(current_company))
            )
                Response.Write("<script>alert('some fields were empty')</script>");
            else
            {
                if (confirm_password == password)
                {
                    DateTime BirthDate = DateTime.Parse(date_of_birth);
                    long UserID = InsertIntoUserTable(
                            FileUpload1,
                            (first_name + "-" + last_name),
                            enrollment_number,
                            BirthDate,
                            gender,
                            current_company,
                            contact,
                            email,
                            confirm_password,
                            designation,
                            location,
                            batch,
                            experience,
                            uType
                            );


                    Session["user_id"] = UserID;

                    // otp bit
                    try
                    {

                        MySqlConnection connection1 = ConnectToDB();

                        if (connection1 == null)
                            Response.Write("not connected one bit");
                        else
                        {
                            connection1.Open();
                            // insert the otp request 
                            string Query = "insert into tbl_otp_information(userEmail,user_id)values('" + email + "'," + UserID + ")";
                            MySqlCommand command = new MySqlCommand(Query, connection1);
                            command.ExecuteNonQuery();
                            // get the same request id or token
                            long lastID = command.LastInsertedId;
                            // fetch the same request for sending email
                            command.CommandText = "select * from tbl_OTP_Information where OTPID = " + lastID + "";
                            MySqlDataReader result = command.ExecuteReader();
                            DataTable Dt = new DataTable();
                            Dt.Load(result);

                            int OTPNumber = 0;
                            if (Dt.Rows.Count != 0)
                            {
                                OTPNumber = Convert.ToInt32(Dt.Rows[0]["OTPNUMBER"]);
                                string[] to = { email };


                                string htmlContent = "<html><body><h1> OTP Notification </h1><p> your otp token is " + lastID + " and your otp is " + OTPNumber + "</p></body></html >";
                                string subject = "OTP notification for registration process in our Alumni Association";
                                if (SendMail(subject, htmlContent, to))
                                {
                                    Response.Write("<script>alert('OTP has been sent to respective mail');windows.location.href='OTPValidations.aspx'</script>");
                                    Response.Redirect("OTPValidations.aspx");
                                }
                                else
                                    Response.Write("<script>alert('error in sending otp mail')</script>");
                            }
                            else
                                Response.Write("<script>alert('server error')</script>");
                            connection1.Close();
                        }
                    }
                    catch (Exception error)
                    {
                    }
                }
                else
                    Response.Write("<script>alert('confirm password and password are not same')</script>");
            }
        }
        catch (Exception error)
        {
            Response.Write("<script>alert('error in entering fields by user  " + error.Message + "')</script>");
        }
    }
%>


<!DOCTYPE html>
<!-- Created By CodingLab - www.codinglabweb.com -->
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <!---<title> Responsive Registration Form | CodingLab </title>--->
    <link rel="stylesheet" href="style.css">
    <%--  --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
    <%--  --%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }

        .container {
            max-width: 700px;
            width: 100%;
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 5px;
            box-shadow: 0 5px 10px rgb(0 0 0 / 15%);
            margin-top: 120px;
            margin-bottom: 50px;
        }

            .container .title {
                font-size: 25px;
                font-weight: 500;
                position: relative;

            }



                .container .title::before {
                    content: "";
                    position: absolute;
                    left: 0;
                    bottom: 0;
                    height: 3px;
                    width: 30px;
                    border-radius: 5px;
                    background: linear-gradient(135deg, #71b7e6, #9b59b6);
                }

        .content form .user-details {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px 0 12px 0;
        }

        form .user-details .input-box {
            margin-bottom: 15px;
            width: calc(100% / 2 - 20px);
        }

        form .input-box span.details {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .user-details .input-box input {
            height: 45px;
            width: 100%;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
        }

        .user-details .input-box select {
            height: 45px;
            width: 100%;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
        }

        .user-details .input-box input:focus,
        .user-details .input-box input:valid {
            border-color: #9b59b6;
        }

        form .gender-details .gender-title {
            font-size: 20px;
            font-weight: 500;
        }

        form .category {
            display: flex;
            width: 80%;
            margin: 14px 10px;
            /* justify-content:; */
        }

            form .category label {
                display: flex;
                align-items: center;
                cursor: pointer;
                margin: 0px 10px;
            }

                form .category label .dot {
                    height: 18px;
                    width: 18px;
                    border-radius: 50%;
                    margin-right: 10px;
                    background: #d9d9d9;
                    border: 5px solid transparent;
                    transition: all 0.3s ease;
                }

        #dot-1:checked ~ .category label .one,
        #dot-2:checked ~ .category label .two,
        #dot-3:checked ~ .category label .three {
            background: #9b59b6;
            border-color: #d9d9d9;
        }

        #m:checked,
        #f:checked {
            background: #9b59b6;
            border-color: #d9d9d9;
        }

        /* form input[type="radio"] {
            display: none;
        } */

        form .button {
            height: 45px;
            margin: 35px 0
        }

            form .button input {
                height: 100%;
                width: 100%;
                border-radius: 5px;
                border: none;
                color: #fff;
                font-size: 18px;
                font-weight: 500;
                letter-spacing: 1px;
                cursor: pointer;
                transition: all 0.3s ease;
                background: linear-gradient(135deg, #71b7e6, #9b59b6);
            }

                form .button input:hover {
                    /* transform: scale(0.99); */
                    background: linear-gradient(-135deg, #71b7e6, #9b59b6);
                }

        @media(max-width: 584px) {
            .bmiitLogo {
                height: 60px;
                width: auto;
                position: absolute;
                top: 5.5%;
            }
            body{
                height:100vh;
            }
            .projectTitle {
                font-size: large;
                position: absolute;
                top: 1%;
                margin-bottom: 20px;
                font-family: 'Noto Sans', sans-serif;
                font-family: 'Playfair Display', serif;
            }
            
            .container {
                max-width: 100%;
                margin-top:130px;
            }

            form .user-details .input-box {
                margin-bottom: 15px;
                width: 100%;
            }

            form .category {
                width: 100%;
            }

            .content form .user-details {
                max-height: 300px;
                overflow-y: scroll;
            }

            .user-details::-webkit-scrollbar {
                width: 5px;
            }
        }

        @media(max-width: 459px) {
            .container .content .category {
                flex-direction: column;
            }
        }
        .projectTitle {
            position: absolute;
            top: 4%;
            margin-bottom: 20px;
            font-family: 'Noto Sans', sans-serif;
            font-family: 'Playfair Display', serif;
            /*color:white;*/
            background: rgb(198,15,170);
background: linear-gradient(90deg, rgba(198,15,170,1) 35%, rgba(3,18,125,1) 100%);
            -webkit-text-fill-color: transparent;
            -webkit-background-clip: text;
        }
        .bmiitLogo{
            height:85px;
            width:auto;
            position:absolute;
            top:11%;
        }
    </style>
</head>

<body>
    <img class="bmiitLogo"src="BMIIT LOGO copy.png"/><h1 class="projectTitle"> ALUMNI ASSOCIATION SYSTEM</h1>
    <div class="container">
        <div class="title">Registration</div>
        <div class="content">
            <form action="#" runat="server" method="post" enctype="multipart/form-data">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">First Name</span>
                        <input type="text" placeholder="Enter your name" ID="first_name" name="first_name"
                            runat="server" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Last Name</span>
                        <input type="text" placeholder="Enter your name" ID="last_name" name="last_name"
                             runat="server" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Enrollment Number</span>
                        <input type="number" ID="enrollment_number" name="enrollment_number"
                            placeholder="enrollment number" runat="server"
                            required>
                    </div>
                    <div class="input-box">
                        <span class="details">Email</span>
                        <input type="email" name="email" id="email_id" runat="server" placeholder="Enter your email"
                            required>
                    </div>
                    <div class="input-box">
                        <span class="details">Phone Number</span>
                        <input type="text" ID="phone" runat="server" name="contact_number" placeholder="+98564384854"
                            required>
                    </div>
                    <div class="input-box">
                        <span class="details">Date of Birth</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <input type="date" name="date_of_birth" ID="date_of_birth" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Current Company</span>
                        <input type="text" ID="current_company" runat="server" name="company"
                            placeholder="Company here!" required>
                    </div>
                    <div class="input-box">
                        <span class="details">User Type</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <select name="user_type" ID="user_type" class="form-control">
                            <option value="1"> Member or Faculty </option>
                            <option value="2"> Student </option>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Your batch</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <select name="batch" ID="batch" class="form-control">
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
                                        if (connection != null)
                                            connection.Close();
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
                                        string Query = "select distinct batch_id,batch_name from tbl_batch where is_enabled = 'y'";
                                        MySqlCommand command = new MySqlCommand(Query, connection);

                                        MySqlDataReader DTR = command.ExecuteReader();

                                        if (DTR.HasRows)
                                            while (DTR.Read())
                                            {
                            %>
                            <option value="<%=DTR.GetInt32(0)%>"><%=DTR.GetInt32(1)%> </option>
                            <%}
                                        DTR.Close();
                                        DTR.Dispose();
                                        CloseConnection(ref connection);
                                    }
                                    catch (Exception error)
                                    { }
                                }
                                DisplayBatchInDropDown();
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Job Title</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <select name="designation" ID="designation" class="form-control">
                            <%
                                void DisplayJobTitleInDropDown()
                                {
                                    try
                                    {
                                        MySqlConnection connection = ConnectToDB();
                                        connection.Open();
                                        string Query = "select distinct job_title_id,job_title from tbl_job_title where is_enabled = 'y'";
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
                                    {
                                        Response.Write("<script>alert('" + error.Message + "')</script>");
                                    }
                                }
                                DisplayJobTitleInDropDown();
                            %>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Technology</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <select name="technology" ID="technology" class="form-control">
                            <% 
                                void DisplayTechnologyInDropDown()
                                {
                                    try
                                    {
                                        MySqlConnection connection = ConnectToDB();
                                        connection.Open();
                                        string Query = "select distinct technology_id,technology_name from tbl_technology where is_enabled = 'y'";
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
                    </div>
                    <div class="input-box">
                        <span class="details">Place Of Work</span>
                        <!-- <input type="text" placeholder="Confirm your password" required> -->
                        <select name="location" ID="location" class="form-control">
                            <% 
                                void DisplayPlaceOfWorkInDropDown()
                                {
                                    try
                                    {
                                        MySqlConnection connection = ConnectToDB();
                                        connection.Open();
                                        string Query = "select distinct place_of_work_id,place_of_work from tbl_place_of_work where is_enabled = 'y'";
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
                        </select>
                    </div>
                    
                    <div class="input-box">
                        <span class="details">Experience</span>
                        <input type="number" id="experience" name="experience" placeholder="Your Experience" value="1"
                            min="1" max="15" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Profile Photo</span>
                        <asp:FileUpload ID="FileUpload1" runat="server"/>
                        
                    </div>
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" id="pass_word" name="password" runat="server" placeholder="Enter your password" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Confirm Password</span>
                        <input type="password" id="c_pass" name="cpassword" runat="server" placeholder="Confirm your password"
                            required>
                    </div>
                    
                </div>

                <div class="gender-details">
                    <span class="gender-title">Gender</span><br>
                    Male: <input type="radio" name="gender" id="m" value="m" checked>
                    Female: <input type="radio" name="gender" id="f" value="f">
                    
                    <!-- <input type="radio" name="gender" id="dot-3"> -->
                    <!-- <input type="radio" name="gender" id="dot-1">
                    <input type="radio" name="gender" id="dot-2">
                    <span class="gender-title">Gender</span>
                    <div class="category">
                        <label for="dot-1">
                            <span class="dot one"></span>
                            <span class="gender">Male</span>
                        </label>
                        <label for="dot-2">
                            <span class="dot two"></span>
                            <span class="gender">Female</span>
                        </label>
                    </div> -->
                </div>
                <div class="button">
                    <input type="submit" value="Register" ID="submit" runat="server" >
                    
                </div>
                <center>
                    <a href="Login.aspx">SignIn</a>
                </center>
            </form>
        </div>
    </div>

</body>

</html>