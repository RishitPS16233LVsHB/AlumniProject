<%@ Language="C#"%>
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
    <!-- WARNING: Respond.js doesn"t work if you view the page via file:// -->
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
                        <h3 class="page-title mb-0 p-0">User Activity</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">User Activity</li>
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
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h2>User Activity</h2>
                                
                                <div class="form-group">
                                <form>
                                    <span>
                                        <select name="banningMaterialLol" id="postJob">
                                            <option value="">--select</option>
                                            <option value="user" selected>User</option>
                                            <option value="post">Post</option>
                                            <option value="job">Job</option>
                                            <option value="event">Event</option>
                                            <option value="request">Requests</option>
                                        </select>
                                    </span>

                                <!-- <button class="btn btn-success  text-white mb-4"  type = "submit" >Search</button> -->
                                <br><input class="btn btn-success  text-white mb-1 mt-2" type = "submit" name = "Search" value = "Search"><br>
                                </form>    
                            </div>

                                <% 
                                if(Request["Search"] != null && Request["banningMaterialLol"] != null)
                                {
                                    // echo "here<br>";
                                    string BanningMaterialChoiceLol = Request["banningMaterialLol"];
                                %>

                                            <% if(BanningMaterialChoiceLol == "post"){
                                                    DataTable PostTable = new DataTable();
                                                    try{
                                                        MySqlConnection connection = ConnectToDB();connection.Open();
                                                        string query = "select                                                                                              "+
                                                                        "tbl_community_post.community_post_id,                                                              "+
                                                                        "tbl_user.user_id,                                                                                  "+
                                                                        "tbl_user.user_name,                                                                                "+
                                                                        "tbl_user.profile_photo_path,                                                                       "+
                                                                        "tbl_community_post.post_title,                                                                     "+
                                                                        "tbl_community_post.content,                                                                        "+
                                                                        "tbl_community_post.post_image,                                                                     "+
                                                                        "tbl_community_post.upload_time                                                                     "+
                                                                        "    from tbl_user,tbl_community_post where tbl_user.user_id = tbl_community_post.user_id and       "+
                                                                        "    tbl_community_post.is_enabled = 'y' order by tbl_community_post.upload_time desc;";

                                                        MySqlDataAdapter adp = new MySqlDataAdapter(query,connection);
                                                        adp.Fill(PostTable);
                                                        connection.Close();
                                                    }
                                                    catch(Exception error)
                                                    {
                                                        Response.Write("system error");
                                                    }
                                                        if(PostTable != null)
                                                            if(PostTable.Rows.Count != 0)
                                                                foreach(DataRow rows in PostTable.Rows){
                                                %>
                                                    <!-- Posts Here -->
                                                    <div class="showPost">  
                                                        <% if (rows["profile_photo_path"] != null)
                                                            {%>
                                                            <img src="<%=trimPath(rows["profile_photo_path"].ToString())%>" alt="user" class="userPic">
                                                        <%} %>
                                                        <h2><%=rows["post_title"]%></h2>
                                                        <h4><%=rows["user_name"]%></h4>
                                                        <h6><%=rows["upload_time"]%></h6>
                                                        <% if(rows["post_image"] != null)%>
                                                            <img src="<%=trimPath(rows["post_image"].ToString())%>" alt="post" >
                                                        <p><%=rows["content"]%></p>
                                                        <div class="col-sm-12 d-flex">
                                                            <a class="btn btn-danger ms-2 text-white" href="BanPost.aspx?post_id=<%=rows["community_post_id"].ToString()%>">Ban</a>
                                                        </div>
                                                    </div>
                                                <% } %>
                                            <% }
                                                else if(BanningMaterialChoiceLol == "user")
                                                {
                                                    DataTable UserTable = new DataTable();
                                                    try
                                                    {
                                                        MySqlConnection connection = ConnectToDB();connection.Open();
                                                        string query = "select                                     "+
                                                                "user_id,                                   "+
                                                                "user_name,                                 "+
                                                                "profile_photo_path                         "+
                                                                "    from tbl_user where is_enabled = 'y'; ";
                                                        MySqlDataAdapter adp = new MySqlDataAdapter(query,connection);
                                                        adp.Fill(UserTable);
                                                        connection.Close();
                                                    }
                                                    catch (Exception error)
                                                    {
                                                        Response.Write(error.Message);
                                                    }
                                                    if(UserTable != null)
                                                        if(UserTable.Rows.Count != 0)
                                                            foreach(DataRow rows in UserTable.Rows){
                                                %>
                                                
                                                <!-- Users Here -->
                                                <div class="showUser" id="showUser" style="border :1px solid grey;padding: 10px 8px;margin-bottom: 5px;">
                                                <% if (rows["profile_photo_path"] != null)
                                                    {%>
                                                            <img src="<%= trimPath(rows["profile_photo_path"].ToString())%>" alt="user" class="userPic"><%} %>

                                                    <h2><%=rows["user_id"].ToString()%></h2>
                                                    <h2><%=rows["user_name"].ToString()%></h2>                                                                                                        
                                                    <div class="col-sm-12 d-flex">
                                                        <a class="btn btn-danger ms-2 text-white" href = "BanUser.aspx?user_id=<%=rows["user_id"].ToString()%>">Ban</a>
                                                    </div>
                                                </div>
                                            <%  %>



                                            <% }}else if(BanningMaterialChoiceLol == "event"){
                                                    DataTable EventTable = new DataTable();
                                                    try{
                                                        //userID = Session["user_id"];
                                                        MySqlConnection connection = ConnectToDB();connection.Open();
                                                        string query = "select                                                          "+
                                                                        "tbl_event.event_id,                                            "+
                                                                        "tbl_event.event_name,                                          "+          
                                                                        "tbl_event.event_photo,                                         "+
                                                                        "tbl_event.event_description,                                   "+
                                                                        "tbl_event.venue,                                               "+
                                                                        "tbl_event.upload_time,                                         "+           
                                                                        "tbl_event.event_time,                                          "+
                                                                        "tbl_event.organizer_name,                                      "+
                                                                        "tbl_user.profile_photo_path,                                   "+
                                                                        "tbl_user.user_name,                                            "+
                                                                        "tbl_user.user_id,                                              "+
                                                                        "tbl_event.organizing_member_id                                 "+
                                                                        "from tbl_event,tbl_user                                        "+
                                                                        "where                                                          "+
                                                                        "    tbl_event.organizing_member_id = tbl_user.user_id and      "+
                                                                        "    tbl_event.is_enabled = 'y';";
                                                        MySqlDataAdapter adp = new MySqlDataAdapter(query,connection);
                                                        adp.Fill(EventTable);
                                                        connection.Close();
                                                    }
                                                    catch(Exception error)
                                                    {
                                                        Response.Write(error.Message);
                                                    }

                                                    if(EventTable != null)
                                                        if(EventTable.Rows.Count != 0)
                                                            foreach(DataRow rows in EventTable.Rows){
                                                    %>
                                                <!-- Events here -->
                                                <div class="showEvent" id="showEvent" style="border :1px solid grey;padding: 10px 8px;margin-bottom: 5px;">
                                                    <% if (rows["profile_photo_path"] != null) {%>
                                                            <img src="<%=trimPath(rows["profile_photo_path"].ToString())%>" alt="user" class="userPic"> <%} %>
                                                    <h2><%=rows["event_name"].ToString()%></h2>
                                                    <h4><%=rows["user_name"].ToString()%></h4>
                                                    <h6><%=rows["upload_time"].ToString()%></h6>                                                                                                        
                                                    <p><%=rows["event_description"]%></p>
                                                    <h3>Organiser: <%=rows["organizer_name"].ToString()%></h3>
                                                    <h4>Location: <%=rows["venue"].ToString()%></h4>
                                                    <h5>Time: <%=rows["event_time"]%></h5>
                                                    <% if(rows["event_photo"]!=null)%>
                                                            <img src="<%=trimPath(rows["event_photo"].ToString())%>" alt="event">
                                                    <div class="col-sm-12 d-flex">
                                                        <!-- <button class="btn btn-success  text-white ">Promote</button> -->
                                                        <a class="btn btn-danger ms-2 text-white " href = "BanEvent.aspx?event_id=<%=rows["event_id"]%>">Ban</a>
                                                    </div>
                                                </div>
                                            <%  }%>



                                            <% }else if(BanningMaterialChoiceLol == "job"){
                                                    DataTable JobTable = new DataTable();
                                                    try{
                                                        //userID = _SESSION["userid"];
                                                        MySqlConnection connection = ConnectToDB();connection.Open();
                                                        string query =  "select tbl_job_alert.job_alert_id,                                                                     "+
                                                                        "    tbl_job_title.job_title,                                                                           "+
                                                                        "    tbl_job_alert.company_name,                                                                        "+
                                                                        "    tbl_place_of_work.place_of_work,                                                                   "+
                                                                        "    tbl_job_alert.package,                                                                             "+
                                                                        "    tbl_job_alert.date_created,                                                                        "+
                                                                        "    tbl_user.profile_photo_path,                                                                       "+
                                                                        "    tbl_user.user_name,                                                                                "+
                                                                        "    tbl_user.user_id                                                                                   "+
                                                                        "                                                                                                       "+
                                                                        "    from tbl_job_alert,tbl_job_title,tbl_place_of_work,tbl_user                                        "+
                                                                        "    where                                                                                              "+
                                                                        "    tbl_job_alert.job_title_id = tbl_job_title.job_title_id and                                        "+
                                                                        "    tbl_job_alert.place_of_work_id = tbl_place_of_work.place_of_work_id and                            "+
                                                                        "    tbl_job_alert.created_by = tbl_user.user_id and                                                    "+
                                                                        "    tbl_job_alert.is_enabled = 'y';";
                                                        MySqlDataAdapter adp = new MySqlDataAdapter(query,connection);
                                                        adp.Fill(JobTable);
                                                        connection.Close();
                                                    }
                                                    catch(Exception error)
                                                    {
                                                        Response.Write(error.Message);
                                                    }

                                                    if(JobTable != null)
                                                        if(JobTable.Rows.Count != 0)
                                                            foreach(DataRow rows in JobTable.Rows){
                                                %>
                                                <!-- Job Alerts Here -->
                                                <div class="showJob" id="showJob">
                                                    <div class="showEvent" id="showEvent" style="border :1px solid grey;padding: 10px 8px;margin-bottom: 5px;">
                                                        <% if(rows["profile_photo_path"] != null){%>
                                                            <img src="<%=trimPath(rows["profile_photo_path"].ToString())%>" alt="user" class="userPic"> <%} %>
                                                    <h2><%=rows["user_name"]%></h2>
                                                    <p>Title : <span><%=rows["job_title"]%></span></p>
                                                    <p>Company: <span><%=rows["company_name"]%></span></p>
                                                    <p>Vacancies: <span><%=rows["package"]%></span></p>
                                                    <p>Place Of Work: <span><%=rows["place_of_work"]%></span></p>
                                                    <div class="col-sm-12 d-flex">
                                                        <a class="btn btn-danger ms-2 text-white " href = "BanJobAlert.aspx?job_alert_id=<%=rows["job_alert_id"]%>">Ban</a>
                                                    </div>
                                                </div>
                                            <% }}      
                                                else if(BanningMaterialChoiceLol == "request")
                                                {
                                                    DataTable UserTable = new DataTable();
                                                    try
                                                    {
                                                        MySqlConnection connection = ConnectToDB();connection.Open();
                                                        string query = "select                              "+
                                                                "tbl_user.user_id,                                   "+
                                                                "tbl_user.user_name,                                 "+
                                                                "tbl_user.profile_photo_path                         "+
                                                                "    from tbl_user,account_request where account_request.user_id = tbl_user.user_id";
                                                        Response.Write(query);
                                                        MySqlDataAdapter adp = new MySqlDataAdapter(query,connection);
                                                        adp.Fill(UserTable);
                                                        connection.Close();
                                                    }
                                                    catch (Exception error)
                                                    {
                                                        Response.Write(error.Message);
                                                    }
                                                    if(UserTable != null)
                                                        if(UserTable.Rows.Count != 0)
                                                            foreach(DataRow rows in UserTable.Rows){
                                                %>
                                                
                                                <!-- Users Here -->
                                                <div class="showUser" id="showUser1" style="border :1px solid grey;padding: 10px 8px;margin-bottom: 5px;">
                                                <% if (rows["profile_photo_path"] != null)
                                                    {%>
                                                            <img src="<%= trimPath(rows["profile_photo_path"].ToString())%>" alt="user" class="userPic"><%} %>

                                                    <h2><%=rows["user_id"].ToString()%></h2>
                                                    <h2><%=rows["user_name"].ToString()%></h2>                                                                                                        
                                                    <div class="col-sm-12 d-flex">
                                                        <a class="btn btn-danger ms-2 text-white" href = "AcceptUser.aspx?id=<%=rows["user_id"].ToString()%>">Accept</a>
                                                        <a class="btn btn-danger ms-2 text-white" href = "RejectUser.aspx?id=<%=rows["user_id"].ToString()%>">Reject</a>
                                                    </div>
                                                </div>
                                            <%  %>



                                            <% }} %>
                                <% } %>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- ===================================-->
            </div>
            <!-- ============================================================== -->
            <!-- #Include file="footer.aspx"-->
        </div>
    </div>

    <script>
        function showJobPost() {
            let postJob = document.getElementById("postJob");
            let showPost = document.getElementById("showPost");
            let showJob = document.getElementById("showJob");
            let showUser = document.getElementById("showUser")
            let showEvent = document.getElementById("showEvent");
            let selectedValue = postJob.value;
            console.log(selectedValue);
            if (selectedValue == "post") {
                showUser.classList.remove("displayBlock");
                showUser.classList.add("displayNone");
                showPost.classList.add("displayBlock");
                showPost.classList.remove("displayNone");
                showJob.classList.remove("displayBlock");
                showJob.classList.add("displayNone");
                showEvent.classList.add("displayNone");
                showEvent.classList.remove("displayBlock");
            }
            if (selectedValue == "job") {
                showUser.classList.add("displayNone");
                showUser.classList.remove("displayBlock");
                showPost.classList.remove("displayBlock");
                showPost.classList.add("displayNone");
                showJob.classList.add("displayBlock");
                showJob.classList.remove("displayNone");
                showEvent.classList.add("displayNone");
                showEvent.classList.remove("displayBlock");
            }
            if (selectedValue == "user") {
                showUser.classList.add("displayBlock");
                showPost.classList.remove("displayBlock");
                showPost.classList.add("displayNone");
                showJob.classList.remove("displayBlock");
                showJob.classList.add("displayNone");
                showEvent.classList.add("displayNone");
                showEvent.classList.remove("displayBlock");
            }
            if(selectedValue == "event"){
                showUser.classList.add("displayNone");
                showUser.classList.remove("displayBlock");
                showPost.classList.remove("displayBlock");
                showPost.classList.add("displayNone");
                showJob.classList.remove("displayBlock");
                showJob.classList.add("displayNone");
                showEvent.classList.remove("displayNone");
                showEvent.classList.add("displayBlock");
            }
        }
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