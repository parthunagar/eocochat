

<?php $cimage = array();?>

<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Add Home Slider Image</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                      <?php $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                      if(!empty($cat_id)){
                          $url = 'index.php/Admin/add_category?id='.$cat_id;
                      }else{
                          $url = 'index.php/Admin/add_category';
                      }
                     echo form_open_multipart($url, $attributes); ?>
                
                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Slider Image
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <div class="input-file-container">
				     <input class="input-file" id="image" section="home" type="file" name="files[]" multiple>

							<label tabindex="0" for="my-file" class="input-file-trigger btn5">Select a file...</label>
						  </div>
  						  <p class="file-return"></p>
                        </div>
                      </div>
                      <div class="form-group show-image" <?php if(!empty($sliderImage)){ ?>style="display: block;"<?php } else{ ?>style="display: none;"<?php } ?>>
                        
                        <div class="col-md-12 col-sm-12 col-xs-12">
                           <div id='preview_image'>
                            <?php 
                            if(!empty($sliderImage)){
                              $ci = 0;
                              foreach($sliderImage as $img){ 
                                //$img = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/home/".$img;
                                $urlc = str_replace("/admin","",base_url());
                                $img = $urlc.'uploads/home/'.$img;
                                ?>
                                <div class='content col-md-2 col-sm-2 col-xs-12' id='content_<?php echo $ci; ?>' ><img imname = "<?php echo $img;?>" src='<?php echo $img;?>' width='65' height='65' style='height: 65px; width:65px' class="img-brdr"><span class='delete del-icon' id='delete_<?php echo $ci;?>' section = "home" ><img style='height: 20px;' src='<?php echo base_url().'/assets/images/delete.png'?>' ></span></div>&nbsp



                             <?php
                             $ci++;
                             } 
                          }
                          $cimage = implode(',',$cimage);
                          ?>


                           </div>
                        </div>
                       
                      </div>
                      <input type="hidden" name="imageArrayPush" id="imageArrayPush" value="<?php echo $cimage;?>"/>



                     

                    </form>
                  </div>
                </div>
              </div>
            </div>


            

            <div class="clearfix"></div>

            
          </div>
      
        </div>
        <!-- /page content -->
        
        
        
        
        <script type="text/javascript">
	document.querySelector("html").classList.add('js');

var fileInput  = document.querySelector( ".input-file" ),  
    button     = document.querySelector( ".input-file-trigger" ),
    the_return = document.querySelector(".file-return");
      
button.addEventListener( "keydown", function( event ) {  
    if ( event.keyCode == 13 || event.keyCode == 32 ) {  
        fileInput.focus();  
    }  
});
button.addEventListener( "click", function( event ) {
   fileInput.focus();
   return false;
});  
fileInput.addEventListener( "change", function( event ) {  
    the_return.innerHTML = this.value;  
});  
</script>
