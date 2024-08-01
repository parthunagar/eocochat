 <!-- page content -->
 
<div class="right_col" role="main">
  <div class="">
    <div class="clearfix"></div>
      <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
      <div class="x_content">
      <div class="" role="tabpanel" data-example-id="togglable-tabs">

        <div class="btn-group dropdown pull-right">
            <a href="<?php echo base_url('index.php/Admin/users'); ?>" class="filtr-bg"  aria-haspopup="true" aria-expanded="false"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
        </div>



      <div class="col-md-12 col-sm-12 col-xs-12">

        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
          <li role="presentation" class="active bck-clr"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">User Details</a>
          </li>
         <!--  <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">Post Request</a>
          </li> -->
          <li role="presentation" class=" bck-clr"><a href="#tab_content4" role="tab" id="profile-tab3" data-toggle="tab" aria-expanded="false">National Id Proof</a>
          </li>

           <li role="presentation" class=" bck-clr"><a href="#tab_content5" role="tab" id="profile-tab4" data-toggle="tab" aria-expanded="false">Address Proof</a>
          </li>

        </ul>
      </div>


        <div id="myTabContent" class="tab-content">


          <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">

            <!-- start recent activity -->
            <ul class="messages">
              <li>
                <?php if($userDetails->profile_pic == ''){ 
                   ?> <img src="<?php echo base_url('/assets/images/faces/no-image.jpg'); ?>" class="avatar" alt="Avatar"><?php
                }else{
                    ?><img src="<?php echo $userDetails->profile_pic; ?>" class="avatar" alt="Avatar"><?php
                }?>
                <div class="message_wrapper">
                <h4 class="heading"><?php echo ucfirst($userDetails->name). '' .ucfirst($userDetails->last_name); ?></h4>


                <table id="" class="table table-striped table-bordered">
                  <thead>
                    <tr>
                      <th>Field</th>
                      <th>Value</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php 
                    if(!empty($userDetails)){
                    ?>
                      <tr><td>Name</td><td><?php echo ucfirst($userDetails->name). '' .ucfirst($userDetails->last_name); ?></td></tr>
                      <tr><td>Email</td><td><?php echo $userDetails->email; ?></td></tr>
                      <tr><td>Mobile No.</td><td><?php echo $userDetails->country_code.' '.$userDetails->mobile; ; ?></td></tr>
                      <tr><td>Address</td><td><?php echo $userDetails->address; ?></td></tr>
                      <tr><td>City</td><td><?php echo $userDetails->city; ?></td></tr>
                      <tr><td>Pincode</td><td><?php echo $userDetails->pincode; ?></td></tr>
                    <?php
                    }?>
                  </tbody> 
                </table>
                <blockquote class="message" style="word-wrap: break-word;"><?php //echo ucfirst($productDetails->details); ?></blockquote>
                <div class="btn-bck">

                  <?php if($userDetails->is_verified == 0){
                    $classNameV = '';
                    $classNameR = '';
                  }
                  if($userDetails->is_verified == 1){
                    $classNameV = 'disabled';
                    $classNameR = '';
                  }
                  if($userDetails->is_verified == 2){
                    $classNameV = '';
                    $classNameR = 'disabled';
                  }
                   ?>
                  <a class="btn btn-round btn-success round-btn changeStatuss btn3 <?php echo $classNameV;?> <?php echo $ClassName;?>" status = "6" 
                  href="<?php echo base_url('/index.php/Admin/change_verified_status_user').'?id='.$userDetails->id.'&status=1&page=details'; ?>">Verify</a>

                  <a  href="<?php echo base_url('/index.php/Admin/change_verified_status_user').'?id='.$userDetails->id.'&status=2&page=details'; ?>" class="btn btn-round btn-danger round-btn btn4 rejctedStatus <?php echo $classNameR;?> <?php echo $ClassName;?>" data-target="#rejection_modal" data-toggle="modal" data-backdrop="static" data-keyboard="false" status = "7" user_id = "<?php echo $user->id;?>" href="<?php echo $url;?>">Reject</a>
                </div>
              </li>
            </ul>
          </div>
          <!----->
          




      <div role="tabpanel" class="tab-pane fade" id="tab_content4" aria-labelledby="profile-tab3">

        <div class="x_content">

          <div class="row">

          <?php
          if(!empty($userDetails)){
          if(!empty($userDetails->national_id_proof)){
              ?>
               <div class="col-md-10">
                 <img style="width: 100%; display: block;height: 1000px;" src="<?php echo $userDetails->national_id_proof;?>" alt="Selfie" />
                </div>
              <?php 
              
          }else{
            ?>No National Id Available<?php
          }
          }
          ?>


          </div>
        </div>
      </div>







      <div role="tabpanel" class="tab-pane fade" id="tab_content5" aria-labelledby="profile-tab3">

        <div class="x_content">

        <div class="row">

        <?php
        if(!empty($userDetails)){
        if(!empty($userDetails->address_proof )){
            ?>
             <div class="col-md-10">
                <img style="width: 100%; display: block;height: 1000px;" src="<?php echo $userDetails->address_proof  ;?>" alt="Insurance" />
              </div>
            <?php 
            
        }else{
          ?>No Address Proof Available<?php
        }
        }
        ?>


        </div>
        </div>
      </div>










      </div>
      </div>
      </div>
      </div>
      </div>
      </div>
    </div>
  </div>
</div>
<!-- /page content -->


 <div role="dialog" class="modal fade" id="rejection_modal" style="display: none;">
          <div class="modal-dialog">

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Send Reason of Rejection</h2><button data-dismiss="modal" class="close" type="button">×</button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                    <form method="post" class="form-horizontal form-label-left" action="<?= base_url('index.php/Admin/change_verified_status_user'); ?>">
                      

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Reason<span class="required">*</span>
                        </label>

                        <div class="col-md-8 col-sm-6 col-xs-12">
                          <textarea id="textfield1" required class="form-control" name="message" rows="4" maxlength="150"></textarea>
                          <input type = "hidden" name="userId" value="<?php echo $userDetails->id;?>" id=""> 
                          <input type = "hidden" name="page" value="details" id="page"> 
 
                          <span class="result1">0 </span><span>/150</span>


                        </div>
                      </div>




                     
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <a class="btn btn-danger" data-dismiss="modal">Cancel</a>
                          <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>



    </div>
  </div>

</div>