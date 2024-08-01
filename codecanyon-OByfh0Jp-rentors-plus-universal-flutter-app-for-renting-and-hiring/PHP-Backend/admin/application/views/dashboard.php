<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <title>Rentors</title>
  <base target="_self">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google" value="notranslate">


  <!--stylesheets / link tags loaded here-->


  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo base_url('/assets/test/css/bootstrap.css'); ?>" type="text/css">
    <link rel="stylesheet" href="<?php echo base_url('/assets/test/css/bootstrap.min.css'); ?>" type="text/css">
    <link rel="stylesheet" href="<?php echo base_url('/assets/test/css/custom.css'); ?>" type="text/css">
    <link rel="stylesheet" href="<?php echo base_url('/assets/test/css/no_more_table.css'); ?>" type="text/css">

</head>

<body>
  <?php
   $this->load->helper('date'); 
 ?>
<div class="right_col" role="main" style="min-height: 3512px!important;">
<div class="col-md-8 col-xs-12">
<div class="dash1">
  <div class="head1"><img src="<?php echo base_url('/assets/test/images/dash.png '); ?>"><h1>Dashboard</h1></div>
  <div class="wel-admin">
    <div class="row">
      <div class="col-sm-6 col-xs-12">
      <div class="not_bg">
      <h2 class="head2">Welcome Admin,</h2>
      <span class="text1">You Have:</span>
      <ul class="list-inline">
        <li class="clr_blue"><span class="clr1"></span><?php echo count($today_complaints);?> Notification</li>
        <li class="clr_green"><span class="clr2"></span><?php echo $today_product_new;?> New Products</li>
        <li class="clr_red"><span class="clr3"></span><?php echo $today_user_new;?> New Users</li>
      </ul>
      </div>
      </div>
      <div class="col-sm-3 col-xs-8">
      <span class="date1"><?php echo date('d M, Y');?></span>
      <span class="time1">Last Login : <?php
 echo $this->session->userdata('last_login');
?> </span>
      <span class="time1">Time : <?php echo date('h:i a', strtotime($this->session->userdata('last_login'))); ?></span>
      </div>
      <div class="col-sm-3 col-xs-4">
      <div class="img_right">
      <img src="<?php echo base_url('/assets/test/images/illustrator.png'); ?>" class="img1">
      </div>
      </div>
    </div>
  </div>
  
  <div class="subs-sec">
    <div class="row">
      <div class="col-sm-4 col-xs-12">
      <div class="subs-wrap">
        <img src="<?php echo base_url('/assets/test/images/up_down.png'); ?>">
        <h2 class="clr_blue">Todays Subscription</h2>
        <div class="num-sec clr1">
          <span><?php echo $todays_subsription;?></span>
        </div>
      </div>
      </div>
      <div class="col-sm-4 col-xs-12">
      <div class="subs-wrap">
        <img src="<?php echo base_url('/assets/test/images/up_down.png'); ?>">
        <h2 class="clr_green">Todays Featured</h2>
        <div class="num-sec clr2">
          <span><?php echo $today_feature;?></span>
        </div>
      </div>
      </div>
      <div class="col-sm-4 col-xs-12">
      <div class="subs-wrap">
        <img src="<?php echo base_url('/assets/test/images/wait.png'); ?>">
        <h2 class="clr_red">Todays Pending Approvals</h2>
        <div class="num-sec clr3">
          <span><?php echo $pending_approval;?></span>
        </div>
      </div>
      </div>
    </div>
  </div>
  
  <div class="users-sec">
    <div class="row">
      <div class="col-sm-4 col-xs-12">
        <a href="#"><div class="user-bg">
          <img src="<?php echo base_url('/assets/test/images/user_icon.png'); ?>" class="img2">
          <h2 class="head3">All Users</h2>
          <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>
          <span class="to-user">Total : <?php echo $user;?> Users</span>
          <div class="rev-sec">
            <div class="rev1 clr1">
              <span><?php echo count($subsribed_user_count);?></span>
              <span>Users are Subscribed</span>
            </div>
            <div class="rev1 clr2">
              <span><?php echo $feature;?></span>
              <span>Products are Featured</span>
            </div>
            <div class="rev1 clr3">
              <span><?php echo count($product_booking_count);?></span>
              <span>Products are Booked</span>
            </div>
          </div>
        </div></a>
      </div>
      <div class="col-sm-4 col-xs-12">
        <a href="#"><div class="user-bg">
          <img src=" <?php echo base_url('/assets/test/images/revenue_icon.png'); ?>" class="img2">
          <h2 class="head3">Revenue</h2>
          <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>
          <?php 
            $usdamountt = 0;
            $euroamountt = 0;
            if(!empty($total_revenue)) { 
                foreach ($total_revenue as $total) {
                  $usdamountt = $total->total;
                  /*if($total->currency_type == 'usd' && $total->currency_type != 'euro'){
                     $usdamountt = $total->total;
                  }
                  if($total->currency_type == 'euro' && $total->currency_type != 'usd'){
                     $euroamountt = $total->total;
                  }
                */
                  
                }
            }?>


          <span class="to-user">Total Income in $: <?php echo $usdamountt;?>/-</span>
          <!-- <span class="to-user">Total Income in £: <?php echo $euroamountt;?>/-</span> -->
          <div class="rev-sec">
            <div class="rev1 clr1">
              <span>
            <?php 
            $usdamount = 0;
            $euroamount = 0;
            if(!empty($week_revenue)) { 
                foreach ($week_revenue as $week) {
                  echo $usdamount = '$'.$week->total;
                  /*if($week->currency_type == 'usd' && $week->currency_type != 'euro'){
                    echo $usdamount = '$'.$week->total;
                  }
                  if($week->currency_type == 'euro' && $week->currency_type != 'usd'){
                    echo $euroamount = '£'.$week->total;
                  }*/
                
                  
                }
            }else {  echo "0"; } ?>
          </span>
              <span>Weekly</span>
            </div>

            <div class="rev1 clr2">
              <span>
            <?php 
            $usdamount = 0;
            $euroamount = 0;
            if(!empty($month_revenue)) { 
                foreach ($month_revenue as $month) {
                  echo $usdamount = '$'.$month->total;
                  /*if($month->currency_type == 'usd' && $month->currency_type != 'euro'){
                     echo $usdamount = '$'.$month->total;
                  }
                  if($month->currency_type == 'euro' && $month->currency_type != 'usd'){
                    echo $euroamount = '£'.$month->total;
                  }
*/                  
                }
            } else {  echo "0"; } ?>
          </span>
              <span>Monthly</span>
            </div>


            <div class="rev1 clr3">
              <span>
            <?php 
            $usdamount = 0;
            $euroamount = 0;
            if(!empty($year_revenue)) { 
                foreach ($year_revenue as $year) {
                  echo $usdamount = '$'.$year->total;
                 /* if($year->currency_type == 'usd' && $year->currency_type != 'euro'){
                     echo $usdamount = '$'.$year->total;
                  }
                  if($year->currency_type == 'euro' && $year->currency_type != 'usd'){
                     echo $euroamount = '£'.$year->total;
                  }*/
                  
                }
            }else {  echo "0"; } ?>
          </span>
              <span>Yearly</span>
            </div>





            
          </div>
        </div></a>
      </div>
      <div class="col-sm-4 col-xs-12">
        <a href="#"><div class="user-bg">
          <img src="<?php echo base_url('/assets/test/images/order_icon.png'); ?>" class="img2">
          <h2 class="head3">Bookings</h2>
          <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>
          <span class="to-user">Total Bookings: <?php echo $total_product;?> in Total</span>
          <span class="to-user">Pending Bookings: <?php echo $total_pending_product;?> pending</span>
          <span class="to-user">Confirmed Bookings: <?php echo $total_confirm_product;?> confirmed</span>
        </div></a>
      </div>
    </div>
  </div>
  
  <div class="graph-sec">
    <div class="row">
      <div class="col-md-6">
        <img src="<?php echo base_url('/assets/test/images/subs_graph.png'); ?>" class="img4">
      </div>
      <div class="col-md-6">
        <img src="<?php echo base_url('/assets/test/images/feature_graph.png'); ?>" class="img4">
      </div>
    </div>
  </div>
  
  <div class="product-sec1">
  <h1 class="head4">Recent Products</h1>
  <a href="<?php echo base_url('index.php/Admin/product_list'); ?>" class="btn1"><span>View All</span><i class="fa fa-angle-right" aria-hidden="true"></i></a>
  <div class="pro-table">
   <div id="no-more-tables">
      <table class="table table1" width="1060px">
      <thead>
        <tr>
          <th>S. No</th>
          <th>Product Name</th>
          <th>User Name</th>
          <th>Email</th>
        </tr>
      </thead>
      <tbody>
            <?php $i=0; foreach ($products as $products) { $i++;
              ?>
              <tr>
                 <td><?php echo $i; ?></td>
                 <td><?php echo $products->name; ?></td>
                 <td><?php echo $products->userName; ?></td>
                 <td><?php //echo $products->email; ?>********</td>
              </tr>
            <?php } ?>
      </tbody>
    </table>
   </div>
  </div>
  </div>
  

</div>
</div>
<div class="col-md-4 col-xs-12">
<div class="dash2">
  <div class="subs-user">
    <div class="head-sec"><h1 class="head5">Subscription Details</h1>
    <a href="<?php echo base_url('index.php/Admin/Subscription'); ?>" class="btn1"><span>View All</span><i class="fa fa-angle-right" aria-hidden="true"></i></a></div>
    <span class="text2">Subscribed Users</span>

     <?php if(!empty($subsribed_user)){
          foreach ($subsribed_user as $usr) {
            if(!empty($usr['user_name'])){
              $uname = $usr['user_name'];
            }else{
              $uname = $usr['country_code'].' '.$usr['mobile'];
            }
            ?>
             <ul class="list-unstyled text-bg">
              <li><img src="<?php echo base_url('/assets/test/images/user1.png'); ?>"></li>
              <li><?php //echo $uname;?>********<span>Subscribed Date: <?php echo $usr['start_date']; ?>  |  Subscription Expire Date: <?php echo $usr['start_date']; ?> </span></li>
            </ul>
            <?php
          }
        }else{
          echo "No User Available";
        } 
    ?>

    <span class="text2">Subscription Expired</span>
    

     <?php if(!empty($subsribed_user_expired)){
          foreach ($subsribed_user_expired as $susr) {
            if(!empty($susr['user_name'])){
              $uname = $susr['user_name'];
            }else{
              $uname = $susr['country_code'].' '.$susr['mobile'];
            }
            ?>
               <ul class="list-unstyled text-bg">
                <li><img src="<?php echo base_url('/assets/test/images/user1.png'); ?>"></li>
                <li><?php //echo $uname; ?>********<span>Send a message to user to subscribe</span></li>
              </ul>
            <?php
          }
        }else{
          echo "No User Available";
        } 
    ?>



  
   
  </div>
  
  <div class="subs-user">
    <div class="head-sec"><h1 class="head5">Featured Details</h1>
    <a href="<?php echo base_url('index.php/Admin/feature_subscription'); ?>" class="btn1"><span>View All</span><i class="fa fa-angle-right" aria-hidden="true"></i></a></div>
    <span class="text2">Featured Product</span>



<?php if(!empty($product_booking)){
          foreach ($product_booking as $fbook) {
           
            ?>
            <ul class="list-unstyled text-bg">
              <li><img src="<?php echo base_url('/assets/test/images/user1.png'); ?>"></li>
              <li><?php echo $fbook['product_name']?><span>Featured Date: <?php echo $fbook['start_date']?>  |   Expire Date: <?php echo $fbook['expiry_date']?> </span></li>
            </ul>
            <?php
          }
        }else{
          echo "No Feature Product Available";
        } 
    ?>



    <span class="text2">Featured Expired</span>


    

    <?php if(!empty($product_booking_expiry)){
          foreach ($product_booking_expiry as $febook) {
           
            ?>
            
    <ul class="list-unstyled text-bg">
      <li><img src="<?php echo base_url('/assets/test/images/user1.png'); ?>"></li>
      <li><?php echo $febook['product_name'];?><span>Send a message to user to subscribe</span></li>
    </ul>
            <?php
          }
        }else{
          echo "No Feature Product Available";
        } 
    ?>


   
  </div>
  
  <div class="subs-user">
    <div class="head-sec"><h1 class="head5">Complaints</h1>
    <a href="<?php echo base_url('index.php/Admin/complaints'); ?>" class="btn1"><span>View All</span><i class="fa fa-angle-right" aria-hidden="true"></i></a></div>
    <?php if(!empty($complaints)){
      $i = 1;
        foreach ($complaints as $com) {
          ?>
          <ul class="list-unstyled text-bg ha <?php if($i == 1) { echo "marg30"; } ?>">
            <li><img src="<?php echo base_url('/assets/test/images/user1.png'); ?>"></li>
            <li><?php echo $com['complaint'];?></li>
          </ul>
          <?php
          $i++;
        }
    }?>
  
  </div>
</div>
</div>
</div>


<div class="clearfix"></div>


  <!--scripts loaded here-->

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="<?php echo base_url('/assets/test/css/bootstrap.min.js'); ?>s"></script>
    <script src="<?php echo base_url('/assets/test/css/bootstrap.js'); ?>s"></script>
    

</body>

</html>
