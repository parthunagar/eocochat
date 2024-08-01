<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title><?php echo getenv('APP_TITLE');?></title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="<?php echo base_url('/assets/css_theme/bootstrap.min.css'); ?>">
    <!-- Font Awesome -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">


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
   
  </head>

  <body class="nav-md log-con">
    <div class="container body">
      <div class="main_container">
       
      
        <!-- page content -->
        <!-- page content -->
        <div class="">
            <div class="clearfix"></div>
              <div class="col-md-6 col-xs-12"><div class="log-img"><img src="<?php echo base_url('/assets/test/images/login_bg_img.png '); ?>"></div></div>
              <div class="col-md-6 col-xs-12">
              <div class="log-wrap">

                <?php if ($this->session->flashdata('msg')) { ?>
              <div id="mydiv" class="alert alert-danger marg-tp-60"><?= $this->session->flashdata('category_success') ?>
             Please enter valid Email or password.
             </div>
             <?php } ?>
              <?php if ($this->session->flashdata('block')) { ?>
               <div id="mydiv" class="alert alert-danger marg-tp-60"><?= $this->session->flashdata('category_success') ?>
             You action has been block. Contact to admin.
             </div>
             <?php } ?>

              <?php if ($this->session->flashdata('success')) { ?>
               <div id="mydiv" class="alert alert-success marg-tp-60"><?= $this->session->flashdata('category_success') ?>
             Check your mail to reset password!
             </div>
             <?php } ?>

                <div class="x_panel login-bg">

                  <div class="x_content login-txt">
                    <h2><?php echo getenv('APP_NAME');?></h2>
                    <span>Forgot Your Password?</span>
                   
                  </div>
                  
                    <br />
                    <form class="form-horizontal form-label-left input_mask" action="<?php echo base_url('index.php/Admin/forgot_password') ?>" method="POST"  data-parsley-validate>


                      
                      <div class="col-md-12 col-sm-12 col-xs-12 form-group has-feedback" style="margin-bottom: 4%">
                        <input type="email" name="email" required = "" class="form-control has-feedback-right input2" id="exampleInputEmail1" placeholder="Email" value = "">

                        
                        <span class="fa fa-envelope form-control-feedback right icn-rht" aria-hidden="true"></span>
                        <span class="form-link"><a href="<?php echo base_url() ?>" >Back to Login</a></span>
                      </div>

                      

                    
                      
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <button type="submit" class="btn btn6 col-md-12 col-sm-12 col-xs-12">GO</button>
                        </div>
                      </div>

                    </form>
                  </div>
                

              </div>
      </div>
         </div>
                <!-- /page content -->

        <!-- /page content -->

      </div>
    </div>
<script type="text/javascript">
setTimeout(function() {
   $('#mydiv').fadeOut('fast');
}, 5000); // <-- time in milliseconds
</script>
    
  </body>
</html>

<style>
  .form-link{
    font-size: 13px;
    color: red;
    font-weight: 560;
    
  }
</style>
