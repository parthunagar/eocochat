<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Send Notification</h3>
              </div>

              <div class="title_right">
                <div class="col-md-7 col-sm-7 col-xs-12 form-group  top_search">
                  <div class="send_msg input-group" >
                   <!--  <input disabled="disabled" id="send_msg" class="btn btn-success" type="submit" value="Send Message" data-target="#msgmodal" data-toggle="modal">
 -->
                   <button disabled="disabled" <?php if(!empty($type_action)) { ?> id="send_msg_to_all" <?php } else { ?> id="send_msg" <?php } ?> class="btn btn-success"  data-target="#msgmodal" data-toggle="modal" data-backdrop="static" data-keyboard="false"><h5 style="font-size: 16px;">Send Message</h5></button>
                   
                  </div>
                </div>
              </div> 


               <div class="btn-group dropdown pull-right">
 <label style="
    margin-right: 10px;
    margin-top: 10px;
">Type</label>


  <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
   <div class="dropdown-menu drp-mn-bg">
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/notifaction');?>" status="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>   

  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/notifaction_type?sstatus='.base64_encode('Renter')); ?>" cstatus="3" style="padding: 2px 6px;font-size: 14px;">Renter</a></div>

  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/notifaction_type?sstatus='.base64_encode('Rentee')); ?>" cstatus="5" style="padding: 2px 6px;font-size: 14px;">Rentee</a></div>

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

                    <form method="post" class="form-horizontal form-label-left" action="<?= base_url('index.php/Admin/putnotification'); ?>">
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
            



          <!-- Modal content--> 
<!--           <form method="post" action="<?= base_url('index.php/Admin/putnotification'); ?>"> 











              <div class="modal-content">
              <div class="modal-header">
              <h4><b>Send Notification</b></h4>
              <button data-dismiss="modal" class="close" type="button">×</button>
              </div>
              <div class="modal-body"> 
              <div class="form-group clearfix">
              <input type="hidden" id="uid" name="uid"><br>
              </div>

              <div class="form-group clearfix">
              <label>Title</label>
              <input id="text" class="col-md-12" type="text" name="title" maxlength="15" required /><br>
              <span class="result">0 </span><span>/15</span>
              </div>

              <div class="form-group clearfix">
              <label>Notification Message</label>
              <textarea id="textfield1" name="message" class="col-md-12" rows="4" maxlength="150" required></textarea><br>
              <span class="result1">0 </span><span>/150</span>
              </div>
              </div>

              <div class="modal-footer">
              <input type="submit" class="btn btn-success" id="notify-user">
              <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
              </div>
              </div>
            </form>
 -->        </div>
</div>



            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Users</small>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <!-- <p class="text-muted font-13 m-b-30">
                      DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: <code>$().DataTable();</code>
                    </p> -->
                    <table id="datatable" class="table table2">
                      <thead>
                       <tr>
                          <th>S. No</th>
                          <th>Name</th>
                          <th>Email</th>
                          <th>Last Login</th>
                          <th>Type</th>
                          <th>Send Message
                            <?php if(!empty($type_action)) { ?>

                           <input id="select_all"  type="checkbox" value="" name="check" style="opacity:1;position:inherit;">
                           <?php } ?></th>
                        </tr>
                      </thead>


                      <tbody >
                        <?php $i=0; foreach ($user as $val ){ $i++; ?>
                        <tr>
                        <td class="text-center"><?php echo $i; ?></td>
                        <td class="text-center" style="text-transform:capitalize;"><?php echo $val->name; ?></td>
                        <td class="text-center"> <?php //echo $val->email; ?>********</td>
                        <td class="text-center"> <?php echo $val->last_login; ?></td>
                        <td class="text-center"> <?php echo $val->type; ?></td>
                        <td class="text-center"><input class="notification_check mychechk"  type="checkbox" value="<?= $val->id ?>" name="check" style="opacity:1;position:inherit;"></td> 
                        </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                  </div>
                </div>
              </div>

              

            </div>
          </div>
      
        </div>
        <!-- /page content -->


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