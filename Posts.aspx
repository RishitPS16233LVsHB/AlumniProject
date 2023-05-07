<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Posts.aspx.cs" Inherits="AlumniProject.Posts" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Security.Cryptography" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<%@Import Namespace="System.Net.Mail"%>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/all.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/lightbox.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/flexslider.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="css/HomePage_css/jquery.rateyo.css" />
    <link rel="stylesheet" type="text/css" href="inner-page-style.css">
    <link rel="stylesheet" type="text/css" href="HomePage_style.css">
    <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/HomePage_css/johndoe.css">
    <style>
    * {
        margin: 0;
        padding: 0;
    }

    .scrolltop {
			margin: 0 auto;
			position: fixed;
			bottom: 20px;
			right: 10px;
		}

		.scroll {
			position: absolute;
			right: 15px;
			bottom: 40px;
			background: #b2b2b2;
			background: rgba(178, 178, 178, 0.7);
			padding: 20px;
			text-align: center;
			margin: 0 0 0 0;
			cursor: pointer;
			transition: 0.5s;
			-moz-transition: 0.5s;
			-webkit-transition: 0.5s;
			-o-transition: 0.5s;
		}

		.scroll:hover {
			background: rgba(178, 178, 178, 1.0);
			transition: 0.5s;
			cursor: pointer;
			-moz-transition: 0.5s;
			-webkit-transition: 0.5s;
			-o-transition: 0.5s;
		}

		.scroll:hover .fa {
			padding-top: -10px;
		}

		.scroll .fa {
			font-size: 30px;
			margin-top: -5px;
			margin-left: 1px;
			transition: 0.5s;
			-moz-transition: 0.5s;
			-webkit-transition: 0.5s;
			-o-transition: 0.5s;
		}

    .container-fluid {
        background-color: rgb(239, 244, 253);
    }

        .card-body {
            /* background-color:black; */
            margin-bottom: 30px;
            padding: 20px 55px;
            border: 1px solid grey;
            border-radius: 12px;
            background-color: whitesmoke;
            width: 70%;
        }

    .username {
        color: black;
    }

    .username:visited {
        color: black;
    }
        .profile {
            vertical-align: middle;
            border-style: none;
            height: 80px;
            width: 80px;
            border-radius: 50%;
            max-width: 150px;
            /* margin-bottom: 30px; */
        }
        

    .postTime {
        font-size: small;
        color: grey;
    }
    .postHeader{
        display:flex;
        align-items:center;
    }
        .postPic {
            /*object-fit: contain;*/
             width: 100%;
            max-height: 450px;
            /* height: 10%; */
            border-radius: 7%;
            margin-bottom: 10px;
        }
        .commentSection {
            display: flex;
            align-items: center;
        }
    </style>
</head>
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
<body>
    <header class="site-header" style="background-color: white;">
        <div class="top-header">
            <div class="container">
                <div class="top-header-left">
                    <div class="top-header-block">
                        <a href="mailto:info@educationpro.com" itemprop="email"><i class="fas fa-envelope"></i>
                            director.bmiit@utu.ac.in</a>
                    </div>
                    <div class="top-header-block">
                        <a href="tel:+91 2622 290562" itemprop="telephone"><i class="fas fa-phone"></i> +91 2622
                            290562</a>
                    </div>
                </div>
                <div class="top-header-right">
                    <div class="social-block">
                        <ul class="social-list">
                            <li><a href=""><i class="fab fa-viber"></i></a></li>
                            <li><a href=""><i class="fab fa-google-plus-g"></i></a></li>
                            <li><a href=""><i class="fab fa-facebook-square"></i></a></li>
                            <li><a href=""><i class="fab fa-facebook-messenger"></i></a></li>
                            <li><a href=""><i class="fab fa-twitter"></i></a></li>
                            <li><a href=""><i class="fab fa-skype"></i></a></li>
                        </ul>
                    </div>
                    <div class="login-block">
                        <a href="LogoutSession.aspx" id="logOut">Log Out</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Top header Close -->
        <div class="main-header">
            <div class="container">
                <div class="logo-wrap" itemprop="logo">


                </div>
                <div class="nav-wrap">
                    <nav class="nav-desktop">
                        <ul class="menu-list">
                            <li><a href="homePage.aspx">Home</a></li>
                            <%if (Convert.ToInt32(Session["user_type"]) == 1)
                                { %>
                                <li class="menu-parent">Create Post
                                    <ul class="sub-menu">
                                        <li><a href="CreatePosts.aspx">Create Post</a></li>
                                        <li><a href="CreateEvent.aspx">Create Event</a></li>
                                        <li><a href="CreateJobAlert.aspx">Create Jobs</a></li>
                                    </ul>
                                </li>
                            <%} %>
                            <li><a href="Posts.aspx">Posts</a></li>
                            <li><a href="Jobs.aspx">Jobs</a></li>
                            <li><a href="Events.aspx">Events</a></li>
                            <li><a href="OriginalChat.aspx">Chats</a></li>
                            <li><a href="profile.aspx">Profile</a></li>
                        </ul>
                    </nav>
                    <div id="bar">
                        <i class="fas fa-bars"></i>
                    </div>
                    <div id="close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <section class="section" id="resume" style="background-color: white; position : fixed;">
        <div id="mySidepanel" class="sidepanel">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
            <a href="Login.aspx">Home</a>
            <a href="">Manage Profile</a>
            <a href="">Change Password</a>
            <a href="">Manage Occupation</a>
            <a href="">Manage Post</a>
            <a href="">Manage Events</a>
        </div>
    </section>
    <div class="container-fluid">


        <div class="col-md-8 col-sm-8">
            <div class="right_bottun">
                <button class="openbtn" onclick="openNav()"><img class="menuimg" src="HomePage_images/menu_icon.png"
                        alt="#" />
                </button>
            </div>
        </div>


        <!-- <h2 class="mb-5"><span class="text-danger">P</span>rofile</h2> -->
        <div class="row">
            <%
                DataTable PostSet = new DataTable();
                if (!string.IsNullOrEmpty(Session["user_id"].ToString()))
                {
                    try
                    {
                        int userID = Convert.ToInt32(Session["user_id"]);
                        MySqlConnection connection = ConnectToDB();
                        connection.Open();
                        string query = "select                                                                                         " +
                                        "tbl_user.user_id,                                                                              " +
                                        "tbl_user.user_name,                                                                            " +
                                        "tbl_user.profile_photo_path,                                                                   " +
                                        "tbl_community_post.post_title,  tbl_community_post.community_post_id,                          " +
                                        "tbl_community_post.content,                                                                    " +
                                        "tbl_community_post.post_image,                                                                 " +
                                        "tbl_community_post.upload_time                                                                 " +
                                        "    from tbl_user,tbl_community_post where tbl_user.user_id = tbl_community_post.user_id and   " +
                                        "    tbl_community_post.is_enabled = 'y' order by tbl_community_post.upload_time desc;";
                        MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                        adp.Fill(PostSet);
                        connection.Close();
                    }
                    catch (Exception error)
                    {
                        Response.Write(error.Message);
                    }
                }
                else
                    Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
               %> 
            <div class="col-md-6 col-lg-12">

                <h1 class="text-center mb-5 wow fadeInUp" data-wow-delay="0.1s">Posts</h1>
                <div class="container">
                    
                
                <% 
                    if (PostSet != null)
                    {
                        foreach (DataRow row in PostSet.Rows)
                        {%>
                    <div class="card-body " >
                        <div class="postHeader">
                            <% if (!string.IsNullOrEmpty(row["profile_photo_path"].ToString()))
                                {%>
                            <img class="profile" src="<%= trimPath(row["profile_photo_path"].ToString()) %>"alt="your certificate or photo was here!!!">
                            <%} %> <span><p class="title  text-danger" style="margin-left:10px;">
                                <b><a class="username" href="OtherUserProfile.aspx?userid=<%= row["user_id"]%>"><%= row["user_name"]%></a></b>
                            </p></span>
                            
                        </div>
                        <br />  
                        
                        <% if (!string.IsNullOrEmpty(row["post_image"].ToString()))
                            { %>
                        <center><img class="postPic"src="<%= trimPath(row["post_image"].ToString())%>"alt="your certificate or photo was here!!!"></center>
                        <%}%>
                       
                        
                        <br><b>
                            <h1 style="font-weight:bold;"><%= row["post_title"] %></h1>
                        </b>
                        <p class="subtitle" style="font-size:large;"> <%= row["content"]%></p>
                        
                        <p class="postTime"><%= row["upload_time"]%></p>
                        <div class="commentSection">
                            <h5 class="title  text-danger"><b><a class="username"
                                href="AddReplyToPost.aspx?post_id=<%= row["community_post_id"]%>">Reply</a></b>
                            </h5>
                            <h5 class="title  text-danger" style="margin-left:20px;"><b><a class="username"
                                href="SeeReplies.aspx?post_id=<%= row["community_post_id"]%>">See Replies</a></b>
                            </h5>
                         </div>
                    </div>
                    <%
                            }
                        }
                    %>
                        
                </div>
                <div class="scrolltop">
					<div class="scroll icon"><i class="fa fa-4x fa-angle-up"></i></div>
				</div>

            </div>
            
            <script type="text/javascript" src="HomePage_js/jquery-3.3.1.min.js"></script>
            <script type="text/javascript" src="HomePage_js/lightbox.js"></script>
            <script type="text/javascript" src="HomePage_js/all.js"></script>
            <script type="text/javascript" src="HomePage_js/isotope.pkgd.min.js"></script>
            <script type="text/javascript" src="HomePage_js/owl.carousel.js"></script>
            <script type="text/javascript" src="HomePage_js/jquery.flexslider.js"></script>
            <script type="text/javascript" src="HomePage_js/jquery.rateyo.js"></script>
            <script type="text/javascript" src="HomePage_js/custom.js"></script>
            <script>
                function openNav() {
                    document.getElementById("mySidepanel").style.width = "250px";
                }

                function closeNav() {
                    document.getElementById("mySidepanel").style.width = "0";
                }
            </script>
</body>

</html>
<script>
    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('.scrolltop:hidden').stop(true, true).fadeIn();
        } else {
            $('.scrolltop').stop(true, true).fadeOut();
        }
    });
    $(function () {
        $(".scroll").click(function () {
            $("html,body").animate({
                scrollTop: $(".thetop").offset().top
            }, "1000");
            return false
        })
    })
</script><%} %>