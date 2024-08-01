<?php $cimage = array();?>

<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"  onclick="myFunction()">
                <button type="button" class="btn btn-top btn6"><span class="fa fa-plus "></span> Add Sub Category</button>
              </div>

              
            </div>
            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12" id="showHideCat" <?php if(!empty(@$sub_cat_data->id)){ ?>style="display: block;"<?php }else { ?>style="display: none;"<?php } ?>>
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Add Sub Category</small>
                   
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                      <?php $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                       
                       if(!empty($sub_cat_data->id)){
                          $url = 'index.php/Admin/add_subcategory?id='.$sub_cat_data->id;
                      }else{
                          $url = 'index.php/Admin/add_subcategory';
                      }
                     echo form_open_multipart($url, $attributes); ?>
           
                    
                    
                    
                    
                     <div class="col-sm-6 col-xs-12 brdr2">
                     <div class="sub-head2"><h3>Sub Category Form Fields</h3></div>
                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Sub Category Title <span class="required">*</span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <input type="text" id="name" name="name" maxlength="30" required="" placeholder="Enter Name" class="form-control col-md-7 col-xs-12 input1" value="<?php echo @$sub_cat_data->name;?>">
                        </div>
                      </div>


                      <!-- <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text">Select Super Category</label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <select class="select2_single form-control input1" onChange="getCategorySelect('super_category_id', 'ctgy_select_box');" name="super_category_id" id="super_category_id" required>
                            <?php foreach ($super_category_id as $super_category_id) { ?>
                             <option value="<?php echo $super_category_id->id; ?>" <?php if($super_category_id->id == @$sub_cat_data->super_category_id) { echo "selected";} ?>><?php echo $super_category_id->name; ?>
                             </option>
                             <?php } ?>
                          </select>
                        </div>
                      </div> -->

                    <div id="ctgy_select_box">
                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text">Select Category</label>
                        <div class="col-md-8 col-sm-8 col-xs-9" onChange="getCategorySelect('category_id', 'ctgy_select_boxs');">
                          <select class="select2_single form-control input1" name="category_id" required>
                            <option>Select Category</option>
                            <?php foreach ($category_id as $category_id) { ?>
                             <option value="<?php echo $category_id->id; ?>" <?php if($category_id->id == @$sub_cat_data->category_id) { echo "selected";} ?>><?php echo $category_id->name; ?>
                             </option>
                             <?php } ?>
                          </select>
                        </div>
                      </div>
                    </div>


                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-8 col-xs-5 col-form-label label-text" for="first-name">Sub Category Icon</label>
                        <div class="col-md-8 col-sm-8 col-xs-7">
                          <input type="hidden" name="iconArray" id="iconArray" value=""/>
                          <input type="hidden" name="icon_value" id="icon_value" value=""/>
                          <?php 
                          $icon = '';
                          if(!empty($sub_cat_data->sub_cat_icon)){ 
                           $url = str_replace("/admin","",base_url());
                           $icon = str_replace($url.'uploads/subcategory/',"",$sub_cat_data->sub_cat_icon);
                          }
                          //echo $url;
                          //echo $icon;
                          ?>
                          <input type="hidden" name="icon_old" id="icon_old" value="<?php echo $icon;?>">
                          <div class="input-file-container">


              <input class="input-file" id="icon" type="file" section="subcat">
              <label tabindex="0" for="my-file" class="input-file-trigger btn5">Select a file...</label>
              </div>
                <p class="file-return"></p>
                        </div>
                      </div>


                      <div class="form-group icon-show" <?php if(!empty($sub_cat_data->sub_cat_icon)){ ?>style="display: block;"<?php } else{ ?>style="display: none;"<?php } ?>>
                        <label class="control-label col-md-4 col-form-label label-text" for="first-name">
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                           <div id='preview_icon'>
                             
                        <img src='<?php echo @$sub_cat_data->sub_cat_icon;?>' width='65' height='65'>
                             
                           </div>
                        </div>
                       
                      </div>




                       


                      



                      <!-- <div class="form-group">
                        <label class="control-label col-md-4 col-form-label label-text" for="first-name">Is Verification Required?
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <label class="control-label col-sm-3 label-text" for="first-name"><input type="checkbox" name="varified" value="1" <?php if(@$sub_cat_data->verification_required == 1){ ?>checked="checked" <?php } ?>>
                        </label>
                        </div>
                      </div> -->

                      <div class="form-group">
                        <label class="control-label col-md-4 col-form-label label-text" for="first-name">Status
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <label class="control-label col-sm-3 label-text" for="first-name"><input type="radio" name="cstatus" value="1" checked="checked"> Active
                        </label>
                            <label class="control-label col-sm-3 label-text" for="first-name"><input type="radio" name="cstatus" value="0" <?php if($sub_cat_data->status == 0) { echo "checked";}?>> Inactive
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <div class="col-xs-12">
                          <a class="btn btn7" href="<?php echo base_url('index.php/Admin/add_subcategory'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3"><?php if(!empty($sub_cat_data)){ echo "Update"; } else { echo "Submit"; }?></button>
                        </div>
                      </div>
                     </div>
                     
                     <div class="col-sm-6 col-xs-12 scrl1">
                      <div class="sub-head2"><h3>Sub Category Form Fields</h3><p>Add the form fields according to subcategories. These fields will be displayed on app and user will be asked to fill these fields when any product under this subcategory will be added.</p></div>

                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Label 1 
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <input type="text" name="" maxlength="30" readonly class="form-control col-md-7 col-xs-12 input1" value="Brand Name">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Label 2
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <input type="text" name="" maxlength="30" readonly class="form-control col-md-7 col-xs-12 input1" value="Model">
                        </div>
                      </div>

                        <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Label 3
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <input type="text" name="" maxlength="30" readonly class="form-control col-md-7 col-xs-12 input1" value="Rate">
                        </div>
                      </div>
                       <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Label 4
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-9">
                          <input type="text" name="" maxlength="30" readonly class="form-control col-md-7 col-xs-12 input1" value="Minimum Booking Price">
                        </div>
                      </div>

                      
                      <div class="field_wrapper">

                      <?php 
                      $j = 5;
                      if(!empty($sub_cat_data->form_field)){
                        $form_field = json_decode($sub_cat_data->form_field);
                          $form_field_value = array();
                          foreach ($form_field as  $value) {
                            $value = $value->lable;
                            $form_field_value[] =$value;
                          }
                          //print_r($form_field_value);die;

                          if(!empty($form_field_value)){
                            $i = 0;
                             //  $j;
                            foreach($form_field_value as $value){
                                

                               ?>
                              <div class="form-group"> <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Field Label <?php echo $j;?></label><div class="col-md-5 col-sm-5 col-xs-12"><input placeholder="Enter Field Label <?php echo $j;?>" type="text" name="formfield[]" maxlength="30" class="form-control col-md-7 col-xs-12 input1" value="<?php echo $value;?>"></div><a  href="javascript:void(0);" class="remove_button col-md-2 col-sm-2 col-xs-12" title="Add field"><img src="<?php echo base_url().'/assets/images/minus.png'?>" style="height: 35px;" ></a></div>




                                  <?php
                                  $j++;
                                
                                $i++;
                                
                            }
                          }
                      }
                      ?>
                    </div>
                    <div>


                        <div class="form-group">
                          <label class="control-label col-md-4 col-sm-4 col-xs-3 col-form-label label-text" for="first-name">Add New Field
                          </label>
                          <div class="col-md-6 col-sm-6 col-xs-9">
                            <!-- <input type="text" name="formfield[]" maxlength="30" class="form-control col-md-7 col-xs-12 input1" value="" placeholder="Enter Field Label <?php echo $j;?>"> -->
                            <a  href="javascript:void(0);" class="add_button col-md-2 col-sm-2 col-xs-12" val="<?php echo $j;?>" title="Add field"><img src="<?php echo base_url().'/assets/images/plus.png'?>" style="height: 35px;" ></a>
                          </div>
                          </div>
                      </div>
                       <div class="form-group">
                        <!-- <div class="sub-cat-btn">
                          <a class="btn btn5" href="<?php //echo base_url('index.php/Admin/add_subcategory'); ?>">Save</a>
                        </div> -->
                        </div>

                      </div>



                    </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="page-title">
              <div class="title_left">
                <h3>All Sub Category
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
                    <small class="sub-head">Sub Categories
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
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/subcategory_list');?>" cstatus="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>    
  <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/subcategory_list?cstatus='.base64_encode('1')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Active</a></div>
  <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/subcategory_list?cstatus='.base64_encode('0')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Inactive</a></div>

  </div>
</div>
                  
                  <div class="x_content">
                    <!-- <p class="text-muted font-13 m-b-30">
                      DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: <code>$().DataTable();</code>
                    </p> -->
                    <table id="datatable" class="table table2">
                      <thead>
                       <tr>
                <th>
                  S. No
                </th>
               <!--  <th>
                 Super Category
                </th> -->
               
                 <th>
                 Sub Category Name
                </th>
                 <th>
                 Category Name
                </th>
                <th>Form Field</th>
                <th>Icon Image</th>
                <th>status
                <th style="width: 185px !important;">Action</th>
              </tr>
                      </thead>


                      <tbody>
                         <?php
            $i=0;
             foreach ($subcategory as $subcategory) {
              $i++;
              ?>
              <tr>
                <td class="py-1">
                  <?php echo $i; ?>
                </td>
               <!--  <td>
                  <?php //echo $subcategory->superCategoryName; ?>
                </td> -->
               
                <td>
                  <?php echo $subcategory->name; ?>
                </td>
                 <td>
                  <?php echo $subcategory->categoryName; ?>
                </td>
                <td><?php echo $subcategory->fome_field_val; ?></td>
                <td>
                <?php if(!empty($subcategory->sub_cat_icon)){?>
                                <img src=" <?php echo $subcategory->sub_cat_icon; ?>" style="height: 50px;width: 50px;">
                                <?php } ?>
                </td>
               
                <td>
                  <?php if($subcategory->status==1){ 
                    ?><a href="javascript:void(0);" class=" btn-action btn btn-round btn-success btn-sm"  aria-haspopup="true" aria-expanded="false">
                      Active
                      </a><?php
                    }elseif($subcategory->status==0) {
                      ?><a href="javascript:void(0);"  class=" btn-action btn btn-round btn-danger btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Inactive
                      </a><?php
                    } ?>

                  </td>

                  

                <td>
                  <?php if($subcategory->status==1)
                  {
                    $url = base_url('/index.php/Admin/change_status_subcat').'?id='.$subcategory->id.'&status=0&request=2';
                  ?>

                   <a title="Deactivate" class="changeStatus" status = "1"  href="<?php echo $url;?>"></i><img class="btn-img" src='<?php echo base_url().'assets/test/images/off.jpg'?>' ></a>
                  
                   
                  <?php
                  }
                  elseif($subcategory->status==0) {
                     $url = base_url('/index.php/Admin/change_status_subcat').'?id='.$subcategory->id.'&status=1&request=2';
                  ?>
                  <a title="Activate" class="changeStatus" status = "2"  href="<?php echo $url;?>"><img class="btn-img" src='<?php echo base_url().'assets/test/images/on.jpg'?>' ></a>
                  <?php
                  } ?>

                  <a title="Edit" style="background-color: #1a4db;border:1px solid #1a4db" class="btn pro-btn btn-primary btn6" href="<?php echo base_url('/index.php/Admin/subcategory_list');?>?id=<?php echo $subcategory->id; ?>&status=1&request=2"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
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

        
        
        
