



<?php $cimage = array();?>

<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"  onclick="myFunction()">
                <button type="button" class="btn btn-top btn6"><span class="fa fa-plus "></span> Add Category</button>
              </div>

              
            </div>
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12" id="showHideCat" <?php if(!empty($cat_id)){ ?>style="display: block;"<?php }else { ?>style="display: none;"<?php } ?> >
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Add Category</small></h2>
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

                      <div class="form-group row">
                        <label class="control-label col-sm-2 col-xs-3 col-form-label label-text" for="first-name">Category Title <span class="required">*</span></label>
                        <div class="col-sm-3 col-xs-9">
                        <input type="text" id="name" name="name" maxlength="30" required="" placeholder="Enter Name" class="form-control input1" value="<?php if(!empty($cat_name)){ echo $cat_name; } ?>">
                        </div>
                      </div>

                      <!-- <div class="form-group row">
                        <label class="control-label col-sm-2 col-xs-3 col-form-label label-text">Select Super Category</label>
                        <div class="col-sm-3 col-xs-9">
                          <select class="select2_single form-control input1" name="super_category_id" required>
                            <?php foreach ($super_category_id as $super_category_id) { ?>
                             <option value="<?php echo $super_category_id->id; ?>" <?php if($super_category_id->id == @$cats->super_category_id) { echo "selected";} ?>><?php echo $super_category_id->name; ?>
                             </option>
                             <?php } ?>
                          </select>
                        </div>
                      </div> -->

                      <div class="form-group row">
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">Category Icon
                        </label>
                        <div class="col-sm-10">
                          <input type="hidden" name="iconArray" id="iconArray" value=""/>
                          <input type="hidden" name="icon_value" id="icon_value" value=""/>
                          <?php 
                          $icon = '';
                          if(!empty($cats->category_icon)){ 
                           $url = str_replace("/admin","",base_url());
                           $icon = str_replace($url.'uploads/category/',"",$cats->category_icon);
                          } ?>
                          <input type="hidden" name="icon_old" id="icon_old" value="<?php echo $icon;?>">
                          <div class="input-file-container">
              <input class="input-file" id="icon" type="file" section="cat">
              <label tabindex="0" for="my-file" class="input-file-trigger btn5 ">Select a file...</label>
              </div>
                <p class="file-return"></p>
                        </div>

                      </div>


                      <div class="form-group row icon-show" <?php if(!empty($cats->category_icon)){ ?>style="display: block;"<?php } else{ ?>style="display: none;"<?php } ?>>
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">
                        </label>
                        <div class="col-sm-10">
                           <div id='preview_icon'> <img src='<?php echo $cats->category_icon;?>' width='65' height='65'>
                             
                           </div>
                        </div>
                       
                      </div>


                      <div class="form-group row">
                        <label class="control-label col-sm-2 col-form-label label-text2" for="first-name">Category Slider Image
                        </label>
                        <div class="col-sm-10">
                          
                          <div class="input-file-container">
              <input class="input-file" id="image" section="cat" type="file" name="files[]" multiple/>

              <label tabindex="0" for="my-file" class="input-file-trigger btn5">Select a file...</label>
              </div>
                <p class="file-return"></p>
                        </div>
                      </div>
                      <div class="form-group row show-image" <?php if(!empty($cats->category_image)){ ?>style="display: block;"<?php } else{ ?>style="display: none;"<?php } ?>>
                        <label class="control-label col-sm-2 col-form-label label-text" for="first-name">
                        </label>
                        <div class="col-sm-10">
                           <div id='preview_image'>
                            <?php 
                            if(!empty($cats->category_image)){
                              $image = json_decode($cats->category_image);
                             // echo "<pre>";print_r($image);
                              $ci = 0;
                              
                              foreach($image as $img){ 
                                $urlc = str_replace("/admin","",base_url());
                                $cimg = str_replace($urlc.'uploads/category/',"",$img->image);
                                ?>
                               <div class='contentimg col-md-2 col-sm-2 col-xs-12' id='contentimg_<?php echo $ci; ?>'><img imname = "<?php echo $cimg;?>" src='<?php echo $img->image; ?>' width='65' height='65' style='height: 65px;width:65px'><span class='deleteimg' id='deleteimg_<?php echo $ci ?>'><img style='height: 20px;' src='<?php echo base_url().'/assets/images/delete.png'?>' ></span></div>&nbsp
                            <?php
                            $cimage[] = $cimg;

                            
                             $ci++; } }
                             $cimage = implode(',',$cimage);

                             ?>


                           </div>
                        </div>
                       
                      </div>
                      <input type="hidden" name="imageArrayPush" id="imageArrayPush" value="<?php echo $cimage;?>"/>




                      <!-- <div class="form-group row">
                        <label class="control-label col-sm-2 col-xs-3 col-form-label label-text" for="first-name">Category Color <span class="required">*</span></label>
                        <div class="col-sm-3 col-xs-7 input-group colorpicker-component" id="cp2">
                        <input type="text" id="category_color" name="category_color" maxlength="30" required="" placeholder="Enter Color" class="form-control input1" value="<?php if(!empty($cats->category_color)){ echo $cats->category_color; } else  { ?>#00AABB<?php } ?>"><span class="input-group-addon"><i></i></span>
                        </div>
                      </div> -->

                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">Status
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <label class="control-label col-sm-3 label-text" for="first-name"><input type="radio" name="cstatus" value="1" checked="checked"> Active
                        </label>
                            <label class="control-label col-sm-3 label-text" for="first-name"><input type="radio" name="cstatus" value="0" <?php if($cats->status == 0) { echo "checked";}?>> Inactive
                        </div>
                      </div>

      

                     
                      <div class="form-group row">
                        <div class="col-sm-12 col-xs-12">
                          <a class="btn btn7" href="<?php echo base_url('index.php/Admin/category_list'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3"><?php if(!empty($cat_name)){ echo "Update"; } else { echo "Submit"; }?></button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>


            <div class="page-title">
              <div class="title_left">
                <h3>All Category
</h3>
              </div>

              <!-- <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div> -->
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Categories
</small>
            <div class="clearfix"></div>
                  </div>
                  
                  <div class="btn-group dropdown pull-right">
 <label style="
    margin-right: 10px;
    margin-top: 10px;
">Status</label>


  <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
   <div class="dropdown-menu drp-mn-bg">
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/category_list');?>" status="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>   
  <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/category_list?cat_status='.base64_encode('1')); ?>" cstatus="3" style="padding: 2px 6px;font-size: 14px;">Active</a></div>
  <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/category_list?cat_status='.base64_encode('0')); ?>" cstatus="5" style="padding: 2px 6px;font-size: 14px;">Inactive</a></div>

  </div>
</div>

                  
                  <div class="x_content">
                    <!-- <p class="text-muted font-13 m-b-30">
                      DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: <code>$().DataTable();</code>
                    </p> -->
                    <table id="datatable" class="table table2">
                      <thead>
                       <tr>
                          <th>S. No</th>
                          <!-- <th>Super Category</th> -->
                          <th>Category Name</th>
                          <th>Icon</th>
                          <!-- <th>Color</th> -->
                          <th>Status</th>
                          <th>Action</th>
                          
                        </tr>
                      </thead>


                      <tbody>
                        <?php
                           $i=0;
                           foreach ($category as $category) {
                            $i++;
                            ?>
                            <tr>
                              <td>
                                <?php echo $i; ?>
                              </td>
                              <!-- <td>
                                <?php //echo $category->superCategoryName; ?>
                              </td> -->
                              <td>
                                <?php echo $category->name; ?>
                              </td>
                              <td>
                                <img src=" <?php echo $category->category_icon; ?>" style="height: 50px;width: 50px;">
                                                              
                              </td>
                              <!-- <td><?php echo $category->category_color; ?></td> -->




 <td>

                  <?php if($category->status==1){ 
                    ?><a href="javascript:void(0);" class="btn btn-round btn-action btn-success btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Active
                      </a><?php
                  }elseif($category->status==0) {
                    ?><a href="javascript:void(0);"  class="btn btn-round btn-action btn-danger btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Inactive
                      </a><?php
                  } ?>

</td>


                   <td>
                              <?php if($category->status==1)
                              {
                                $url = base_url('/index.php/Admin/change_status_cat').'?id='.$category->id.'&status=0&request=2';
                              ?>
                               <a class="changeStatus" title="Deactivate" status = "1" href="<?php echo $url;?>"></i><img class="btn-img" src='<?php echo base_url().'assets/test/images/off.jpg'?>' ></a>
                              
                               
                              <?php
                              }
                              elseif($category->status==0) {
                                 $url = base_url('/index.php/Admin/change_status_cat').'?id='.$category->id.'&status=1&request=2';
                              ?>
                               <a title="Activate" class="changeStatus" status = "2" href="<?php echo $url;?>"><img class="btn-img" src='<?php echo base_url().'assets/test/images/on.jpg'?>' ></a>
                              <?php
                              } ?>

                               <a title="Edit" style="background-color: #1a4db;border:1px solid #1a4db" class="btn pro-btn btn-primary btn6" href="<?php echo base_url('/index.php/Admin/category_list');?>?id=<?php echo $category->id; ?>&status=1&request=2"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>

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

