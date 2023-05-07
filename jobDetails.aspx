<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jobDetails.aspx.cs" Inherits="AlumniProject.JobDetails" %>
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

    string trimPath(string Path)
    {
        try
        {
            if (Path != null)
            {
                string[] separatedPath = Path.Split('/');
                string FinalPath = separatedPath[separatedPath.Length - 3] + "/" + separatedPath[separatedPath.Length - 2] + "/" + separatedPath[separatedPath.Length - 1];
                return FinalPath;
            }
            return "";
        }
        catch (Exception error)
        {
            return "";
        }
    }

    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    else
    {

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- #include file="Partials/_headerlinks.html"-->
    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="css/jobTitle_css/lib/animate/animate.min.css" rel="stylesheet">
    <link href="css/jobTitle_css/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/jobTitle_css/bootstrap.min.css" rel="stylesheet">
    <link href="css/jobTitle_css/style.css" rel="stylesheet">
</head>

<body style="background-color: rgb(239, 244, 253);">
    <div class="row comment-box-main-job p-4 rounded-bottom">
        <a href="Jobs.aspx"> <img class="BackButton" src="HomePage_images/BackButton.png" style="
        width: 50px; height: 50px; padding-left: 3px; filter: grayscale(0%);"> </a>
    </div>

    <% 
        DataTable JobDetailsSet = new DataTable();
        if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
        {
            try
            {
                int userID = (int)Session["user_id"];
                int id = 0;
                if (string.IsNullOrEmpty(Request["job_alert_id"]))
                    Response.Redirect("Login.aspx");
                else
                {
                    id = Convert.ToInt32(Request["job_alert_id"]);
                    MySqlConnection connection = ConnectToDB();
                    connection.Open();
                    string query = "  select                                                                       " +
                                    "    tbl_job_title.job_title,                                                   " +
                                    "    tbl_place_of_work.place_of_work,                                           " +
                                    "    tbl_job_alert.package,                                                     " +
                                    "    tbl_user.profile_photo_path,                                               " +
                                    "                                                                               " +
                                    "    tbl_job_alert.job_alert_title,                                             " +
                                    "    tbl_job_alert.job_description,                                             " +
                                    "                                                                               " +
                                    "    tbl_job_alert.date_created,                                                " +
                                    "    tbl_job_alert.vacancies,                                                   " +
                                    "    tbl_job_alert.experience,                                                  " +
                                    "    tbl_technology.technology_name,                                            " +
                                    "                                                                               " +
                                    "    tbl_job_alert.company_name,                                                " +
                                    "    tbl_job_alert.company_email,                                               " +
                                    "    tbl_job_alert.company_contact_number,                                      " +
                                    "                                                                               " +
                                    "    tbl_job_alert.attached_photo_url                                           " +
                                    "                                                                               " +
                                    "    from tbl_job_alert,                                                        " +
                                    "         tbl_job_title,                                                        " +
                                    "         tbl_place_of_work,                                                    " +
                                    "         tbl_user,                                                             " +
                                    "         tbl_technology                                                        " +
                                    "    where                                                                      " +
                                    "    tbl_job_alert.technology_id = tbl_technology.technology_id and             " +
                                    "    tbl_job_alert.job_title_id = tbl_job_title.job_title_id and                " +
                                    "    tbl_job_alert.place_of_work_id = tbl_place_of_work.place_of_work_id and    " +
                                    "    tbl_job_alert.created_by = tbl_user.user_id and                            " +
                                    "    tbl_job_alert.job_alert_id = " + id + " and                                       " +
                                    "    tbl_job_alert.is_enabled = 'y';";

                    MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                    adp.Fill(JobDetailsSet);
                    connection.Close();
                }
            }
            catch (Exception error)
            {
                Response.Write(error.Message);
            }
        }
        else
            Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>>");
    %>
    <%foreach (DataRow rows in JobDetailsSet.Rows)
        { %>
    <div class="container-xxl py-5 wow fadeInUp mt-3 mb-3" data-wow-delay="0.1s" style="background-color: #fff;font-size:15px">
        <div class="container">
            <div class="row gy-5 gx-4">
                <div class="col-lg-8">
                    <div class="d-flex align-items-center mb-5">
                        <% if (!string.IsNullOrEmpty(rows["profile_photo_path"].ToString()))
                            {%>
                            <img class="flex-shrink-0 img-fluid border rounded" src="
                                <%= trimPath(rows["profile_photo_path"].ToString())%>" 
                                alt="" style="width: 80px; height: 80px;">
                        <% } %>
                        <div class="text-start ps-4">
                            <h2 class="mb-3" style=" color:#1c3961;font-weight:600;font-size:x-large;" style=" color:#1c3961;"><%=rows["job_title"] %></h2>
                        </div>
                    </div>

                    <div class="mb-5">

                        <h2 class="mb-3" style=" color:#1c3961;font-weight:600;"><%=rows["job_alert_title"]%></h4>
                            <p><%= rows["job_description"]%></p>

                                    <div class=" p-5 wow slideInUp " data-wow-delay="0.1s" style="background-color: rgb(239, 244, 253);border-radius:10px">
                                        <h2 class="mb-4 mt-20" style=" color:#1c3961;font-weight:600;">Job Summary</h4>
                                            <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Published On:<%=rows["date_created"] %></p>
                                            <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Vacancy:<%=rows["vacancies"] %></p>
                                            <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Salary:<%=rows["package"] %></p>
                                            <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Location:<%=rows["place_of_work"] %></p>
                                            <p class="m-0"><i class="fa fa-angle-right  me-2"></i>Major technology:<%=rows["technology_name"] %></p>
                                    </div>
                                    <div class="  p-5 mt-5 wow slideInUp" data-wow-delay="0.1s" style="background-color: rgb(239, 244, 253);border-radius:10px">
                                        <h2 class="mb-4" style=" color:#1c3961;font-weight:600;"><%= rows["company_name"] %></h4>
                                        <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Email :<%=rows["company_email"] %></p>
                                        <p><i class="fa fa-angle-right  me-2" style=" color:#1c3961;"></i>Contact:<%=rows["company_contact_number"] %></p>
                                    </div>
                    </div>

                    <div class="">
                        <h2 class="mb-4" style=" color:#1c3961;font-weight:600;">Apply For The Job</h4>
                            <form class="form-horizontal ">
                                <div class="row g-3">
                                    <div class="form-group form-group-lg">
                                        <input class="form-control" id="focusedInput" placeholder="Your Name" type="text">
                                    </div>
                                    <div class="form-group col-12">
                                        <input class="form-control" id="focusedInput" placeholder="Your Email" type="email">
                                    </div>
                                    <div class="form-group col-12 col-sm-6">
                                        <input class="form-control" id="focusedInput" type="text" placeholder="Portfolio Website">
                                    </div>
                                    <div class="col-12 col-sm-6">
                                        <input type="file" class="form-control bg-white">
                                    </div>
                                    <div class="col-12">
                                        <textarea class="form-control" rows="5" placeholder="Coverletter"></textarea>
                                    </div>
                                    <div class="col-12">
                                        <button class="btn w-100 applyBtn" type="submit" style="background-color:#1c3961 ; color :#fff;font-size:2rem;">Apply Now</button>
                                    </div>
                                </div>
                            </form>

                    </div>
                </div>

                <div class="col-lg-4 mt-10">
                        <% if (!string.IsNullOrEmpty(rows["attached_photo_url"].ToString()))
                            {%>
                            <img class="flex-shrink-0 img-fluid border rounded" src="
                                <%= trimPath(rows["attached_photo_url"].ToString()) %>" 
                                alt="" style="width: 80px; height: 80px;">
                        <% } %>
                </div>
            </div>
        </div>
    </div>
    </div>
    <%} %>
    <!-- #Include file="Partials/footer.html"-->
    <!-- #Include file="Partials/_navjs.html"-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="css/jobTitle_css/lib/wow/wow.min.js"></script>
    <script src="css/jobTitle_css/lib/easing/easing.min.js"></script>
    <script src="css/jobTitle_css/lib/waypoints/waypoints.min.js"></script>
    <script src="css/jobTitle_css/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/jobTitle_js/main"></script>
</body>

</html><%} %>