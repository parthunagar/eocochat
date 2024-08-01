


<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left" >
                <button type="button" class="btn btn-top btn6"><span class="fa fa-plus "></span> Setting</button>
              </div>
            </div>
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12">

                 <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->
                      <?php
                      $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                      $url = 'index.php/Admin/add_setting';
                      echo form_open_multipart($url, $attributes); ?>
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Api Setting</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                  
                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Firebase Api Key <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input type="text" id="firebase" name="firebase" required="" placeholder="Enter Firebase Api Key" class="form-control col-md-7 col-xs-12 input1" value="<?php //echo getenv('FIREBASE_KEY');?>******">
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Stripe  Api Key <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          
                           <input type="text" id="stripe" name="stripe" required="" placeholder="Enter Stripe Api Key" class="form-control col-md-7 col-xs-12 input1" value="******<?php //echo getenv('STRIPE_KEY');?>">
                           <input type ="hidden" value = "<?php echo $setting->id?>" name="id">
                        </div>
                      </div>

                      


                     

                    
                  </div>
                </div>

                 <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Email Setting</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->
                     

                  


                     


                      <!-- <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">SMTP Host <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          
                           <input type="text" id="smtp_host" name="smtp_host" required="" placeholder="Enter SMTP Host" class="form-control col-md-7 col-xs-12 input1" value="<?php echo @$setting->smtp_host;?>">
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">SMTP Port <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input type="text" id="smtp_port" name="smtp_port" required="" placeholder="Enter SMTP Port" class="form-control col-md-7 col-xs-12 input1" value="<?php echo @$setting->smtp_port;?>">
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">SMTP User <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input type="text" id="smtp_user" name="smtp_user" required="" placeholder="Enter SMTP User" class="form-control col-md-7 col-xs-12 input1" value="<?php echo @$setting->smtp_user;?>">
                        </div>
                      </div>

                       <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">SMTP Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input type="text" id="smtp_pass" name="smtp_pass" required="" placeholder="Enter SMTP Password" class="form-control col-md-7 col-xs-12 input1" value="<?php echo @$setting->smtp_pass;?>">
                        </div>
                      </div> -->


                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Sendgrid Key<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          
                           <input type="text" id="sendgrid_key" name="sendgrid_key" required="" placeholder="Enter Sendgrid Key" class="form-control col-md-7 col-xs-12 input1" value="SG.xxxx23232323323232<?php //echo getenv('SENDGRID_KEY');?>">
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Sendgrid Email<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input type="text" id="sendgrid_email" name="sendgrid_email" required="" placeholder="Enter Sendgrid Email" class="form-control col-md-7 col-xs-12 input1" value="test@gmail.com<?php //echo getenv('SENDGRID_EMAIL');?>">
                        </div>
                      </div>

                       
                      <div class="form-group">
                        <div class="">
                          <a class="btn btn4" href="<?php echo base_url('index.php/Admin/setting'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3">Update</button>
                        </div>
                      </div>


                     

                    
                  </div>
                </div>

              </div>
            </div>


            </form>

            <div class="clearfix"></div>

            
          </div>
      
        </div>
        <!-- /page content -->
