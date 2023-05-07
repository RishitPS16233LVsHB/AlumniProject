<%@ Language="C#" %>
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

            foreach (string mailID in recipients)
            {
                mail.To.Add(new MailAddress(mailID));
            }
            mail.Subject = subject;
            mail.IsBodyHtml = isHtml;
            mail.Body = body;

            smtpClient.Send(mail);
            return true;
        }
        catch (Exception error) { Response.Write(error.Message + "----<br>" + error.StackTrace); return false; }
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
    string[] email = { " " };
    try
    {
        if(Request["submit"] != null)
        {


            // filter logic here


            string FilterString = "";
            string Conditional = " or ";
            string NullParameter = " 1 = 0 ";


            FilterString += " and ( ";

            if (Request["match_all"] != null)
            {
                Conditional = " and ";
                NullParameter = " 1 = 1 ";
            }

            if (Request["mail_body"] != null && Request["mail_subject"] != null)
            {
                string[] filterArray = { "","","","" };
                if (Request["tech"] != "-1")
                    filterArray[0] = " user_id in (select user_id from tbl_user_technology where technology_id = " + Request["tech"] + ") ";

                if (Request["place_of_work"] != "-1")
                    filterArray[1] = " place_of_work_id = " + Request["place_of_work"] + " ";

                if (Request["job_title"] != "-1")
                    filterArray[2] = " job_title_id = " + Request["job_title"] + " ";

                if (Request["batch"] != "-1")
                    filterArray[3] = " batch_id = " + Request["batch"] + " ";




                for (int i = 0; i < 3; i++)
                {
                    if (filterArray[i] != "")
                        FilterString += filterArray[i] + Conditional;
                    else
                        FilterString += NullParameter + Conditional;
                }
                if (filterArray[3] != "")
                    FilterString += filterArray[3];
                else
                    FilterString += NullParameter;


                foreach (String f in filterArray)
                {
                    if (f != "")
                        break;

                    else
                        FilterString = " and  1 = 1 ";
                }


                FilterString += " ) ";



                // do not fuck with the above filter logic for the sake of god 



                MySqlConnection Connection = ConnectToDB();
                if (Connection == null)
                    Response.Write("not connected");
                else
                {
                    Connection.Open();
                    string Query = "select email_id,batch_id,job_title_id,place_of_work_id from tbl_user where is_enabled = 'y' ";
                    List<string> Email = new List<string>();

                    MySqlDataAdapter adp = new MySqlDataAdapter(Query, Connection);
                    DataTable EmailIDs = new DataTable();
                    adp.Fill(EmailIDs);
                    foreach (DataRow rows in EmailIDs.Rows)
                        Email.Add(rows["email_id"].ToString());
                    email = Email.ToArray<string>();

                    Connection.Close();
                    if (SendMail(Request["mail_subject"], Request["mail_body"], email))
                        Response.Write("<script>alert('mail sent successfully')</script>");
                    else
                        Response.Write("<script>alert('mail not sent successfully')</script>");
                }
            }
        }
    }
    catch (Exception exception)
    {
        Response.Write("---" + exception.Message);
    }
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description" content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Material Pro Lite Template by WrapPixel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/materialpro-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/postActions.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <!-- #Include file="header.aspx"-->
        <!-- #Include file="aside.aspx"-->
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-8 align-self-center">
                        <h3 class="page-title mb-0 p-0">Email All</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Email All</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-md-6 col-4 align-self-center">

                    </div>
                </div>

            </div>
            <!-- =========================================================== -->
            <div class="container-fluid">
                <!-- ============================= -->
                <!-- ===================================-->
                <form class="form-horizontal form-material mx-2" method="post" runat="server" action="#">
                    Select From Technology:- 
                    <select ID="tech" name="tech">
                        <option value="-1" selected>none</option>
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
                                        Response.Write("<option value=\""+DTR.GetInt32(0)+"\">"+DTR.GetString(1)+"</option>");

                                    DTR.Close();
                                    DTR.Dispose();
                                    connection.Close();
                                }
                                catch (Exception error)
                                { }
                            }
                            %>
                        <%DisplayTechnologyInDropDown();%>
                    </select>
                    Select From Batch:- 
                    <select ID="batch" name="batch">
                        <option value="-1" selected>none</option>
                        <%
                            //MySqlConnection ConnectToDB()
                            //{
                            //    try
                            //    {
                            //        string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";
                            //        MySqlConnection connection = new MySqlConnection(ConnectionString);
                            //        return connection;
                            //    }
                            //    catch (Exception error)
                            //    {
                            //        return null;
                            //    }
                            //}
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
                                            Response.Write("<option value=\""+DTR.GetInt32(0)+"\">"+DTR.GetString(1)+"</option>");

                                    DTR.Close();
                                    DTR.Dispose();
                                    connection.Close();

                                }
                                catch (Exception error)
                                { }
                            }


                            DisplayBatchInDropDown();%>
                    </select>
                    Select From Place of work:- 
                    <select ID="place_of_work" name="place_of_work">
                        <option value="-1" selected>none</option>
                        <%
                            //MySqlConnection ConnectToDB()
                            //{
                            //    try
                            //    {
                            //        string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";
                            //        MySqlConnection connection = new MySqlConnection(ConnectionString);
                            //        return connection;
                            //    }
                            //    catch (Exception error)
                            //    {
                            //        return null;
                            //    }
                            //}
                            void DisplayPlaceOfWork()
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
                                    connection.Close();
                                }
                                catch (Exception error)
                                { }
                            }

                            DisplayPlaceOfWork();%>
                    </select>
                    Select From Job Title:- 
                    <select ID="job_title" name="job_title">
                        <option value="-1" selected>none</option>
                        <%
                            //MySqlConnection ConnectToDB()
                            //{
                            //    try
                            //    {
                            //        string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";
                            //        MySqlConnection connection = new MySqlConnection(ConnectionString);
                            //        return connection;
                            //    }
                            //    catch (Exception error)
                            //    {
                            //        return null;
                            //    }
                            //}
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
                                            Response.Write("<option value=\""+DTR.GetInt32(0)+"\">"+DTR.GetString(1)+"</option>");

                                    DTR.Close();
                                    DTR.Dispose();
                                    connection.Close();

                                }
                                catch (Exception error)
                                { }
                            }



                            DisplayJobTitleInDropDown();%>
                    </select>

                    <br>
                    Match all Parameters:-<input type="checkbox" ID="match_all"  runat="server"/>
                    <br>
                    <br>
                    <br>
                    <div class="form-group">
                        <label class="col-md-12 mb-0">Subject</label>
                        <div class="col-md-12">
                            <input type="text" runat="server" id="mail_subject" placeholder="Email subject here" class="form-control ps-0 form-control-line" name = "subject" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="example-email" class="col-md-12">Body</label>
                        <div class="col-md-12">
                            <textarea  id="mail_body" runat="server" class="form-control ps-0 form-control-line" cols="30" rows="10" placeholder="Enter your content here" name = "content" required></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit" runat="server" value="Send Email">
                        </div>
                    </div>
                </form>
                <%
                    Response.Write("Email Sent to:- <br><table>");
                    foreach (String e in email)
                    {
                        Response.Write("<tr><td>");
                        Response.Write(e);
                        Response.Write("</td></tr>");
                    }   
                    Response.Write("</table>");
                %>
            </div>
            <!-- ============================================================== -->
            <!-- #Include file="footer.aspx" -->
        </div>
    </div>

    <script>

</script>
    <script src="../assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!-- google maps api -->
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="../assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="../assets/plugins/gmaps/jquery.gmaps.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.js"></script>

</body>

</html>









<%-- old code below  --%>
<%--<%@ Language="C#" %>
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

            foreach (string mailID in recipients)
            {
                mail.To.Add(new MailAddress(mailID));
            }
            mail.Subject = subject;
            mail.IsBodyHtml = isHtml;
            mail.Body = body;

            smtpClient.Send(mail);
            return true;
        }
        catch (Exception error) { Response.Write(error.Message + "----<br>" + error.StackTrace); return false; }
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
    try
    {
        if(Request["submit"] != null)
        {
            Response.Write("here<br>");
            if (Request["mail_body"] != null && Request["mail_subject"] != null)
            {
                MySqlConnection Connection = ConnectToDB();
                if (Connection == null)
                    Response.Write("not connected");
                else
                {
                    Connection.Open();
                    string Query = "select email_id from tbl_user where is_enabled = 'y'";
                    List<string> Email = new List<string>();
                    string[] email = { " " };
                    MySqlDataAdapter adp = new MySqlDataAdapter(Query, Connection);
                    DataTable EmailIDs = new DataTable();
                    adp.Fill(EmailIDs);

                    foreach (DataRow rows in EmailIDs.Rows)
                        Email.Add(rows["email_id"].ToString());

                    email = Email.ToArray<string>();



                    Connection.Close();
                    if (SendMail(Request["mail_subject"], Request["mail_body"], email))
                        Response.Write("<script>alert('mail sent successfully')</script>");
                    else
                        Response.Write("<script>alert('mail not sent successfully')</script>");
                }
            }
        }
    }
    catch (Exception exception)
    {
        Response.Write("---" + exception.Message);
    }
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description" content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Material Pro Lite Template by WrapPixel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/materialpro-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/postActions.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <!-- #Include file="header.aspx"-->
        <!-- #Include file="aside.aspx"-->
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-8 align-self-center">
                        <h3 class="page-title mb-0 p-0">Email All</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Email All</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-md-6 col-4 align-self-center">

                    </div>
                </div>

            </div>
            <!-- =========================================================== -->
            <div class="container-fluid">
                <!-- ============================= -->
                <!-- ===================================-->
                <form class="form-horizontal form-material mx-2" method="post" action="#">
                    <div class="form-group">
                        <label class="col-md-12 mb-0">Subject</label>
                        <div class="col-md-12">
                            <input type="text" runat="server" id="mail_subject" placeholder="Email subject here" class="form-control ps-0 form-control-line" name = "subject">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="example-email" class="col-md-12">Body</label>
                        <div class="col-md-12">
                            <textarea  id="mail_body" runat="server" class="form-control ps-0 form-control-line" cols="30" rows="10" placeholder="Enter your content here" name = "content"></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-sm-12 d-flex">
                            <input type ="submit" class="btn btn-success mx-auto mx-md-0 text-white" id="submit" runat="server" value="Send Email">
                        </div>
                    </div>
                </form>

            </div>
            <!-- ============================================================== -->
            <!-- #Include file="footer.aspx" -->
        </div>
    </div>

    <script>

    </script>
    <script src="../assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!-- google maps api -->
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="../assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="../assets/plugins/gmaps/jquery.gmaps.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.js"></script>

</body>

</html>--%>