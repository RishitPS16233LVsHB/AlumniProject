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

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');document.location.href='LogOutSession.aspx'</script>");
    else
    {

        if (Request["submit"] != null)
        {
            //Response.Write("here");
            try
            {
                if (!string.IsNullOrEmpty(Request["otp"]) && !string.IsNullOrEmpty(Request["token"]))
                {
                    int token = Convert.ToInt32(Request["token"]);
                    int otp = Convert.ToInt32(Request["otp"]);
                    MySqlConnection connection = ConnectToDB();
                    //Response.Write("sessoion " + Session["user_id"]);
                    if (connection != null)
                    {
                        connection.Open();
                        long UserID = Convert.ToInt32(Session["user_id"]);
                        string query = "select * from tbl_otp_information where OTPID = " + token + " and OTPNUMBER = " + otp + " and user_id = " + UserID + " and time > 0;";
                        MySqlCommand command = new MySqlCommand(query, connection);

                        MySqlDataReader result = command.ExecuteReader();
                        DataTable DT = new DataTable();
                        DT.Load(result);

                        int number_of_rows = DT.Rows.Count;

                        if (number_of_rows == 0)
                        {
                            //Response.Write("<script>if(confirm('OTP is not matched')) document.location = 'OTPValidations.aspx';else  document.location = 'OTPValidations.aspx';</script>");
                            Response.Write("<script>alert('OTP Not Matched')</script>");
                            //Response.Write(query);

                        }
                        else
                        {
                            //Response.Write(query);
                            //Response.Write("<script>alert('OTP Matched')</script>");
                            //ActivateAccount((int)UserID);
                            //DeleteFromOTPTable(token);
                            Response.Write("<script>if(confirm('OTP has been verified.Now reset your password')) document.location = 'ResetPassword.aspx';else  document.location = 'ResetPassword.aspx';</script>");
                            //Response.Redirect("ResetPassword.aspx");
                        }
                        connection.Close();
                    }
                    else
                        Response.Write("<script>if(confirm('not connected to server')) document.location = 'OTPValidations.aspx';else  document.location = 'OTPValidations.aspx';</script>");
                }
            }
            catch (Exception error)
            {
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
        .projectTitle {
			position: absolute;
			top: 4%;
            
			font-family: 'Noto Sans', sans-serif;
			font-family: 'Playfair Display', serif;
		}

        body {
            height: 100vh;
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
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
            margin-top: 20px;
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

        #dot-1:checked~.category label .one,
        #dot-2:checked~.category label .two,
        #dot-3:checked~.category label .three {
            background: #9b59b6;
            border-color: #d9d9d9;
        }
        #m:checked,
        #f:checked
        {
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
        form .button a {
            height: 45px;
            /* height: 100%; */
            width: 100px;
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
            .container {
                max-width: 100%;
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
            top:26%;
        }
    </style>
</head>

<body>
    <img class="bmiitLogo"src="BMIIT LOGO copy.png"/><h1 class="projectTitle"> ALUMNI ASSOCIATION SYSTEM.</h1>
    <div class="container">
        <div class="title">OTP Validations</div>
        <div class="content">
            <form action="#" runat="server" method="post">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Token</span>
                        <input type="number" placeholder="Enter your token number" ID= "token" runat="server" required>
                    </div>
                    <div class="input-box">
                        <span class="details">OTP</span>
                        <input type="number" placeholder="Enter your otp" ID="otp" runat="server" required>
                    </div>
                </div>
                <div class="button">
                    <input type = "submit" ID ="submit" runat="server">                    
                </div>
                
            </form>
        </div>
    </div>

</body>

</html>
<%} %>






