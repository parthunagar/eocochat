


<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Change Password</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                      <?php $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                      $url = 'index.php/Admin/change_login_password';
                     echo form_open_multipart($url, $attributes); ?>

                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Current Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="password" id="current_pass" name="current_pass" maxlength="30" required="" placeholder="Enter Current Password" class="form-control col-md-7 col-xs-12 input1" value="" onblur="chackOldPass()" onkeyup="changeOldPass()">

                          <span class="red-alert" id="err_current" style="display: none;">Incorrect Password</span>

                          <input type="hidden" name="old_password" id="old_password" value="<?php echo $old_password?>">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">New Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="password" id="new_pass" name="new_pass" maxlength="30" required="" placeholder="Enter New Password" class="form-control col-md-7 col-xs-12 input1" value="" onblur="chackNewPass()" onkeyup="changeNewPass()">
                          <span class="red-alert" id="err_new" style="display: none;">New password does't match the confirm password</span>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Confirm Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="password" id="confirm_pass" name="confirm_pass" maxlength="30" required="" placeholder="Enter Confirm Password" class="form-control col-md-7 col-xs-12 input1" value="" onblur="chackConfirmPass()" onkeyup="changeConfirmPass()">
                           <span class="red-alert" id="err_confirm" style="display: none;">Confirm password does't match the new password</span>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <div class="">
                          <a class="btn btn4" href="<?php echo base_url('index.php/Admin/change_password'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3" id="change_btn"><?php echo "Change"; ?></button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>


            

            <div class="clearfix"></div>

            
          </div>
       </div>
       <script>
         function chackOldPass(){
          var current_pass = document.getElementById("current_pass").value; 
          var old_password = document.getElementById("old_password").value;
          if(current_pass == ''){

          } else{
            if(current_pass != old_password){
              document.getElementById('err_current').style.display = 'block';
              document.getElementById("change_btn").disabled = true;


            }else{
              document.getElementById('err_current').style.display = 'none';
              document.getElementById("change_btn").disabled = false;
            }
          }         
         }


         function changeOldPass(){
          var current_pass = document.getElementById("current_pass").value; 
          var old_password = document.getElementById("old_password").value;
          if(current_pass == ''){

          } else{
            if(current_pass != old_password){
              document.getElementById("change_btn").disabled = true;


            }else{
              document.getElementById("change_btn").disabled = false;
            }
          }         
         }



         function chackNewPass(){
            var new_pass = document.getElementById("new_pass").value; 
            var confirm_pass = document.getElementById("confirm_pass").value;
            if(new_pass != '' && confirm_pass != ''){
              if(new_pass != confirm_pass){
                  
                  document.getElementById('err_new').style.display = 'block';
                  document.getElementById('err_confirm').style.display = 'none';
                  document.getElementById("change_btn").disabled = true;
              }
              else{
                  document.getElementById('err_new').style.display = 'none';
                  document.getElementById('err_confirm').style.display = 'none';
                  document.getElementById("change_btn").disabled = false;
            }
            }
         }


         function changeNewPass(){
            var new_pass = document.getElementById("new_pass").value; 
            var confirm_pass = document.getElementById("confirm_pass").value;
            if(new_pass != '' && confirm_pass != ''){
              if(new_pass != confirm_pass){
                  document.getElementById("change_btn").disabled = true;
              }
              else{
                  document.getElementById("change_btn").disabled = false;
              }
            }
         }


          function chackConfirmPass(){
            var new_pass = document.getElementById("new_pass").value; 
            var confirm_pass = document.getElementById("confirm_pass").value;
            if(new_pass != '' && confirm_pass != ''){
              if(new_pass != confirm_pass){
                  
                  document.getElementById('err_confirm').style.display = 'block';
                  document.getElementById('err_new').style.display = 'none';
                  document.getElementById("change_btn").disabled = true;
              }else{
                document.getElementById('err_confirm').style.display = 'none';
                  document.getElementById('err_new').style.display = 'none';
                  document.getElementById("change_btn").disabled = false;
            }
            }
         }

          function changeConfirmPass(){
            var new_pass = document.getElementById("new_pass").value; 
            var confirm_pass = document.getElementById("confirm_pass").value;
            if(new_pass != '' && confirm_pass != ''){
              if(new_pass != confirm_pass){
                  document.getElementById("change_btn").disabled = true;
              }
              else{
                  document.getElementById("change_btn").disabled = false;
            }
            }
         }
       </script>
<style>
  .red-alert{
    text-align: left!important;
    font-size: 11px;
    color: red;
    font-weight: 580;
    font-family: 'Open Sans', sans-serif;
    
  }
</style>