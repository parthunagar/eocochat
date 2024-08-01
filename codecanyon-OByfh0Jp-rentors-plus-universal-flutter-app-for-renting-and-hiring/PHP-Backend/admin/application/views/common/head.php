<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><?php echo getenv('APP_TITLE');?></title>
	
   	<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/bootstrap.min.css'); ?>">
    <!-- Font Awesome -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">


    <!-- NProgress -->
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/nprogress.css'); ?>">
    <!-- iCheck -->
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/green.css'); ?>">
    <!-- Datatables -->
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/dataTables.bootstrap.min.css'); ?>">


    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/buttons.bootstrap.min.css'); ?>">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/fixedHeader.bootstrap.min.css'); ?>">

    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/responsive.bootstrap.min.css'); ?>">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/scroller.bootstrap.min.css'); ?>">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/custom.min.css'); ?>">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/custom.css'); ?>">
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/no_more_table.css'); ?>">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.3.6/css/bootstrap-colorpicker.css" rel="stylesheet">

   

   
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="javascript:void(0)" class="site_title"><img src="<?php echo base_url('/assets/test/images/logo2.png'); ?>"><span class="rent-text"><?php echo getenv('SIDE_BAR_HEADING');?></span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="<?php echo base_url('/assets/images/faces/face16.jpg'); ?>" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome</span>
                <h2>Admin</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />
