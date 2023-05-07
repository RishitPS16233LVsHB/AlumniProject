<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateJobAlert.aspx.cs" Inherits="AlumniProject.CreateJobAlert" %>

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
    void InsertIntoJobAlertTable(string jobAlertTitle, string jobAlertDescription, string company, int location, int technology, int designation, int vacancies, int package, int experience, string cnum, string email)
    {
        try
        {
            if (Session["user_id"] != null && (int)Session["user_id"] != -1)
            {
                int UserID = (int)Session["user_id"];
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "insert into tbl_job_alert(job_alert_title,job_description,company_name,company_email,company_contact_number,vacancies,experience,package,technology_id,place_of_work_id,job_title_id,created_by,modified_by)" +
                "values" +
                "('" + jobAlertTitle + "','" + jobAlertTitle + "','" + company + "'," +
                "'" + email + "','" + cnum + "'," + vacancies + "," + experience + "," + package + "," + technology + "," + location + "," + designation + "," + UserID + "," + UserID + ");";
                MySqlCommand command = new MySqlCommand(query, connection);


                if (command.ExecuteNonQuery() != 0)
                    Response.Write("<script>alert('Job created successfully');document.location.href='Jobs.aspx';</script>");
                else
                    Response.Write("<script>if(confirm('was not able to execute query')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");

                CloseConnection(ref connection);
            }
            else
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception error) { }
    }

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    else
    {

        if (Request["submit"] != null)
        {

            Response.Write("here");
            string title = Request["title"];
            string description = Request["description"];
            string company = Request["company"];
            string phone = Request["phone"];
            string email = Request["email"];

            int location = Convert.ToInt32(Request["location"]);
            int technology = Convert.ToInt32(Request["technology"]);
            int designation = Convert.ToInt32(Request["designation"]);
            int vacancies = Convert.ToInt32(Request["vacancies"]);
            int package = Convert.ToInt32(Request["package"]);
            int experience = Convert.ToInt32(Request["experience"]);


            if
                (
                    !string.IsNullOrEmpty(title) &&
                    !string.IsNullOrEmpty(description) &&
                    !string.IsNullOrEmpty(company) &&
                    !string.IsNullOrEmpty(phone) &&
                    !string.IsNullOrEmpty(email)
                )
            {
                InsertIntoJobAlertTable(title, description, company, location, technology, designation, vacancies, package, experience, phone, email);
            }
            else
                Response.Write("<script>alert('some fields were empty')</script>");
        }

%>
<html lang="en">

<head>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"
        integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="CreatePostCss.css">
</head>

<body>

    <div class="row comment-box-main-job p-4 rounded-bottom">
        <a href="homePage.aspx"> <img class="BackButton" src="Images/BackButton.png"> </a>
        <h3 class="ChatTitle"> Create Job alert</h3>
    </div>


    <div class="chattingWindow">
        <div class="ChatWin">
            <div class="container">
                <form class="form-horizontal" action="#" runat="server"  method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Job Title</label>
                        <input class="form-control" runat="server" id="title" placeholder="Job title here..." type="text" name = "jobtitle">
                    </div>
                    <div class="form-group">
                        <label for="focusedInput">Job Description</label>
                        <textarea class="form-control" runat="server" id="description" placeholder="Job description..." cols="100" name = "jobdescription"
                        rows="5"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Company</label>
                        <input class="form-control" runat="server" id="company" placeholder="Company name here..." type="text" name = "company">
                    </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Company Location</label>
                        <select name="location" id="location" required>
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
                        </select>
                        </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Technology</label>
                        <select name="technology"  id="technology" required>
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
                    </div>

                    <div class="form-group">
                        <label for="focusedInput fw-bold">Designation</label>
                        <select name="designation" id="desgination" required>
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
						</select>
                    </div>    
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Vacancies</label>
                        <input class="form-control" runat="server" id="vacancies" placeholder="Number of vacancies" type="number" name = "vacancies">
                    </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Package</label>
                        <input class="form-control" runat="server" id="package" placeholder="Ex :- 3-6 LPA" type="number" name = "package">
                    </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Experience</label>
                        <input class="form-control" runat="server" id="experience" placeholder="Ex :- 1-5 years" type="number" name = "experience">
                    </div>

                    <div class="form-group">
                        <label for="focusedInput fw-bold">Contact Number </label>
                        <input class="form-control" runat="server" id="phone" placeholder="Contact number"
                        name = "cnum">
                    </div>
                    <div class="form-group">
                        <label for="focusedInput fw-bold">Email Address </label>
                        <input class="form-control" runat="server" id="email" placeholder="Email Address" type="email" name = "email">
                    </div>
                    <br>
                    <input class = "submitbtnjob" runat="server" id="submit" value = "Post!" type = "submit">
                </form>
            </div>
            <br>
            </form>
        </div>
    </div>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="js/lightbox.js"></script>
    <script type="text/javascript" src="js/all.js"></script>
    <script type="text/javascript" src="js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="js/owl.carousel.js"></script>
    <script type="text/javascript" src="js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="js/jquery.rateyo.js"></script>
    <!-- <script type="text/javascript" src="js/jquery.mmenu.all.js"></script> -->
    <!-- <script type="text/javascript" src="js/jquery.meanmenu.min.js"></script> -->
    <script type="text/javascript" src="js/custom.js"></script>
</body>
<script src='https://cdnjs.cloudflare.com/ajax/libs/vue/0.12.14/vue.min.js'></script>

</html>
<%} %>