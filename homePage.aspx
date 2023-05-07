<%@ Language="C#" %>
<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="AlumniProject.Events" %>--%>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Security.Cryptography" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<%@Import Namespace="System.Net.Mail"%>
<% 
    if (Session["user_id"] == null || Session["enrollment_number"] == null || Session["user_type"] == null ||
    Session["user_id"].ToString() == "-1" || Session["enrollment_number"].ToString() == "-1" || Session["user_type"].ToString() == "-1")
    {
        Response.Write("<script>alert('not in session');window.open('LogOutSession.aspx','_blank').focus();window.close();</script>");
    }
    else
    {
        Response.Write(Session["user_type"].ToString());
%>


<!--#include file = "SessionCheck.aspx"-->


<!DOCTYPE html>
<html>

<head>
	<title>Alumni Association System</title>
	
	<!--#Include file="Partials/_headerlinks.html"-->
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
	<style>
		
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
		.banner {
			position: relative;
			margin-bottom: -8px;
			background-image: url('/Homepage_images/blue4.jpg');
			height: 85vh;
			background-size: cover;
			background-repeat: no-repeat;
		}

		.banner .container h1 {
				/* font-size: 4rem; */
				font-weight: bold;
				text-transform: uppercase;
				margin-top: 7em;
		}
		.animatedText{
			background: linear-gradient(90deg, rgba(198,15,170,1) 35%, rgba(3,18,125,1) 100%);
			background-size:400%;
            -webkit-text-fill-color: transparent;
            -webkit-background-clip: text;
			animation:animate 7s linear infinite;
		}
		@keyframes animate{
			0%{
				background-position:0%;
			}
			50%{
				background-position:50%;
			}
			100%{
				background-position:100%;
			}
		}
		/* css editing from here */
		@media screen and (max-width: 550px) {
			.banner .container h1 {
				/* font-size: 4rem; */
				font-weight: bold;
				text-transform: uppercase;
				margin-top: 7em;
			}

			.owl-carousel .owl-item img {
				display: block;
				width: 100%;
				height: 400px;
			}
			.banner .container h1 {
				/* font-size: 4rem; */
				font-weight: bold;
				text-transform: uppercase;
				margin-top: 5em;
			}
		}
		@media screen and (max-width: 1199px) {
			.banner .container h1 {
				margin-top: 3em;
			}
			.owl-carousel .owl-item img {
				display: block;
				width: 100%;
				height: 500px;
			}
		}
		@media screen and (max-width: 1024px) {
			.banner .container h1 {
    /* font-size: 4rem; */
				font-weight: bold;
				text-transform: uppercase;
				margin-top: 4em;
			}
		}
		@media screen and (max-width: 767px){
			.banner .container h1 {
    /* font-size: 4rem; */
			font-weight: bold;
			text-transform: uppercase;
			margin-top: 6em;
			}
		}
		.img-wrap img {
			border-radius: 15%;
			width: auto;
			height: 270px;
			margin-bottom: 10px;
			border-radius: 10%;
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

%>

<body>
	<%--<?php require_once 'Partials/_nav.aspx'; ?>--%>
	<!-- #include file = "Partials/_nav.aspx" -->
	<div id="page " class="site" itemscope itemtype="http://schema.org/LocalBusiness">
		<%--<a href ="LogOutSession.aspx"> Log Out </a>--%>

		<!-- Header Close -->
		<div class="banner">
			<div class="owl-four owl-carousel" itemprop="image">
				<%--<img src="HomePage_images/Homebackground1.jpg" style="background-size: cover;background-repeat:no-repeat" alt="Image of Bannner" />--%>
				<%--<img src="HomePage_images/blue2.jpg" style="background-size: cover;background-repeat:no-repeat" alt="Image of Bannner" />
				<img src="HomePage_images/blue3.jpg" style="background-size: cover;background-repeat:no-repeat" alt="Image of Bannner" />--%>
			</div>
			<div class="container" id="home" itemprop="description">
				<h1> Welcome to <span class="animatedText">Alumni Association System</span></h1>
				<%--<h1 style="">Any institutions' alumni are key to its growth</h1>--%>
<%--				<h3> We are focused on giving a global experience to our students.</h3>--%>
			</div>
			<%--<div id="owl-four-nav" class="owl-nav"></div>--%>
		</div>
		<!-- Banner Close -->
		<div class="page-heading" >
			<div class="container">
				<h2>Latest Events</h2>
			</div>
		</div>
		<!-- Popular courses End -->

		<% DataTable EventSet = new DataTable();

            try
            {
                string userID = Session["user_id"].ToString();
                MySqlConnection connection = ConnectToDB();
                connection.Open();
                string query = "select " +
                         "       tbl_event.event_id,                                        " +
                         "       tbl_event.event_name,                                      " +
                         "       tbl_event.event_photo,                                     " +
                         "       tbl_event.event_description,                               " +
                         "       tbl_event.venue,                                           " +
                         "       tbl_event.upload_time,                                     " +
                         "       tbl_event.event_time,                                      " +
                         "       tbl_event.organizer_name,                                  " +
                         "       tbl_user.profile_photo_path,                               " +
                         "       tbl_user.user_name,                                        " +
                         "       tbl_user.user_id,                                          " +
                         "       tbl_event.organizing_member_id                             " +
                         "       from tbl_event,tbl_user                                    " +
                         "       where                                                      " +
                         "       tbl_event.organizing_member_id = tbl_user.user_id and      " +
                         "       tbl_event.is_enabled = 'y';";
                MySqlDataAdapter adp = new MySqlDataAdapter(query, connection);
                adp.Fill(EventSet);
                connection.Close();
            }
            catch (Exception error)
            {
                Response.Write(error.Message);
            }

        %>

        <%-- Sample Code --%>
		
<%--		<% foreach (DataRow rows in EventSet.Rows)
                        { %>
                    <div class="job-item p-4 mb-4">
                        <div class="row g-4">
                            <div class="col-sm-12 col-md-8 d-flex align-items-center eventImage">
                                <div class="text-start ps-4">
                                    <% if (!string.IsNullOrEmpty(rows["profile_photo_path"].ToString()))
                                        {%>
                                    <img class="flex-shrink-0 img-fluid border rounded" src="
                                                <%= trimPath(rows["event_photo"].ToString())
                                                %>"
                                        alt="" style="width: auto; height: 100px; margin-bottom: 10px;">
                                    <% } %>
                                   
                                </div>
                            </div>
                    </div>
                    <% } %>--%>

        <%-- Ends --%>
		<div class="learn-courses">
			<div class="container">
				<div class="courses">
					<div class="owl-one owl-carousel">
						<%--<%= EventSet.Rows.Count %>--%>
						<% foreach (DataRow rows in EventSet.Rows)
                            { %>
							<div class="box-wrap" itemprop="event" itemscope itemtype=" http://schema.org/Course">
                                <a href="Events.aspx"><div class="img-wrap" itemprop="image">
                                    <%--<img src="HomePage_images/course-pic.jpg" alt="courses picture" style="border-radius: 15%;">--%>
									<% //Response.Write(trimPath(rows["event_photo"].ToString()));
                                        if (rows["profile_photo_path"] != null)
                                        {
                                            if (!string.IsNullOrEmpty(rows["profile_photo_path"].ToString()))
                                            {%>
										<img class="flex-shrink-0 img-fluid border rounded" src="
													<%= trimPath(rows["event_photo"].ToString())
													%>"
										alt="">
                                    <% }
                                        }%>
                                </div></a>

								
                                   
                                <%--<div class="box-body" itemprop="description">
								<p>Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum
									lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum</p>
								<section itemprop="time">
									<p><span>Duration:</span> 4 Years</p>
									<p><span>Class Time:</span> 6am-12am / 11am-5pm</p>
									<p><span>Fee:</span> 4,00,000</p>
								</section>
							</div>--%>
                            </div>
						<% } %>
						

						<%--<div class="box-wrap" itemprop="event" itemscope itemtype=" http://schema.org/Course">
							<div class="img-wrap" itemprop="image"><img src="HomePage_images/course-pic.jpg" alt="courses picture" style="border-radius:15%;"></div>
							<a href="#" class="learn-desining-banner" itemprop="name">Learn Web Designing >>></a>
							
						</div>--%>

						<%--<div class="box-wrap" itemprop="event" itemscope itemtype=" http://schema.org/Course">
							<div class="img-wrap" itemprop="image"><img src="HomePage_images/course-pic.jpg" alt="courses picture" style="border-radius:15%;"></div>
							<a href="#" class="learn-desining-banner" itemprop="name">Learn Web Designing >>></a>--%>
							<%--<div class="box-body" itemprop="description">
								<p>Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum
									lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum</p>
								<section itemprop="time">
									<p><span>Duration:</span> 4 Years</p>
									<p><span>Class Time:</span> 6am-12am / 11am-5pm</p>
									<p><span>Fee:</span> 4,00,000</p>
								</section>
							</div>--%>
						<%--</div>

						<div class="box-wrap" itemprop="event" itemscope itemtype=" http://schema.org/Course">
							<div class="img-wrap" itemprop="image"><img src="HomePage_images/course-pic.jpg" alt="courses picture" style="border-radius:15%;"></div>
							<a href="#" class="learn-desining-banner" itemprop="name">Learn Web Designing >>></a>--%>
							<%--<div class="box-body" itemprop="description">
								<p>Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum
									lorem ipsum Lorem Ipsum lorem ipsum Lorem Ipsum lorem ipsum</p>
								<section itemprop="time">
									<p><span>Duration:</span> 4 Years</p>
									<p><span>Class Time:</span> 6am-12am / 11am-5pm</p>
									<p><span>Fee:</span> 4,00,000</p>
								</section>
							</div>--%>
						<%--</div>--%>
					</div>
				</div>	
			</div>
		</div>
		<!-- Learn courses End -->
		<%--<section class="whyUs-section">
			<div class="container">
				<div class="featured-points">

				</div>
				 <div class="whyus-wrap">

				</div> 
			</div>
		</section>--%>
		<!-- Closed WhyUs section -->

		<section class="page-heading">
			<div class="container">
				<h2>gallery</h2>
			</div>
		</section>
		<section class="gallery-images-section" itemprop="image" itemscope itemtype=" http://schema.org/ImageGallery">
			<div class="gallery-img-wrap">
				<a href="images/gallery-img1.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img1.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img2.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img2.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img3.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img3.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img4.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img4.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img5.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img5.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img6.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img6.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img7.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img7.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img8.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img8.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img9.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img9.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img10.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img10.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img11.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img11.jpg" alt="gallery-images">
				</a>
			</div>
			<div class="gallery-img-wrap">
				<a href="images/gallery-img12.jpg" data-lightbox="example-set" data-title="Click the right half of the image to move forward.">
					<img src="HomePage_images/gallery-img12.jpg" alt="gallery-images">
				</a>
			</div>
		</section>

		<!-- End of Others talk -->
		<section class="page-heading">
			<div class="container">
				<h2>latest Placements</h2>
			</div>
		</section>
		<section class="latest-news">
			<div class="container" itemprop="event" itemscope itemtype=" http://schema.org/Event">
				<div class="owl-two owl-carousel">
					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/Viraj_Thakkar.jpg" alt="Latest News Images" height="100">
						</div>
						<div class="news-detail AlumniName" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Viraj Thakkar</h1>
							</a>
							<!-- <h2> Crest Infosystem Pvt Ltd</h2>
							<h2>Devops Trainee</h2>
							<h1 style="font-size: 25px;">6 LPA</h1> -->
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/priya.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Priya Kanabar</h1>
							</a>
							<!-- <h2>Crest Infosystem Pvt Ltd</h2>
							<h2>Python Developer</h2>
							<h1 style="font-size: 25px;">5.04 LPA</h1> -->
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/Vanukuru.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Vanukuru Sowmyashree</h1>
							</a>
						</div>	
						
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/sourabh.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Sourabh Singh</h1>
							</a>
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/darshil.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Darshil Kadiwala</h1>
							</a>
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/viikas.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Vikas Rajpurohit</h1>
							</a>
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/asif.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Asif Ahmed</h1>
							</a>
						</div>
					</div>

					<div class="news-wrap" itemprop="event">
						<div class="news-img-wrap" itemprop="image">
							<img src="HomePage_images/raj.jpg" alt="Latest News Images">
						</div>
						<div class="news-detail" itemprop="description" style="padding: 1.5625em;border:none; box-sizing: border-box; position: absolute; top: 41%; left: 1%; background: transparent;">
							<a href="">
								<h1>Raj Zalvadiya</h1>
							</a>
						</div>
					</div>

				</div>
				<div class="scrolltop">
					<div class="scroll icon"><i class="fa fa-4x fa-angle-up"></i></div>
				</div>
			</div>

		</section>
		<!-- Latest News CLosed -->

		<!-- End of Query Section -->
		<%--<?php require_once 'Partials/footer.aspx' ?>--%>
		<!-- #include file = "Partials/footer.html" -->


	</div>


	<%--<?php require_once 'Partials/_navjs.aspx' ?>--%>
		<!-- #include file = "Partials/_navjs.html" -->

</body>
</html>
<%} %>