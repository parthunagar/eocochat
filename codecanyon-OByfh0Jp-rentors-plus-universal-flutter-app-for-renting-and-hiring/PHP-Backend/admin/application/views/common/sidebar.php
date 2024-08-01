
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <ul class="nav side-menu">
                  <li><a href="<?php echo base_url('index.php/Admin/home'); ?>"><i class="fa fa-home"></i> Dashboard </a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/users'); ?>"><i class="fa fa-user"></i> Users </a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/category_list'); ?>"><i class="fa fa-list"></i> Category </a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/subcategory_list'); ?>"><i class="fa fa-list"></i> Sub category </a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/product_list'); ?>"><i class="fa fa-codepen"></i> Products </a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/product_booking_list'); ?>"><i class="fa fa-codepen"></i>Bookings</a></li>
                  <li><a href="<?php echo base_url('index.php/Admin/city_list'); ?>"><i class="fa fa-list"></i> City </a></li>
                  <!-- <li><a href="<?php //echo base_url('index.php/Admin/wish_list'); ?>"><i class="fa fa-list"></i> Wish List </a></li>
                  <li><a href="<?php //echo base_url('index.php/Admin/post_request'); ?>"><i class="fa fa-gift"></i> Post Request </a></li> -->
                  <li><a href="<?php echo base_url('index.php/Admin/notifaction'); ?>"><i class="fa fa-bell"></i> Notifications </a></li>

                  <li><a><i class="fa fa-money"></i> Revenue Plans <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?php echo base_url('index.php/Admin/feature_subscription'); ?>">Featured Plan</a></li>
                      <li><a href="<?php echo base_url('index.php/Admin/Subscription'); ?>">Subscription Plan</a></li>
                      <li><a href="<?php echo base_url('index.php/Admin/setting'); ?>">Settings</a></li>
                    </ul>
                  </li>


                  <li><a><i class="fa fa-money"></i> Approve Payment/Subscription <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?php echo base_url('index.php/Admin/approve_feature_subscription'); ?>">Approve Featured Product</a></li>
                      <li><a href="<?php echo base_url('index.php/Admin/approve_user_Subscription'); ?>">Approve User Subscription</a></li>
                    </ul>
                  </li>

                  <li><a href="<?php echo base_url('index.php/Admin/pay_subscription_log'); ?>"><i class="fa fa-money"></i> Pay Subscription Log</a></li>


                  <li><a href="<?php echo base_url('index.php/Admin/complaints'); ?>"><i class="fa fa-money"></i>Complaints</a></li>
                   <li><a href="<?php echo base_url('index.php/Admin/home_slider'); ?>"><i class="fa fa-image"></i> Home Slider </a></li>
                   <li><a href="<?php echo base_url('index.php/Admin/change_password'); ?>"><i class="fa fa-key"></i> Change Password </a></li>

                   <!-- <li><a href="<?php echo base_url('index.php/Admin/setting'); ?>"><i class="fa fa-gear"></i>Setting </a></li> -->

                  <li><a href="<?php echo base_url('index.php/Admin/logout'); ?>"><i class="fa fa-sign-out"></i> Logout </a></li>
                  
                </ul>
              </div>
              
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
           <!--  <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div> -->
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="<?php echo base_url('/assets/images/faces/face16.jpg'); ?>" alt="">Admin
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                  
                    <li><a href="<?php echo base_url('index.php/Admin/notifaction'); ?>"><i class="fa fa-sign-out pull-right"></i> Notifications</a></li>
                    <li><a href="<?php echo base_url('index.php/Admin/setting'); ?>"><i class="fa fa-sign-out pull-right"></i> Setting</a></li>
                    <li><a href="<?php echo base_url('index.php/Admin/change_password'); ?>"><i class="fa fa-out pull-right"></i> Change Password</a></li>
                    <li><a href="<?php echo base_url('index.php/Admin/logout'); ?>"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        
        <!-- footer content