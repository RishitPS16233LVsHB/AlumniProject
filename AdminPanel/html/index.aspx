<%@ Language="C#" %>
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
    
    <link rel="canonical" href="https://www.wrappixel.com/templates/materialpro-lite/" />
    <!-- Favicon icon -->
    <!-- <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png"> -->
    <!-- chartist CSS -->
    <title>Admin Dashboard</title>
    <link href="../assets/plugins/chartist-js/dist/chartist.min.css" rel="stylesheet">
    <link href="../assets/plugins/chartist-js/dist/chartist-init.css" rel="stylesheet">
    <link href="../assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet">
    <!--This page css - Morris CSS -->
    <link href="../assets/plugins/c3-master/c3.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
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
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <!-- #Include file="header.aspx"-->
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- <aside class="left-sidebar" data-sidebarbg="skin6">
            <div class="scroll-sidebar">
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="index.aspx" aria-expanded="false"><i class="mdi me-2 mdi-gauge"></i><span
                                    class="hide-menu">Dashboard</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="pages-profile.aspx" aria-expanded="false">
                                <i class="mdi me-2 mdi-account-check"></i><span class="hide-menu">Profile</span></a>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="table-basic.html" aria-expanded="false"><i class="mdi me-2 mdi-table"></i><span
                                    class="hide-menu">Table</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="icon-material.html" aria-expanded="false"><i
                                    class="mdi me-2 mdi-emoticon"></i><span class="hide-menu">Icon</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="map-google.html" aria-expanded="false"><i class="mdi me-2 mdi-earth"></i><span
                                    class="hide-menu">Google Map</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="pages-blank.html" aria-expanded="false"><i
                                    class="mdi me-2 mdi-book-open-variant"></i><span class="hide-menu">Blank</span></a>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="pages-error-404.html" aria-expanded="false"><i
                                    class="mdi me-2 mdi-help-circle"></i><span class="hide-menu">Error 404</span></a>
                        </li>
                        <li class="text-center p-20 upgrade-btn">
                            <a href="https://www.wrappixel.com/templates/materialpro/"
                                class="btn btn-warning text-white mt-4" target="_blank">Upgrade to
                                Pro</a>
                        </li>
                    </ul>

                </nav>
            </div>-->
        <!-- #Include file="aside.aspx"-->
        <!-- End Sidebar scroll-->
        <div class="sidebar-footer">
            <div class="row">
                <div class="col-4 link-wrap">
                    <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Settings"><i class="ti-settings"></i></a>
                </div>
                <div class="col-4 link-wrap">
                    <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Email"><i class="mdi mdi-gmail"></i></a>
                </div>
                <div class="col-4 link-wrap">
                    <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Logout"><i class="mdi mdi-power"></i></a>
                </div>
            </div>
        </div>
        </aside> -->
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-8 align-self-center">
                        <h3 class="page-title mb-0 p-0">Dashboard</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="AddData.aspx">Add Data</a></li>
                                    <li class="breadcrumb-item"><a href="bulkEmail.aspx">Email All</a></li>
                                    <li class="breadcrumb-item"><a href="report.aspx">Report</a></li>
                                    <li class="breadcrumb-item"><a href="user-activity.aspx">user activity</a></li>
                                    <li class="breadcrumb-item"><a href="LoadDataThroughCSV.aspx">Add Students through csv</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>


                    <!-- <div class="col-md-6 col-4 align-self-center">
                            <div class="text-end upgrade-btn">
                                <a href="https://www.wrappixel.com/templates/materialpro/"
                                    class="btn btn-danger d-none d-md-inline-block text-white" target="_blank">Upgrade to
                                    Pro</a>
                            </div>
                        </div> -->



                </div>
            </div>














            <div class="row">
                <!-- Column -->
                <div class="col-lg-4 col-xlg-3">
                    <!-- Column -->

                    <!-- main profile div here-->
                    <div class="card">
                        <img class="card-img-top" src="../assets/images/background/profile-bg.jpg" alt="Card image cap">
                        <div class="card-body little-profile text-center">
                            <div class="pro-img"><img src="../assets/images/users/4.jpg" alt="user"></div>
                            <h3 class="mb-0">Hardik Shah</h3>
                            <p>Web Designer &amp; Developer</p>
                            <a href="javascript:void(0)" class="mt-2 waves-effect waves-dark btn btn-primary btn-md btn-rounded">Follow</a>
                            <div class="row text-center mt-3">
                                <div class="col-lg-4 col-md-4 mt-3">
                                    <h3 class="mb-0 font-light">1099</h3><small>Posts</small>
                                </div>
                                <div class="col-lg-4 col-md-4 mt-3">
                                    <h3 class="mb-0 font-light">23,469</h3><small>Followers</small>
                                </div>
                                <div class="col-lg-4 col-md-4 mt-3">
                                    <h3 class="mb-0 font-light">6035</h3><small>Following</small>
                                </div>
                            </div>
                        </div>
                    </div>



                    <!-- Column -->

                    <!-- contacts div here-->
                    <div class="card">
                        <div class="card-body bg-info">
                            <h4 class="text-white card-title">My Contacts</h4>
                            <h6 class="card-subtitle text-white mb-0 op-5">Checkout my contacts here</h6>
                        </div>
                        <div class="card-body">
                            <div class="message-box contact-box">
                                <h2 class="add-ct-btn"><button type="button" class="btn btn-circle btn-lg btn-success waves-effect waves-dark">+</button>
                                </h2>
                                <div class="message-widget contact-widget">
                                    <!-- Message -->
                                    <a href="#" class="d-flex align-items-center">
                                        <div class="user-img mb-0"> <img src="../assets/images/users/1.jpg" alt="user" class="img-circle"> <span class="profile-status online pull-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5 class="mb-0">Pavan kumar</h5> <span class="mail-desc">info@wrappixel.com</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#" class="d-flex align-items-center">
                                        <div class="user-img mb-0"> <img src="../assets/images/users/2.jpg" alt="user" class="img-circle"> <span class="profile-status busy pull-right"></span>
                                        </div>
                                        <div class="mail-contnet">
                                            <h5 class="mb-0">Sonu Nigam</h5> <span class="mail-desc">pamela1987@gmail.com</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#" class="d-flex align-items-center">
                                        <div class="user-img mb-0"> <span class="round">A</span> <span class="profile-status away pull-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5 class="mb-0">Arijit Sinh</h5> <span class="mail-desc">cruise1298.fiplip@gmail.com</span>
                                        </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="#" class="d-flex align-items-center">
                                        <div class="user-img mb-0"> <img src="../assets/images/users/4.jpg" alt="user" class="img-circle"> <span class="profile-status offline pull-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5 class="mb-0">Pavan kumar</h5> <span class="mail-desc">kat@gmail.com</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>




                <div class="col-lg-8 col-xlg-9">
                    <div class="card">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs profile-tab" role="tablist">



                            <!-- do not need the activities tab here-->
                            <!-- <li class="nav-item"> <a class="nav-link active" data-bs-toggle="tab" href="#home"
                                        role="tab">Activity</a>
                                </li> -->


                            <li class="nav-item"> <a class="nav-link" data-bs-toggle="tab" href="#profile" role="tab">Profile</a> </li>
                            <li class="nav-item"> <a class="nav-link" data-bs-toggle="tab" href="#settings" role="tab">Settings</a>
                            </li>
                        </ul>



                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="home" role="tabpanel">
                                <div class="card-body">
                                    <div class="profiletimeline border-start-0">








                                        <div class="tab-pane" id="profile" role="tabpanel">
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-3 col-xs-6 b-r"> <strong>Full Name</strong>
                                                        <br>
                                                        <p class="text-muted">Hardik Shah</p>
                                                    </div>
                                                    <div class="col-md-3 col-xs-6 b-r"> <strong>Mobile</strong>
                                                        <br>
                                                        <p class="text-muted">(123) 456 7890</p>
                                                    </div>
                                                    <div class="col-md-3 col-xs-6 b-r"> <strong>Email</strong>
                                                        <br>
                                                        <p class="text-muted">johnathan@admin.com</p>
                                                    </div>
                                                    <div class="col-md-3 col-xs-6"> <strong>Location</strong>
                                                        <br>
                                                        <p class="text-muted">Bardoli</p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <p class="mt-4">Donec pede justo, fringilla vel, aliquet nec, vulputate
                                                    eget,
                                                    arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae,
                                                    justo. Nullam
                                                    dictum felis eu pede mollis pretium. Integer tincidunt.Cras dapibus.
                                                    Vivamus
                                                    elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo
                                                    ligula,
                                                    porttitor eu, consequat vitae, eleifend ac, enim.</p>
                                                <p>Lorem Ipsum is simply dummy text of the printing and typesetting
                                                    industry.
                                                    Lorem Ipsum has been the industry's standard dummy text ever since
                                                    the
                                                    1500s, when an unknown printer took a galley of type and scrambled
                                                    it to
                                                    make a type specimen book. It has survived not only five centuries
                                                </p>
                                                <p>It was popularised in the 1960s with the release of Letraset sheets
                                                    containing Lorem Ipsum passages, and more recently with desktop
                                                    publishing
                                                    software like Aldus PageMaker including versions of Lorem Ipsum.</p>
                                                <h4 class="font-medium mt-4">Skill Set</h4>
                                                <hr>
                                                <h5 class="d-flex mt-4">Wordpress <span class="ms-auto">80%</span></h5>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width:80%; height:6px;">
                                                        <span class="sr-only">50% Complete</span>
                                                    </div>
                                                </div>
                                                <h5 class="d-flex mt-4">HTML 5 <span class="ms-auto">90%</span></h5>
                                                <div class="progress">
                                                    <div class="progress-bar bg-info" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width:90%; height:6px;">
                                                        <span class="sr-only">50% Complete</span>
                                                    </div>
                                                </div>
                                                <h5 class="d-flex mt-4">jQuery <span class="ms-auto">50%</span></h5>
                                                <div class="progress">
                                                    <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:50%; height:6px;">
                                                        <span class="sr-only">50% Complete</span>
                                                    </div>
                                                </div>
                                                <h5 class="d-flex mt-4">Photoshop <span class="ms-auto">70%</span></h5>
                                                <div class="progress">
                                                    <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:70%; height:6px;">
                                                        <span class="sr-only">50% Complete</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>




                            <!--second tab-->
                            <div class="tab-pane" id="profiles" role="tabpanel">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3 col-xs-6 b-r"> <strong>Full Name</strong>
                                            <br>
                                            <p class="text-muted">Johnathan Deo</p>
                                        </div>
                                        <div class="col-md-3 col-xs-6 b-r"> <strong>Mobile</strong>
                                            <br>
                                            <p class="text-muted">(123) 456 7890</p>
                                        </div>
                                        <div class="col-md-3 col-xs-6 b-r"> <strong>Email</strong>
                                            <br>
                                            <p class="text-muted">johnathan@admin.com</p>
                                        </div>
                                        <div class="col-md-3 col-xs-6"> <strong>Location</strong>
                                            <br>
                                            <p class="text-muted">London</p>
                                        </div>
                                    </div>
                                    <hr>
                                    <p class="mt-4">Donec pede justo, fringilla vel, aliquet nec, vulputate eget,
                                        arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam
                                        dictum felis eu pede mollis pretium. Integer tincidunt.Cras dapibus. Vivamus
                                        elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula,
                                        porttitor eu, consequat vitae, eleifend ac, enim.</p>
                                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                                        Lorem Ipsum has been the industry's standard dummy text ever since the
                                        1500s, when an unknown printer took a galley of type and scrambled it to
                                        make a type specimen book. It has survived not only five centuries </p>
                                    <p>It was popularised in the 1960s with the release of Letraset sheets
                                        containing Lorem Ipsum passages, and more recently with desktop publishing
                                        software like Aldus PageMaker including versions of Lorem Ipsum.</p>
                                    <h4 class="font-medium mt-4">Skill Set</h4>
                                    <hr>
                                    <h5 class="d-flex mt-4">Wordpress <span class="ms-auto">80%</span></h5>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width:80%; height:6px;">
                                            <span class="sr-only">50% Complete</span>
                                        </div>
                                    </div>
                                    <h5 class="d-flex mt-4">HTML 5 <span class="ms-auto">90%</span></h5>
                                    <div class="progress">
                                        <div class="progress-bar bg-info" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width:90%; height:6px;">
                                            <span class="sr-only">50% Complete</span>
                                        </div>
                                    </div>
                                    <h5 class="d-flex mt-4">jQuery <span class="ms-auto">50%</span></h5>
                                    <div class="progress">
                                        <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:50%; height:6px;">
                                            <span class="sr-only">50% Complete</span>
                                        </div>
                                    </div>
                                    <h5 class="d-flex mt-4">Photoshop <span class="ms-auto">70%</span></h5>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:70%; height:6px;">
                                            <span class="sr-only">50% Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" id="settings" role="tabpanel">
                                <div class="card-body">
                                    <form class="form-horizontal form-material mx-2">
                                        <div class="form-group">
                                            <label class="col-md-12">Full Name</label>
                                            <div class="col-md-12">
                                                <input type="text" placeholder="Johnathan Doe" class="form-control form-control-line ps-0">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="example-email" class="col-md-12">Email</label>
                                            <div class="col-md-12">
                                                <input type="email" placeholder="johnathan@admin.com" class="form-control form-control-line ps-0" name="example-email" id="example-email">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-12">Password</label>
                                            <div class="col-md-12">
                                                <input type="password" value="password" class="form-control form-control-line ps-0">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-12">Phone No</label>
                                            <div class="col-md-12">
                                                <input type="text" placeholder="123 456 7890" class="form-control form-control-line ps-0">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-12">Message</label>
                                            <div class="col-md-12">
                                                <textarea rows="5" class="form-control form-control-line ps-0"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-12">Select Country</label>
                                            <div class="col-sm-12 border-bottom">
                                                <select class="form-select shadow-none border-0 form-control-line ps-0">
                                                    <option>London</option>
                                                    <option>India</option>
                                                    <option>Usa</option>
                                                    <option>Canada</option>
                                                    <option>Thailand</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <button class="btn btn-success text-white">Update Profile</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>








                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- Table -->
            <!-- ============================================================== -->


        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
        <footer class="footer" style="text-align:center"> © 2021 Material Pro Admin by
            <!-- <a href="https://www.wrappixel.com/">wrappixel.com </a> -->
        </footer>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="../assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!-- ============================================================== -->
    <!-- This page plugins -->
    <!-- ============================================================== -->
    <!-- chartist chart -->
    <script src="../assets/plugins/chartist-js/dist/chartist.min.js"></script>
    <script src="../assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.min.js"></script>
    <!--c3 JavaScript -->
    <script src="../assets/plugins/d3/d3.min.js"></script>
    <script src="../assets/plugins/c3-master/c3.min.js"></script>
    <!--Custom JavaScript -->
    <script src="js/pages/dashboards/dashboard1.js"></script>
    <script src="js/custom.js"></script>
</body>

</html>