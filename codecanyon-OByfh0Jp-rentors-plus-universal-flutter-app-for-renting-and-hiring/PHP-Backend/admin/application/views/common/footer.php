<!-- footer content -->

        <footer>
          <div class="pull-left">
            Copyright © 2020<a href = "http://www.applatus.com/" ><?php echo getenv('FOOTER_LEFT');?></a> All rights reserved. 
          </div>


          <div class="pull-right">
           <?php echo getenv('FOOTER_RIGHT');?> <i class="mdi mdi-heart text-danger"></i>
          </div>
         

          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="<?php echo base_url('assets/js_theme/jquery.min.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/bootstrap.min.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/fastclick.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/nprogress.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/icheck.min.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/jquery.dataTables.min.js'); ?>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.3.6/js/bootstrap-colorpicker.js"></script>


    <script src="<?php echo base_url('assets/js_theme/dataTables.bootstrap.min.js'); ?>"></script>

    <script src="<?php echo base_url('assets/js_theme/dataTables.buttons.min.js'); ?>"></script>
    


    <script src="<?php echo base_url('assets/js_theme/buttons.bootstrap.min.js'); ?>"></script> 
   
    <script src="<?php echo base_url('assets/js_theme/buttons.flash.min.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/buttons.html5.min.js'); ?>"></script>
    <!-- Datatables -->

    <script src="<?php echo base_url('assets/js_theme/buttons.print.min.js'); ?>"></script>
    <script src="<?php echo base_url('assets/js_theme/dataTables.fixedHeader.min.js'); ?>"></script>
    

    <script src="<?php echo base_url('assets/js_theme/dataTables.keyTable.min.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/dataTables.responsive.min.js'); ?>"></script>
  

   <script src="<?php echo base_url('assets/js_theme/responsive.bootstrap.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/dataTables.scroller.min.js'); ?>"></script>
 


   <script src="<?php echo base_url('assets/js_theme/jszip.min.js'); ?>"></script>
   

   <script src="<?php //echo base_url('assets/js_theme/pdfmake.min.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/vfs_fonts.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/custom.min.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/Chart.min.js'); ?>"></script>
  


   <script src="<?php echo base_url('assets/js_theme/jquery.flot.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/jquery.flot.time.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/jquery.flot.resize.js'); ?>"></script>



   <script src="<?php echo base_url('assets/js_theme/jquery.flot.orderBars.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/jquery.flot.spline.min.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/curvedLines.js'); ?>"></script>
   <script src="<?php echo base_url('assets/js_theme/date.js'); ?>"></script>





    <!-- Custom Theme Scripts -->
    
<script>
  function myFunction() {
    $("#showHideCat").slideToggle();
    /*if (x.style.display === "none") {
      x.style.display = "block";
    } else {
      x.style.display = "none";
    }*/
  }
</script>
<script type="text/javascript">
$('#cp2').colorpicker();
</script>
<script>
  
$(document).ready(function() {

  $("#datatable").on("click", ".changeStatus", function(e){
    var status = $(this).attr('status');
    
    if(status ==1){
      var action = "Deactivate";
    }
    else if(status == 2){
      var action = "Activate";
    }

    else if(status == 3){
      var action = "confirm";
    }

    else if(status == 4){
      var action = "Pending";
    }

    else if(status == 5){
      var action = "Reject";
    }

    var link = this;
    var success = confirm('Do you really want to '+action+'?');
    if(success == false){
      return false;
    }else{

    }
  });

 $(".productDelete").on("click", function(e) {
  var link = this;
  var success = confirm('Do you really want to delete this product?');
    if(success == false){
      return false;
    }else{

    }
 });



  
  $('table.display').DataTable();
    $('#example').DataTable({
        "paging": true
    });
} );

$(document).ready(function(){
    //var maxField = 10; //Input fields increment limitation
    var addButton = $('.add_button'); //Add button selector
    var wrapper = $('.field_wrapper'); //Input field wrapper


   
    
    //Once add button is clicked
    $(addButton).click(function(){
      if ($(wrapper)[0].childElementCount == 0) {
        $('.add_button').attr('val',5);
      }

      var val = $(this).attr('val');


      var check_val = val-1;
      var check_last_value = $('#check_value_'+check_val).val();


      if(check_last_value == ''){
        alert('Please enter value for Field Lable '+check_val);
      }else{
         var fieldHTML = '<div class="form-group"> <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Lable '+val+'</label><div class="col-md-6 col-sm-6 col-xs-9"><input id="check_value_'+val+'" placeholder="Enter Field Label '+val+'" type="text" name="formfield[]" maxlength="30" class="form-control col-md-7 col-xs-12 input1" value=""></div><a  href="javascript:void(0);" class="remove_button col-md-2 col-sm-2 col-xs-12" title="Add field"><img src="<?php echo base_url().'/assets/images/minus.png'?>" style="height: 35px;" ></a></div>';
   
        $(wrapper).append(fieldHTML); //Add field html
         val++;
        $('.add_button').attr('val',val);
      }

    //  val++;
        //Check maximum number of input fields
        
        
        
    });
    
    //Once remove button is clicked
    $(wrapper).on('click', '.remove_button', function(e){
        e.preventDefault();
        $(this).parent('div').remove(); //Remove field html
    });
});

$('#icon').change(function(){
  var section  = $(this).attr('section');
  startUpload(section);
});

var iconArray = [];
function startUpload(section){
//alert(4);
    var fd = new FormData();
    var files = $('#icon')[0].files[0];
    fd.append('icon',files);

    // AJAX request
    if(section == 'subcat'){
      var url = '<?php echo base_url()?>index.php/Admin/add_icon_sub';
    }else{
      var url = '<?php echo base_url()?>index.php/Admin/add_icon';
    }
    $.ajax({
      url: url,
      type: 'post',
      data: fd,
      contentType: false,
      processData: false,
      dataType:'json',
 
      success: function(response){
        console.log(response);
        console.log(response.success);
        if(response.success == true){
          // Show image preview
          $('.icon-show').show();
          $('#preview_icon').html("<img src='"+response.response+"' width='65' height='65'>");
          iconArray.push(response.imageName);
          $('#icon_value').val(response.imageName);

          //$('#preview').append("<img src='"+response.response+"' width='100' height='100' style='display: inline-block;'>");
        }else{
          alert(response.errorMessage);
        }
        $("#iconArray").val(iconArray);

      }

    });
  };


$('#image').change(function(){
  var section  = $(this).attr('section');
  imageUpload(section);

});

/*$('#imageslider').change(function(){
  var section  = $(this).attr('section');
  imageUpload(section);

});*/

var imageI = $('#imageArrayPush').val();
if(imageI != ''){
  imageI = imageI.split(',');
 var imageArrayPush = imageI;
}else{
  var imageArrayPush = [];
}

function imageUpload(section){
// alert(section);
    if(section == 'subcat'){
      var url = '<?php echo base_url()?>index.php/Admin/add_multiple_image_subcat';
    }else if(section == 'home'){
      var url = '<?php echo base_url()?>index.php/Admin/add_multiple_image_homeslider';
    }else{
      var url = '<?php echo base_url()?>index.php/Admin/add_multiple_image';
    }

    var fd = new FormData();
    var files = $('#image')[0].files[0];
    fd.append('image',files);
      var form_data = new FormData();
        var ins = document.getElementById('image').files.length;
        for (var x = 0; x < ins; x++) {
            form_data.append("images[]", document.getElementById('image').files[x]);
        }

console.log(form_data);

    // AJAX request
    $.ajax({
      url: url,
      type: 'post',
      data: form_data,
      contentType: false,
      processData: false,
      dataType:'json',
 
      success: function (response) {

        if(response.success == true){
           var table = "";
          if(response.count > 0){
            for (var loop = 0; loop < response.count; loop++) //
              {  
                table += "<div class='content col-md-2 col-sm-2 col-xs-12' id='content_"+loop+"' ><img imname = "+response.imageName[loop]+" src='"+response.response[loop].fileName+"' width='65' height='65' style='height: 65px;width:65px'><span class='delete' id='delete_"+loop+"' section = "+section+" ><img style='height: 20px;' src='<?php echo base_url().'/assets/images/delete.png'?>' ></span></div>&nbsp";
                imageArrayPush.push(response.imageName[loop]);
                $('#imageArrayPush').val(imageArrayPush);
              }
              $('.show-image').show();
             $('#preview_image').append(table);
          }
        }else{
          alert(response.errorMessage);
        }
        },
        error: function (response) {
            $('#msg').html(response); // display error response from the server
        }

    });
  };


$('#preview_image').on('click','.content .delete',function(){
 
  var id = this.id;
  var split_id = id.split('_');
  var num = split_id[1];

  // Get image source
  var section = $(this).attr('section');
  if(section == 'subcat'){
      var url = '<?php echo base_url()?>index.php/Admin/remove_image_subcat';
    }else if(section == 'home'){
      var url = '<?php echo base_url()?>index.php/Admin/remove_image_homeslider';
    }else{
      var url = '<?php echo base_url()?>index.php/Admin/remove_image';
  }
  var imgElement_src = $( '#content_'+num+' img' ).attr("imname");
   $.ajax({
        url: url,
        type: 'post',
        data: {path: imgElement_src,request: 2},
        success: function(response){
           $('#content_'+num).remove(); 
           var removeItem = imgElement_src;
           console.log(imageArrayPush+ '   imageArrayPushtest' );
            console.log(removeItem+ '   removeItem');
            imageArrayPush = $.grep(imageArrayPush, function(value) {
              //alert(value);
              return value != removeItem;
            });

            $('#imageArrayPush').val(imageArrayPush);
        } 
   }); 

  
 
});



$('#preview_image').on('click','.contentimg .deleteimg',function(){
  var id = this.id;
  var split_id = id.split('_');
  var num = split_id[1];
  var imgElement_srct = $('#contentimg_'+num+' img' ).attr("imname");
  $('#contentimg_'+num).remove(); 
   var removeItem = imgElement_srct;
   console.log(imageArrayPush+ ' imageArrayPush');
 

   console.log(removeItem+ '   removeItem');
    imageArrayPush = $.grep(imageArrayPush, function(value) {
      //alert(value);
      return value != removeItem;
    });
    $('#imageArrayPush').val(imageArrayPush);
  
});


</script>
  </body>
</html>

<style>
      .round-btn { padding : 1px 10px !important; }
      .file-return{display: none}
      .btn-success{ background : #39b54a;}
      .btn-action{ pointer-events: none; }
      

</style>