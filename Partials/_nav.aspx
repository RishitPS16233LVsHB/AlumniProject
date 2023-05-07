<!-- <?php 
    require_once $_SERVER['DOCUMENT_ROOT'].'/PHPAlumniProject/DatabaseConnection/Connections.php';
?> -->

<div class="thetop"></div>
<header class="site-header">
    <div class="top-header">
        <div class="container">
            <div class="top-header-left">
                <div class="top-header-block">
                    <a href="mailto:bmiit.utu.ac.in" itemprop="email"><i class="fas fa-envelope"></i> bmiit.utu.ac.in</a>
                </div>
                <div class="top-header-block">
                    <a href="tel:+91 2622 290562" itemprop="telephone"><i class="fas fa-phone"></i> +91 2622 290562</a>
                </div>
            </div>
            <div class="top-header-right">
                <div class="login-block">
                    <a href="LogoutSession.aspx">LogOut</a>
                    <!-- <a href="">Register</a> -->
                </div>
            </div>
        </div>
    </div>
    <!-- Top header Close -->
    <div class="main-header" style="background-color: #fff;">
        <div class="container" style="background-color: #fff;">
            <div class="logo-wrap" itemprop="logo">
                <!-- <img src="HomePage_images/site-logo.jpg" alt="Logo Image"> -->
                <!-- <h1>Education</h1> -->
            </div>
            <div class="nav-wrap">
                <nav class="nav-desktop">
                    <ul class="menu-list">
                        <li><a href="homePage.aspx">Home</a></li>


                            <%if (Convert.ToInt32(Session["user_type"]) == 1) { %>
                                <li class="menu-parent">Create Post
                                    <ul class="sub-menu">
                                        <li><a href="CreatePosts.aspx">Create Post</a></li>
                                        <li><a href="CreateEvent.aspx">Create Event</a></li>
                                        <li><a href="CreateJobAlert.aspx">Create Jobs</a></li>
                                    </ul>
                                </li>
                            <% } else if (Convert.ToInt32(Session["user_type"]) == 0){ %>
                                        <li><a href="/AdminPanel/html/index.aspx">To admin panel</a></li>
                        <%} %>
                        <li><a href="Posts.aspx">Posts</a></li>
                        <li><a href="Jobs.aspx">Jobs</a></li>
                        <li><a href="Events.aspx">Events</a></li>
                        <li><a href="OriginalChat.aspx">Chats(
                            <!-- <?php
                                $query = "select count(personal_chat_id) as unread_chats from tbl_personal_chats where (user_1 = ".$_SESSION['userid']." && read_user_1 = 1)||(user_2 = ".$_SESSION['userid']." && read_user_2 = 1) and is_enabled = 'y'";
                                $connection = ConnectToDB();
                                $result = mysqli_query($connection,$query);
                                $count = 0;
                                foreach($result as $r)
                                    $count = $r['unread_chats'];
                                echo $count;
                                CloseConnection($connection);
                            ?> -->

                            )</a></li>
                        <li><a href="profile.aspx"><%= Session["MY_USER_NAME_AND_IT_IS_FINAL"].ToString() %></a></li>
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