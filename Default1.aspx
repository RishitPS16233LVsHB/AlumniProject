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
    long InsertIntoUserTable(FileUpload fileUploadControl, string username, string en_no, DateTime dob, char gender, string Current_Company, string contact_num, string email_id, string pass, int job, int work, int batch, int experience,int utype)
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
                        "values('" + username + "','" + en_no + "','" + dob.ToString("yyyy-MM-dd HH:mm:ss") + "','" + gender + "','','" + Current_Company + "','" + contact_num + "','" + email_id + "','" + HashedPassword + "'," + job + "," + work + "," + batch + "," + experience + ",2,2,'n',"+utype+")";


                Response.Write("<br><br>" + Query + "<br><br>");
                command.CommandText = Query;
                if (command.ExecuteNonQuery() != 0)
                {
                    UserID = command.LastInsertedId;
                    Session["userid"] = UserID;
                    Session["enrollment_number"] = en_no;
                    Session["user_type"] = 1;
                    // now make the folder and store the profile photo there    
                    CreateDirectory(UserID + "-User-" + en_no);
                    string enrollment_number = en_no;
                    string path = Server.MapPath("Uploads//" + UserID + "-User-" + enrollment_number + "//" + fileUploadControl.FileName);

                    string Pattern = "(\\.png$)|(\\.jpg)|(\\.jpeg)";
                    Regex rx = new Regex(Pattern);

                    path = path.Replace("\\","/");
                    Response.Write("<br><br>" + path + "<br><br>");
                    if (fileUploadControl.FileName != null && fileUploadControl.FileName != "")
                    {
                        if (rx.IsMatch(fileUploadControl.FileName))
                        {
                            Query = "update tbl_user set profile_photo_path = '"+path+"' where user_id = "+UserID+"";
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
        try
        {
            string first_name = Request["first_name"];
            string last_name = Request["last_name"];
            string contact = Request["phone"];
            string email = Request["email"];
            string password = Request["password"];
            string confirm_password = Request["confirm_password"];
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

            Response.Write("first name:- " + (string.IsNullOrEmpty(first_name)) + "last name:- " +(string.IsNullOrEmpty(last_name)) +"password:- " + (string.IsNullOrEmpty(confirm_password)) +"email:- " + (string.IsNullOrEmpty(email)) + "enrollment_number:- " +(string.IsNullOrEmpty(enrollment_number)) + "date of birth " +(string.IsNullOrEmpty(date_of_birth)) + "contact:- " +(string.IsNullOrEmpty(contact)) + "current company:- " +(string.IsNullOrEmpty(current_company)));
            Response.Write(string.IsNullOrEmpty(email) + " <" + email + ">");
            Response.Write(string.IsNullOrEmpty(password) + " <" + password + ">");
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

                        if(connection1 == null)
                            Response.Write("not connected one bit");
                        else
                        {
                            connection1.Open();
                            // insert the otp request 
                            string Query = "insert into tbl_otp_information(userEmail,user_id)values('"+email+"',"+UserID+")";
                            MySqlCommand command = new MySqlCommand(Query,connection1);
                            command.ExecuteNonQuery();
                            // get the same request id or token
                            long lastID = command.LastInsertedId;
                            // fetch the same request for sending email
                            command.CommandText = "select * from tbl_OTP_Information where OTPID = "+lastID+"";
                            MySqlDataReader result = command.ExecuteReader();
                            DataTable Dt = new DataTable();
                            Dt.Load(result);

                            int OTPNumber = 0;
                            if (Dt.Rows.Count != 0)
                            {
                                OTPNumber = Convert.ToInt32(Dt.Rows[0]["OTPNUMBER"]);
                                string[] to = { email };


                                string htmlContent = "<html><body><h1> OTP Notification </h1><p> your otp token is "+lastID+" and your otp is "+OTPNumber+"</p></body></html >";
                                string subject = "OTP notification for registration process in our Alumni Association";
                                if (SendMail(subject, htmlContent, to))
                                    Response.Redirect("OTPValidations.aspx");
                                else
                                    Response.Write("<script>alert('error in sending otp mail')</script>");
                            }
                            else
                                Response.Write("<script>alert('server error')</script>");
                            connection1.Close();
                        }
                    }
                    catch(Exception error)
                    {
                    }
                }
                else
                    Response.Write("<script>alert('confirm password and password are not same')</script>");
            }
        }
        catch (Exception error)
        {
            Response.Write("<script>alert('error in entering fields by user  "+error.Message+"')</script>");
        }
    }
%>


<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>Register to Alumni Association</title>
	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!-- bootstrap-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- Font-->
	<link rel="stylesheet" type="text/css" href="css/opensans-font.css">
	<link rel="stylesheet" type="text/css"
		href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
	<%-- google font --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
    <!-- Main Style Css -->

	<link rel="stylesheet" href="css/style.css"/>
    <style>
        .inner .form-row .form-holder select {
            font-size: 14px;
            color: #666;
            font-weight: 600;
            background: #fff url(../images/form-v1-icon.png) no-repeat scroll;
            background-position: right 6px center;
            z-index: 1;
            cursor: pointer;
            position: relative;
            border: 2px solid #e5e5e5;
            padding: 7px 17px;
            margin-bottom:7px;
        }

        .inner .form-row .form-holder input {
            color: #333;
            margin-bottom: 7px;
        }
        a:hover{
            text-decoration:none;
        }
        .projectTitle {
			position: absolute;
			top: 10%;
			font-family: 'Noto Sans', sans-serif;
			font-family: 'Playfair Display', serif;
		}
    </style>
</head>

<body>
	<div class="page-content">
        <h1 class="projectTitle">Alumni Association System</h1>
		<div class="form-v1-content">
			
				<form class="form-register" action="#" runat ="server" method="post" enctype="multipart/form-data">
					<div id="form-total">

						<!-- SECTION 1 -->
						<h2>
							<!-- <p class="step-icon"><span>0</span></p> -->
							<span class="step-text">Register</span>
						</h2>
					
                        <section>
							<div class="inner">
								<div class="wizard-header">
									<h3 class="heading" style="color : #1c3961;">Register</h3>
									<p>Please enter your infomation and proceed to the next step so we can build your
											accounts. </p>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>First Name</legend>
											<input type="text" class="form-control" ID="first_name" name="first_name"
												placeholder="First Name" runat= "server" >
										</fieldset>
									</div> 
                                    
								</div>
								<div class="form-row">
									<div class="form-holder ">
										<fieldset>
											<legend>Last Name</legend>
											<input type="text" class="form-control" ID="last_name" name="last_name"
												placeholder="Last Name" runat="server" >
										</fieldset>
									</div>
									<div class="form-holder ">
										<fieldset>
											<legend>Enrollment number</legend>
											<input type="text" class="form-control" ID="enrollment_number" name="enrollment_number"
												placeholder="enrollment number" runat="server" >
										</fieldset>
									</div>									
								</div>
								
								<div >
									<div >
										<fieldset>
										<table>
											<p> Gender</p>
											<!-- <legend>Gender</legend> -->
											
												<tr>
													<td style = "padding-left:3px;padding-right:12px; margin-right:30px;">	Male: 
													<input type="radio" name="gender"  ID="m" runat="server" value = "m"  checked> </td>

                                                    <td style="">Female:
													<input type="radio" name="gender" ID="f" runat="server" value = "f" > </td>
												</tr>

																							
											</table>

										</fieldset>
									</div>
								</div>
								<br>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Your Email</legend>
											<input type="email" name="email" ID="email" runat="server" class="form-control" placeholder="example@email.com" >
										</fieldset>
									</div>
								</div>
                                <div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>User Type</legend>
											<select name="user_type" ID="user_type" class="form-control">
                                                <option value ="1"> Member or Faculty </option>
                                                <option value ="2"> Student </option>
                                            </select>
										</fieldset>
									</div>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Phone Number</legend>
											<input type="text" class="form-control" ID="phone" runat="server" name="contact_number" placeholder="+98564384854" >
										</fieldset>
									</div>
								</div>
								<div class="form-row ">
									<div class="form-holder form-holder-2">
                                        <fieldset>
										<legend>Your Batch</legend>
										<select name="batch" ID="batch">
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
                                            </fieldset>
									</div>
								</div>
								<div class="form-row form-row-date">
									<div class="form-holder form-holder-2">
										
										<fieldset>
											<legend>Birth Date</legend>
											<input type="date" name="date_of_birth" ID="date_of_birth">
										</fieldset>
									</div>
								</div>
							
							
							
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Current Company</legend>
											<input type="text" class="form-control" ID="current_company" runat="server"
												name="company" placeholder="Company here!" >
										</fieldset>
									</div>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										 <fieldset> 
											
											 <legend>Job Title</legend> 
											<select name="designation" ID="designation">
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
										</fieldset> 
									</div>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset> 
											
											<legend>Place of work</legend> 
											<select name="location" ID="location">
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
										</fieldset> 
									</div>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Experience</legend>
											<input type="number" class="form-control" id="experience" name="experience"
												placeholder="Your Experience" value = "1" min="1" max="15" style="padding:8px 8px;">
										</fieldset>
									</div>
								</div>
								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset> 
											 <legend>Technology</legend> 
											
											<select name="technology" ID="technology">
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
										</fieldset> 
									</div>
								</div>

								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Password</legend>
											<input type="password" class="form-control" ID="password" name="password" runat="server">
										</fieldset>
									</div>
								</div>

								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Confirm password</legend>
											<input type="password" class="form-control" ID="confirm_password" name="cpassword" runat="server">
										</fieldset>
									</div>
								</div>

								<div class="form-row">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Profile photo</legend>
											<asp:FileUpload ID="FileUpload1" runat="server"/>
										</fieldset>
									</div>
								</div>
								<input class="register"  runat="server" ID ="submit" type = "submit" value = "Register" style="border-radius:13px;">
								<a class="register" href="Login.aspx" style="background-color:white; color:#4fab40;">Back to Login</a>
							</div>
						</section>
					</div>
				</form>
			
		</div>    
	</div>
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/jquery.steps.js"></script>
	<script src="js/main.js"></script>

</body>

</html>


<%-- OTp validations --%>
<!DOCTYPE html>

<html>
    <head>
        <title>Enter OTP </title>
    </head>
    <body>
        <h1> please enter token and otp sent to you via email to become part of out community</h1><br>
        <h2> Hurry!before otp expires in about 60 mins</h2>
            <form action = "#" method = "post" runat="server">
                Token : <input type = "number" runat="server" ID = "token" required><br>
                OTP Number : <input type = "number" runat="server" ID = "otp" required><br>
                <input type = "submit" ID ="submit1" runat="server" value="enter otp">
            </form>
    </body>
</html>

<%-- ForgotPassword.aspx --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<style>
		body{
			height: 100vh;
			background-image: -webkit-linear-gradient(136deg , rgb(116,235,213) 0% , rgb(63,43,150) 100%);
		}
		.heading
		{
			padding-left : 45%;			
		}
		.RegisterButton{
			font-family: 'Open Sans', sans-serif;
			background-color: #4fab40;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: #fff;
			padding: 12px 10px;
			width: 120px;
			float: right;
			margin: 35px 22px 20px 15px;
		}
		.ForgotPasswordButton{
			font-family: 'Open Sans', sans-serif;
			/*background-color: #4fab40;*/
			background-color:none;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: red;
			padding: 12px 10px;
			width: 180px;
			float: left;
			margin: 36px 0px 0px 10px;
			text-decoration:none;
		}
		.SignInButton{
			font-family: 'Open Sans', sans-serif;
			background-color: #4fab40;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: #fff;
			padding: 12px 10px;
			width: 120px;
			float: right;
			margin: 35px 22px 12px 0px;
		}
		.RegisterButton:hover{
			background-color:#36782c;
		}
		/*#Button1{
			margin-right:7px;
		}*/

		.form-v1-content {
			margin:230px 0px;
		}
		.showPasswordInput{
			color: grey;
			font-family: normal normal 14px/1 'Material-Design-Iconic-Font';
			cursor: pointer;
			padding-left : 3%;
		}
		.inner .form-row {
			display: flex;
			margin: 0px;
			position: relative;
		}

		.form-v1-content .wizard-form {
			width: 100%;
			padding: 20px 20px;
		}

		@media screen and (max-width: 1199px) {
			.form-v1-content .wizard-form {
				padding: 0px 10px;
				width: 100%;
			}
			
		}

	/* 
}*/	
	</style>


	<meta charset="utf-8">
	<title>Login Form</title>
	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!-- Font-->
	<link rel="stylesheet" type="text/css" href="css/Login_css/opensans-font.cs
			 * 
			 * s">
	<link rel="stylesheet" type="text/css" href="css/Login_fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
	<!-- Main Style Css -->
	<link rel="stylesheet" href="css/Login_css/style.css"/>
</head>

<body>
	<div class="page-content">
		<div class="form-v1-content">
			<div class="wizard-form">
				<form class="form-register" method="post" action="" runat="server">
					<div id="form-total">
						<section>
							<div class="inner">
								<div class="wizard-header">
									<h3 class="heading">Password Reset</h3>
									<p style="color:gray;text-align:center;">Enter enrollment number and we will send the link to respective e-mail.</p>
								</div>
								<div class="form-row" style="margin:0px">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Your Enrollment number</legend>
											<!--<input type="text" name="email" id="email" class="form-control" placeholder="example@email.com" required>-->
											<asp:TextBox ID="enrollmentNumber" name="enrollmentNumber" class="form-control" runat="server" required></asp:TextBox>
										</fieldset>
									</div>
								</div>
								<!-- <p class="forgotPassword">Forgot password/p> -->
							</div>
						</section>
						<input type="submit" runat="server" id="Button1" class="SignInButton" value="Get OTP" style="border-radius:13px; "/>
						<%--<asp:Button id="Button1" class="SignInButton" runat="server"  Text="Get Otp" formaction="ForgotPassword.aspx" style="border-radius:13px; "/>--%>
						
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		
        function Toggle() {
            let temp = document.getElementById('password');
            if (temp.type === "password") {
                temp.type = "text";
            } else {
                temp.type = "password";
            }
        }
    </script>

	<script src="js/Login_js/jquery-3.3.1.min.js"></script>
	<script src="js/Login_js/jquery.steps.js"></script>
	<script src="js/Login_js/main.js"></script>
</body>

</html>

<%-- Login --%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
	<style>
		body{
			height: 100vh;
			background-image: -webkit-linear-gradient(136deg , rgb(116,235,213) 0% , rgb(63,43,150) 100%);
		}
		.heading {
			padding-left: 45%;
			font-family: 'Noto Sans', sans-serif;
			font-family: 'Playfair Display', serif;
		}
		.RegisterButton{
			font-family: 'Open Sans', sans-serif;
			background-color: #4fab40;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: #fff;
			padding: 12px 10px;
			width: 120px;
			float: right;
			margin: 35px 22px 20px 15px;
		}

		.form-v1-content .wizard-form {
			width: 100%;
			padding: 20px 20px;
		}

		.ForgotPasswordButton{
			font-family: 'Open Sans', sans-serif;
			/*background-color: #4fab40;*/
			background-color:none;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: red;
			padding: 12px 10px;
			width: 180px;
			float: left;
			margin: 36px 0px 0px 10px;
			text-decoration:none;
		}
		.SignInButton{
			font-family: 'Open Sans', sans-serif;
			background-color: #4fab40;
			border: none;
			cursor: pointer;
			font-size: 16px;
			color: #fff;
			padding: 12px 10px;
			width: 120px;
			float: right;
			margin: 35px 22px 12px 0px;
		}
		.RegisterButton:hover{
			background-color:#36782c;
		}
		/*#Button1{
			margin-right:7px;
		}*/

		.form-v1-content {
			margin:230px 0px;
		}
		.showPasswordInput{
			color: grey;
			font-family: normal normal 14px/1 'Material-Design-Iconic-Font';
			cursor: pointer;
			padding-left : 3%;
		}
		.inner .form-row {
			display: flex;
			margin: 0px;
			position: relative;
		}
		@media screen and (max-width: 1199px) {
			.form-v1-content .wizard-form {
				padding: 0px 10px;
				width: 100%;
			}
			
		}
		.projectTitle {
			position: absolute;
			top: 10%;
			font-family: 'Noto Sans', sans-serif;
			font-family: 'Playfair Display', serif;
		}

	/* 
}*/	
	</style>


	<meta charset="utf-8">
	<title>Login Form</title>
	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!-- Font-->
	<link rel="stylesheet" type="text/css" href="css/Login_css/opensans-font.css">
	<link rel="stylesheet" type="text/css" href="css/Login_fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
	<!-- Main Style Css -->
	<link rel="stylesheet" href="css/Login_css/style.css"/>
</head>

<body>
	
	<div class="page-content">
		<h1 class="projectTitle">Alumni Association System</h1>
		<div class="form-v1-content">
			
			<div class="wizard-form">

				<form class="form-register" method="get" action="LoginPageValidations.aspx" runat="server">
					<div id="form-total">
						<section>
							<div class="inner">
								<div class="wizard-header">
									<h3 class="heading">Login</h3>
								</div>
								<div class="form-row" style="margin:0px">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Your Enrollment number</legend>
											<!--<input type="text" name="email" id="email" class="form-control" placeholder="example@email.com" required>-->
											<asp:TextBox ID="TextBox1" name="email" class="form-control" runat="server"></asp:TextBox>
										</fieldset>
									</div>
								</div>
								<div class="form-row" style="margin:0px;">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Password</legend>
											<!--<input type="password" class="form-control" id="password" name="password" placeholder="password" required>-->
											<asp:TextBox ID="TextBox2"  runat="server"></asp:TextBox>										
										</fieldset>
									</div>
										
								</div>
								<label class="showPasswordInput" for="showPassword">show password</label>
								<input class="showPasswordInput" type="checkbox" name="showPassword" onclick="Toggle()" id="showPasswordinput">
								<!-- <p class="forgotPassword">Forgot password?</p> -->
							</div>
						</section>
						<!--<button class="signIn" formaction="LoginPageValidations.aspx" formmethod="POST">sign in</button>-->
						<a class="ForgotPasswordButton" href="ForgotPassword.aspx" >Forgot Password</a>
						<input type="submit" id="Button1" class="SignInButton" Text="sign in"  style="border-radius:13px; "/>
						
						<button class="RegisterButton" formaction = "Register.aspx" style="border-radius:13px;">Register</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
        function Toggle() {
            let temp = document.getElementById('password');
            if (temp.type === "password") {
                temp.type = "text";
            } else {
                temp.type = "password";
            }
        }
    </script>

	<script src="js/Login_js/jquery-3.3.1.min.js"></script>
	<script src="js/Login_js/jquery.steps.js"></script>
	<script src="js/Login_js/main.js"></script>
</body>

</html>

<%-- ForgotPasswordOTPValidations --%>
<!DOCTYPE html>

<html>
    <head>
        <title>Enter OTP </title>
    </head>
    <body>
        <h1> please enter token and otp sent to you via email to become part of out community</h1><br>
        <h2> Hurry!before otp expires in about 60 mins</h2>
            <form action = "#" method = "post" runat="server">
                Token : <input type = "number" runat="server" ID = "Number1" required><br>
                OTP Number : <input type = "number" runat="server" ID = "Number2" required><br>
                <input type = "submit" ID ="submit2" runat="server" value="enter otp">
            </form>
    </body>
</html>

<%-- ResetPassword --%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <style>
    	body {
    		height: 100vh;
    		background-image: -webkit-linear-gradient(136deg, rgb(116,235,213) 0%, rgb(63,43,150) 100%);
    	}

    	.heading {
    		padding-left: 45%;
    	}

    	.RegisterButton {
    		font-family: 'Open Sans', sans-serif;
    		background-color: #4fab40;
    		border: none;
    		cursor: pointer;
    		font-size: 16px;
    		color: #fff;
    		padding: 12px 10px;
    		width: 200px;
    		float: right;
    		margin: 10px 22px 20px 15px;
    	}

    	.form-v1-content .wizard-form {
    		width: 100%;
    		padding: 20px 20px;
    	}

    	.ForgotPasswordButton {
    		font-family: 'Open Sans', sans-serif;
    		/*background-color: #4fab40;*/
    		background-color: none;
    		border: none;
    		cursor: pointer;
    		font-size: 16px;
    		color: red;
    		padding: 12px 10px;
    		width: 180px;
    		float: left;
    		margin: 36px 0px 0px 10px;
    		text-decoration: none;
    	}

    	.SignInButton {
    		font-family: 'Open Sans', sans-serif;
    		background-color: #4fab40;
    		border: none;
    		cursor: pointer;
    		font-size: 16px;
    		color: #fff;
    		padding: 12px 10px;
    		width: 120px;
    		float: right;
    		margin: 35px 22px 12px 0px;
    	}

    	.RegisterButton:hover {
    		background-color: #36782c;
    	}
    	/*#Button1{
			margin-right:7px;
		}*/

    	.form-v1-content {
    		margin: 230px 0px;
    	}

    	.showPasswordInput {
    		color: grey;
    		font-family: normal normal 14px/1 'Material-Design-Iconic-Font';
    		cursor: pointer;
    		padding-left: 3%;
    	}

    	.inner .form-row {
    		display: flex;
    		margin: 0px;
    		position: relative;
    	}

    	@media screen and (max-width: 1199px) {
    		.form-v1-content .wizard-form {
    			padding: 0px 10px;
    			width: 100%;
    		}
    	}

    	/* 
}*/
    </style>


    <meta charset="utf-8">
    <title>Login Form</title>
    <!-- Mobile Specific Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Font-->
    <link rel="stylesheet" type="text/css" href="css/Login_css/opensans-font.css">
    <link rel="stylesheet" type="text/css" href="css/Login_fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
    <!-- Main Style Css -->
    <link rel="stylesheet" href="css/Login_css/style.css" />
</head>
<body>
	<div class="page-content">
		<div class="form-v1-content">
			<div class="wizard-form">
				<form class="form-register" method="post" runat="server">
					<div id="form-total">
						<section>
							<div class="inner">
								<div class="wizard-header">
									<h3 class="heading">Reset Password</h3>
								</div>
								<div class="form-row" style="margin:0px;">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Password</legend>
											<input type="password" class="form-control" id="password" name="password" placeholder="password" required>
											<%--<asp:TextBox ID="password"  runat="server"></asp:TextBox>--%>										
										</fieldset>
									</div>	
								</div>

								<div class="form-row" style="margin:0px;">
									<div class="form-holder form-holder-2">
										<fieldset>
											<legend>Confirm Password</legend>
											<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
											<%--<asp:TextBox ID="confirmPassword"  runat="server"></asp:TextBox>--%>										
										</fieldset>
									</div>	
								</div>

								<label class="showPasswordInput" for="showPassword">show password</label>
								<input class="showPasswordInput" type="checkbox" name="showPassword" onclick="Toggle()" id="showPasswordinput">
								<!-- <p class="forgotPassword">Forgot password?</p> -->
							</div>
						</section>
						<!--<button class="signIn" formaction="LoginPageValidations.aspx" formmethod="POST">sign in</button>-->
						<%--<a class="ForgotPasswordButton" href="ForgotPassword.aspx" >Forgot Password</a>--%>
						<%--<asp:Button id="Button1" class="SignInButton" runat="server" Text="sign in" formaction="LoginPageValidations.aspx" style="border-radius:13px; "/>--%>
						
						<button class="RegisterButton" action="ResetPassword.aspx" name="updatePassword" style="border-radius:13px;">Update Password</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
        function Toggle() {
            let temp = document.getElementById('password');
            let temp2 = document.getElementById('confirmPassword');
            if (temp.type === "password") {
                temp.type = "text";
                temp2.type = "text";
            } else {
                temp.type = "password";
                temp2.type = "password";
            }
        }
        function passwordCheck() {
            let temp = document.getElementById('password').value;
            let temp2 = document.getElementById('confirmPassword').value;
            Console.Write(temp);
            Console.Write(temp2);
            //if (temp != temp2) {		
            //	alert('Password must be same');
            //}
            //else {
            //	alert('Password are same');
            //         }
        }
    </script>

	<script src="js/Login_js/jquery-3.3.1.min.js"></script>
	<script src="js/Login_js/jquery.steps.js"></script>
	<script src="js/Login_js/main.js"></script>
</body>

</html>