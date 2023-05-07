<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AlumniProject.WebForm1" %>



    <%-- Validation Code--%>
<%  
    //Response.Write(Session["user_id"]);
    //require_once "FormValidations.aspx";
    //session_start();
    //echo $_SESSION['email'];

    string password = Request["password"];
    string confirmPassword = Request["confirmPassword"];

    if (Request["updatePassword"] != null)
    {
        if (!string.IsNullOrEmpty(password) && !string.IsNullOrEmpty(confirmPassword))
        {
            if (password == confirmPassword)
            {
                Response.Write("Password are same");
                try
                {

                    System.Security.Cryptography.SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
                    byte[] Bytes = Encoding.ASCII.GetBytes(password);
                    byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
                    string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

                    //string query = "select * from tbl_user where enrollment_number = " + EnrollmentNumber + " and password = '" + HashedPassword + "'";
                    string query = "update tbl_user set Password ='"+ HashedPassword +"' where User_ID= '" + Session["user_id"] + "'";
                    string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";


                    MySql.Data.MySqlClient.MySqlConnection connection = new MySql.Data.MySqlClient.MySqlConnection(ConnectionString);
                    MySql.Data.MySqlClient.MySqlDataAdapter adapter  = new MySql.Data.MySqlClient.MySqlDataAdapter();
                    MySql.Data.MySqlClient.MySqlCommand Command = new MySql.Data.MySqlClient.MySqlCommand(query, connection);

                    if (connection == null)
                        Response.Write("not connected");
                    else
                        Response.Write("Connected");
                    //Response.Write(query);
                    connection.Open();
                    Command.ExecuteNonQuery();
                    Command.Dispose();
                    if (Command.ExecuteNonQuery() != 0)
                    {
                        Response.Write("<script>if(confirm('Password has been updated successfully')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
                        //Response.Write("<script>alert('Password has been changed')</script>");
                        //Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        Response.Write("Password has not been updated");
                    }
                    //Response.Write("Password has been changed");
                    connection.Close();
                }
                catch (Exception error)
                {
                    Response.Write(error);
                    //Response.Write("<script>if(confirm('enrollment number required')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
                }
            }
            else
            {
                Response.Write("Passwords are not same");
            }
        }
        else
            Response.Write("Something is empty");
        //    Response.Write("<script>if(confirm('enrollment number or password is not provided')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
    }


%>

    <%--  --%>


<!DOCTYPE html>
<!-- Created By CodingLab - www.codinglabweb.com -->
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <!---<title> Responsive Registration Form | CodingLab </title>--->
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">

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
        <div class="title">Password Reset</div>
        <div class="content">
            <form action="" method="post" runat="server">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Password</span>
                        <input type="password" ID="password" name="password" runat="server" placeholder="Enter your password" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Confirm Password</span>
                        <input type="password" id="confirmPassword" name="confirmPassword" runat="server" placeholder="Enter your password" required>
                    </div>
                </div>

                
                <div class="button">
                    <input type="submit"  name="updatePassword"  id="updatePassword" value="Update Password">
                </div>
            </form>
        </div>
    </div>

</body>

</html>