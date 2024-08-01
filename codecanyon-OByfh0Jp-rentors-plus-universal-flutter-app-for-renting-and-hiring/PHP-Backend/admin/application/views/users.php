RentAndHire/application/controllers/Product.php<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
    <div class="title_left">
    <h3>All Users</h3>
    </div>
  </div>


  <div class="clearfix"></div>
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title brdr1">
          <small class="sub-head">Users</small>
          <div class="clearfix"></div>
        </div>


<div class="btn-group dropdown pull-right">
 
<label style="
    margin-right: 10px;
    margin-top: 10px;
">Status</label>

  <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
   <div class="dropdown-menu drp-mn-bg">
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/users');?>" status="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>  

  <div class="drp-btn-bg"><a style="color:#fff;background-color: #337ab7;border-color: #2e6da4 !important" class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/users?status='.base64_encode('0')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Pending</a></div>

  <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/users?status='.base64_encode('1')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Verified</a></div>

  <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/users?status='.base64_encode('2')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Rejected</a></div>

  </div>
</div>



        
        
        
        <div class="x_content">
          <table id="datatable" class="table table2">
            <thead>
              <tr>
                <th>S. No</th>
                <th>Name</th>
                <th>Email Id</th>
                <th>Mobile No.</th>
                <th>Profile Status</th>
               
                <th>Verification Status</th>
                <th style="width: 260px;">Action</th>
              </tr>
            </thead>
            <tbody>
              <?php
              $i=0;
             foreach ($user as $user) {

             

                $i++;
                ?>
                <tr>
                  <td class="py-1">
                  <?php echo $i; ?>
                  </td>
                  <td>
                  <?php echo $user->name; ?>
                  </td>
                  <td>
                  <?php echo $user->email; ?>
                  </td>
                  <td>
                  <?php 
                  if(!empty($user->mobile)) { 
                    echo $user->country_code.' '.$user->mobile; 
                  } 
                  ?>
                  </td>



                  <td>

                  <?php if($user->name != '' && $user->mobile != '' && $user->email !='' && $user->address !='' && $user->city !='' && $user->state !='' && $user->pincode !='' && $user->national_id_proof != ''){ 
                    ?> <lable style='color: #39b54a;font-weight:700'>Complete</lable> <?php
                    $className = '';
                  }else {
                    ?><lable style='color: #E54E3C;font-weight:700'>Incomplete</lable><?php
                    $className = 'disabled';
                  } ?>

</td>





                 
 <td>

                  <?php if($user->is_verified==1){ 
                    ?><a href="javascript:void(0);" class="btn btn-round btn-success btn-sm btn-action"  aria-haspopup="true" aria-expanded="false">
                       Verified
                      </a><?php
                  }elseif($user->is_verified==2) {
                    ?><a href="javascript:void(0);" class="btn btn-round btn-danger btn-sm btn-action"  aria-haspopup="true" aria-expanded="false">
                       Rejected
                      </a><?php
                  } elseif($user->is_verified==0) {
                    ?><a href="javascript:void(0);" class="btn btn-round btn-gray btn-sm btn-action"  aria-haspopup="true" aria-expanded="false">
                       Pending
                      </a><?php
                  } ?>

</td>

                  <td>


                  


                  <?php if($user->is_verified==0)
                  {
                    $url = base_url('/index.php/Admin/change_status_user').'?id='.$user->id.'&status=0&request=2';
                  ?>



                  <a title="Verify" class="btn pro-btn btn3 changeStatus <?php echo $className;?>" status = "6" 
                  href="<?php echo base_url('/index.php/Admin/change_verified_status_user').'?id='.$user->id.'&status=1&request=2'; ?>"><i class="fa fa-check" aria-hidden="true"></i></a>
          
          <a title="Reject" href="<?php echo base_url('/index.php/Admin/change_verified_status_user').'?id='.$user->id.'&status=2&request=2'; ?>" class="btn pro-btn btn4 rejctedStatus <?php echo $className;?>" data-target="#rejection_modal" data-toggle="modal" data-backdrop="static" data-keyboard="false" status = "7" user_id = "<?php echo $user->id;?>" href="<?php echo $url;?>"><i class="fa fa-times" aria-hidden="true"></i></a>
                   
                  <?php
                  }
                  elseif($user->is_verified==1) {
                     $url = base_url('/index.php/Admin/change_verified_status_user').'?id='.$user->id.'&status=2&request=2';
                  ?>
                   <a title="Verify" class="btn pro-btn disabled btn3 <?php echo $className;?>"><i class="fa fa-check" aria-hidden="true"></i></a>

                   <a title="Reject" class="btn pro-btn btn4 rejctedStatus <?php echo $className;?>" data-target="#rejection_modal" data-toggle="modal" data-backdrop="static" data-keyboard="false" status = "7" user_id = "<?php echo $user->id;?>" href="<?php echo $url;?>"><i class="fa fa-times" aria-hidden="true"></i></a>
                  <?php
                  } elseif($user->is_verified == 2){ 
                    $url = base_url('/index.php/Admin/change_verified_status_user').'?id='.$user->id.'&status=1&request=2';
                    ?>
                 

                   <a title="Verify" class="btn pro-btn btn3 changeStatus <?php echo $className;?>" status = "6" 
                  href="<?php echo $url; ?>"><i class="fa fa-check" aria-hidden="true"></i></a>


                   <a title="Reject" class="btn pro-btn btn4 disabled <?php echo $className;?>"><i class="fa fa-times" aria-hidden="true"></i></a>

                  <?php } ?>

                  <a title="View" class="btn pro-btn btn6" href="<?php echo base_url('/index.php/Admin/userDetails').'?id='.$user->id.'&Class='.$className;?>"><i class="fa fa-eye" aria-hidden="true"></i></a>

                  

                  </td>
                 
                </tr>
                <?php
              }
              ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      </div>


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
                          <input type = "hidden" name="userId" value="" id="user_id_rejection"> 
 
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
</div>

<!-- /page content -->
