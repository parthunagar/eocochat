


<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"  onclick="myFunction()">
                <button type="button" class="btn btn-top btn6"><span class="fa fa-plus "></span> Add Plan</button>
               
              </div>
            </div>
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12" id="showHideCat" <?php if(!empty($id)){ ?>style="display: block;"<?php }else { ?>style="display: none;"<?php } ?> >
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Add Plan</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                      <?php $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                      if(!empty($id)){
                          $url = 'index.php/Admin/add_subscription?id='.$id;
                      }else{
                          $url = 'index.php/Admin/add_subscription';
                      }
                     echo form_open_multipart($url, $attributes); ?>

                      <div class="form-group">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">Plan Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="plan_name" name="plan_name" maxlength="30" required="" placeholder="Enter Plan Name" class="form-control col-md-7 col-xs-12 input1" value="<?php if(!empty($subscribe_data)){ echo $subscribe_data[0]->title; } ?>">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">Period <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select2_single form-control input1" name="period" required>
                            <option>Select
                             </option>
                            <?php
                             foreach ($plan_periods as $period) { ?>
                             <option value="<?php echo $period->id; ?>" <?php if($period->id == @$subscribe_data[0]->period) { echo "selected";} ?>><?php echo $period->period_title; ?>
                             </option>
                             <?php } ?>
                          </select>
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">No. of Products <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="number" id="no_of_products" name="no_of_products" maxlength="30" required="" placeholder="Enter No. of Products" class="form-control col-md-7 col-xs-12 input1" value="<?php if(!empty($subscribe_data)){ echo $subscribe_data[0]->no_of_products; } ?>">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">Price <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="price" name="price" maxlength="30" required="" placeholder="Enter Price" class="form-control col-md-7 col-xs-12 input1" value="<?php if(!empty($subscribe_data)){ echo $subscribe_data[0]->price; } ?>">
                        </div>
                      </div>

                      
                      <div class="form-group">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">Currency Type <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select2_single form-control input1" name="currency_type" required>
                            <option>Select</option>
                            <option value="usd" <?php if('usd' == @$subscribe_data[0]->currency_type) { echo "selected";} ?>>$ USD</option>
                            <option value="INR" <?php if('euro' == @$subscribe_data[0]->currency_type) { echo "selected";} ?>>€ EURO</option>
                          </select>
                        </div>
                      </div>
                      <input type='hidden' name='type' value='<?php echo $type ?>'>

					 <!--
                     
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Subscription Type <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select2_single form-control" name="subscription_type" required>
                            <option>Select</option>
                            <option value="feature" <?php if('feature' == @$subscribe_data[0]->type) { echo "selected";} ?>>Feature</option>
                            <option value="normal" <?php if('normal' == @$subscribe_data[0]->type) { echo "selected";} ?>>Normal</option>
                          </select>
                        </div>
                      </div>

					  
                     
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Description <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">

                          <textarea id="description" name="description" placeholder="Enter Description" class="form-control col-md-7 col-xs-12"><?php if(!empty($subscribe_data)){ echo $subscribe_data[0]->description; } ?></textarea>
                          <!-- <input type="text" id="description" name="description" maxlength="30" required="" placeholder="Enter Name" class="form-control col-md-7 col-xs-12" value="<?php if(!empty($subscribe_data)){ echo $subscribe_data[0]->description; } ?>"> 
                        </div>
                      </div>

                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          
                          <label class="control-label" for="first-name"><input type="radio" name="status" value="1" checked="checked">Active
                        </label>
                          
                           <label class="control-label" for="first-name"><input type="radio" name="status" value="0">Inactive
                        </div>
                      </div>
                      
						-->
                     
                      
                      <div class="form-group">
                        <div class="">
                          <a class="btn btn4" href="<?php echo base_url('index.php/Admin/Subscription'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3"><?php if(!empty($id)){ echo "Update"; } else { echo "Submit"; }?></button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>

        <div class="" role="main">
          <div class="">
            <div class="row top_tiles">
              <?php if(!empty($subscription)) { 
                foreach($subscription as $sub) { ?>

              <div class="animated flipInY col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="subs-plan-wrap">
                	<h2 class="sub-head3"><?php echo $sub->title;?></h2>
                	<span class="sub-text">For <?php echo $sub->period_title;?></span>
                    <span class="sub-text">No. of Products - <?php echo $sub->no_of_products;?></span>
                  <?php if($sub->currency_type == 'usd') {
                    $ctype = '$';
                  }else{
                    $ctype = '€';
                  }?>
                	<span class="sub-amt"><?php echo $ctype.$sub->price;?></span>
                  <?php if($type == 'feature') { 
                    $surl = base_url('index.php/Admin/feature_subscription?id='.$sub->id);
                  }else{
                    $surl = base_url('index.php/Admin/subscription?id='.$sub->id);
                  }?>
                	<a href="<?php echo $surl; ?>" class="ed-icon"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                </div>
              </div>
            <?php } 
          }?>
             


            </div>

          </div>
        </div>
      













            <div class="page-title">
              <div class="title_left">
                <h3>Featured User List
</h3>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Featured User List</small>
                    <div class="clearfix"></div>
                  </div>
                  
                  <!-- <a href="" class="filtr-bg"><i class="fa fa-filter" aria-hidden="true"></i></a> -->
                  <button disabled="disabled" class="btn btn-top btn3" id="send_msg_to_all"  data-target="#msgmodal" data-toggle="modal" data-backdrop="static" data-keyboard="false"><h5 style="font-size: 16px;">Send Message</h5></button>
                  
                  
                  <div class="x_content">
                    <table id="datatable" class="table table2">
                      <thead>
                        <tr>
                          <th> <input id="select_all"  type="checkbox" value="" name="check" style="opacity:1;position:inherit;"></th>
                          <th>S. No</th>
                          <th>Name</th>
                          <th>Email Id</th>
                          <th>Phone No.</th>
                          <th>Subsciption Plan</th>
                          <th>Status</th>
                          <th>Start Date</th>
                          <th>End Date</th>
                          <th>Total Payment</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php
                        $i=0;
                        if(!empty($user_subscription)){
                          foreach ($user_subscription as $subscrip) {
                            $i++;
                            ?>
                            <tr>
                              <td><input class="notification_check mychechk"  type="checkbox" value="<?= $subscrip->id ?>" name="check" style="opacity:1;position:inherit;"></td>
                              <td class="py-1">
                              <?php echo $i; ?>
                              </td>
                              <td>
                              <?php echo $subscrip->name; ?>
                              </td>
                              <td>
                              <?php //echo $subscrip->email; ?>********
                              </td>
                             <td>
                  <?php 
                  if(!empty($subscrip->mobile)) { 
                    //echo $subscrip->country_code.' '.$subscrip->mobile; 
                  } 
                  ?>********
                  </td>

                              <td>
                              <?php echo ucfirst($subscrip->title); ?>
                              </td>
                               
                               <td>
                              <a href="#" class="btn3">Active</a>
                              </td>
                               
                               <td>
                              <?php echo $subscrip->start_date; ?>
                              </td>
                             
                              <td>
                              <?php echo $subscrip->expiry_date; ?>
                              </td>
                             
                              <td>
                              <span>Rs.5,000/-</span>
                              </td>

                             </tr>
                            <?php
                          }
                        }
                        ?>
                        </tbody>
                      </table>
                   </div>
                </div>
              </div>
            </div>
          </div>
       </div>
<div role="dialog" class="modal fade" id="msgmodal" style="display: none;">
          <div class="modal-dialog">

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Send Notification</h2><button data-dismiss="modal" class="close" type="button">×</button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                    <form method="post" class="form-horizontal form-label-left" action="<?= base_url('index.php/Admin/send_msg_to_users'); ?>">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Title <span class="required">*</span>
                        </label>

                        <div class="col-md-8 col-sm-6 col-xs-12">
                          <input type="text" id="title" name="title" maxlength="35" required="" placeholder="Enter Title" class="form-control col-md-7 col-xs-12">
                           <span class="result">0 </span><span>/15</span>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Notification Message <span class="required">*</span>
                        </label>

                        <div class="col-md-8 col-sm-6 col-xs-12">
                          <textarea id="textfield1" required class="form-control" name="message" rows="4" maxlength="150"></textarea>
 
              <input type="hidden" name="userId" id= "userId" value="">
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

           <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert-dev.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css">



<script>

$(document).ready(function(){
  $("#datatable").on("click", ".mychechk", function(){
     $('#uid').val('');
    var sThisVal='';
    $('.mychechk').each(function () {
      if(this.checked){
        sThisVal = sThisVal+$(this).val()+',';
        $('#uid').val(sThisVal);
      }
    });
    if( sThisVal!=''){
      $('#send_msg').prop("disabled", false);
      $('#send_msg_to_all').prop("disabled", false);
    }else{
      $('#send_msg').prop("disabled", true);
      $('#send_msg_to_all').prop("disabled", true);
    }
   // your code goes here
});



  $('.mychechkk').on('change', function() {
    $('#uid').val('');
    var sThisVal='';
    $('.mychechk').each(function () {
      if(this.checked){
        sThisVal = sThisVal+$(this).val()+',';
        $('#uid').val(sThisVal);
      }
    });
    if( sThisVal!=''){
      $('#send_msg').prop("disabled", false);
      $('#send_msg_to_all').prop("disabled", false);
    }else{
      $('#send_msg').prop("disabled", true);
      $('#send_msg_to_all').prop("disabled", true);
    }

  });
});
</script>

<script>
$(document).ready(function(){
$('input#textfield').on('keyup',function(){
var charCount = $(this).val().replace(/^(\s*)/g, '').length;
$(".result").text(charCount + " ");
});
});
</script>

<script>
$(document).ready(function(){
$('textarea#textfield1').on('keyup',function(){
var charCount = $(this).val().replace(/^(\s*)/g, '').length;
$(".result1").text(charCount + " ");
});
});
</script>

<!-- notification -->

<script type="text/javascript">
var base_url = '<?php echo base_url(); ?>';

jQuery(document).ready(function() {
jQuery('#allusers').dataTable({

});

jQuery('#notification_table1').dataTable({ 
"lengthMenu": [ [10, 50, 100, -1], [10, 50, 100, "All"] ],
});

var data = 
{
mobile:[],msg:'',title:''
}

var myArray = [];
var id = "";
var oTable = $("#datatable").dataTable();

var allPages = oTable.fnGetNodes();




jQuery(document).on('click','#select_all',function(){


  if(jQuery(this).prop('checked') == true)
  {
    //$('input[type="checkbox"]', allPages).prop('checked', true);
    //$('#send_msg').prop("disabled", false);
    jQuery('.notification_check',allPages).each(function(index, el) {
      jQuery(this).prop('checked',true);
      mobile = jQuery(this).val();
      //var mobile = jQuery(this).parent().prev().text(); 
      data.mobile.push(mobile); 
     
    }); 
     $('#send_msg_to_all').prop("disabled", false);
  }
  else{
    jQuery('.notification_check').each(function(index, el) {
      jQuery(this).prop('checked',false);
      data.mobile=[];
    }); 
    $('#send_msg_to_all').prop("disabled", true);
  }
});

Array.prototype.remove = function() {
var what, a = arguments, L = a.length, ax;
while (L && this.length) {
what = a[--L];
while ((ax = this.indexOf(what)) !== -1) {
this.splice(ax, 1);
}
}
return this;
};

jQuery(document).on('click','.notification_check',function(){

if(jQuery(this).prop('checked') == true){

var mobile = jQuery(this).parent().prev().text(); 
data.mobile.push(mobile); 
}
else
{mobile
var mobile = jQuery(this).parent().prev().text();
data.mobile.remove(mobile); 
}
});
var userIds = [];
jQuery(document).on('click','#send_msg',function(){

  console.log(data);
  if(data.mobile.length ==0){
  swal("Warning", "Please select user to send notification", "error");
  }
  else
  {
    jQuery('.notification_check').each(function(index, el) {
      if(jQuery(this).prop('checked') == true){
          userIds.push($(this).val());
      }
    }); 
  $('#userId').val(userIds);
  jQuery('#msgmodal').modal('show');
}
});


jQuery(document).on('click','#send_msg_to_all',function(){

  console.log(data);
  if(data.mobile.length ==0){
  swal("Warning", "Please select user to send notification", "error");
  }
  else
  {
    jQuery('.notification_check', allPages).each(function(index, el) {
      if(jQuery(this).prop('checked') == true){
          userIds.push($(this).val());
      }
    }); 
  $('#userId').val(userIds);
  jQuery('#msgmodal').modal('show');
}
});


jQuery(document).on('click','#notify-user',function(){

var msg = jQuery('#msgmodal textarea').val();
data.msg= msg;

var title = jQuery('#msgmodal input').val();
data.title= title;

$.ajax({

url: base_url+'Webservicenew/firebase_notification',
type: 'POST',
dataType: 'json',
data: data,
success:function(data)
{

swal("Success", "Notification send successfully.", "success");
swal({
title: "Success",
text: "Notification send successfully.",
type: "success",
confirmButtonColor: "#DD6B55",
confirmButtonText: "OK",
closeOnConfirm: true, 
},
function(isConfirm){
if (isConfirm) {
window.location.href = base_url + "Admin/notifaction";
} 
});
data.mobile = [];data.title ='';data.msg ='';
}
}) 
});
});
</script>