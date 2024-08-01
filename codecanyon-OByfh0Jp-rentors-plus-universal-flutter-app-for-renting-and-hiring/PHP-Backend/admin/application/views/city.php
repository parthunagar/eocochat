


<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"  onclick="myFunction()">
                <button type="button" class="btn btn-top btn6"><span class="fa fa-plus "></span> Add City</button>
              </div>
            </div>
            <div class="row" >
              <div class="col-md-12 col-sm-12 col-xs-12" id="showHideCat" <?php if(!empty($id)){ ?>style="display: block;"<?php }else { ?>style="display: none;"<?php } ?> >
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Add City</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                   <!--  <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left"> -->

                      <?php $attributes = array('id' => 'form_validation','name'=>'add_coupon','class'=>'form-horizontal form-label-left'); 
                      if(!empty($id)){
                          $url = 'index.php/Admin/add_city?id='.$id;
                      }else{
                          $url = 'index.php/Admin/add_city';
                      }
                     echo form_open_multipart($url, $attributes); ?>

                      <div class="form-group">
                        <label class="control-label col-md-2 col-form-label label-text" for="first-name">City Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="city_name" name="city_name" maxlength="30" required="" placeholder="Enter City Name" class="form-control col-md-7 col-xs-12 input1" value="<?php if(!empty($city_data)){ echo $city_data->city_name; } ?>">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <div class="">
                          <a class="btn btn4" href="<?php echo base_url('index.php/Admin/city_list'); ?>">Cancel</a>
                          <button type="submit" class="btn btn3"><?php if(!empty($id)){ echo "Update"; } else { echo "Submit"; }?></button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>


            <div class="page-title">
              <div class="title_left">
                <h3>All City
</h3>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Cities</small>
                    <div class="clearfix"></div>
                  </div>
                  
                 <div class="btn-group dropdown pull-right">
                  <label style="
    margin-right: 10px;
    margin-top: 10px;
">Status</label>
                    <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
                     <div class="dropdown-menu drp-mn-bg">
                    <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/city_list');?>" cstatus="3" style="padding: 2px 6px;font-size: 14px;">All</a></div> 
                    <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/city_list?cstatus='.base64_encode('1')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Active</a></div>
                    <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/city_list?cstatus='.base64_encode('0')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Inactive</a></div>

                    </div>
                  </div>
                  
                  <div class="x_content">
                    <table id="datatable" class="table table2">
                      <thead>
                        <tr>
                          <th>S. No</th>
                          <th>City Name</th>
                          <th>Status</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php
                        $i=0;
                        if(!empty($city)){
                          foreach ($city as $ct) {
                            $i++;
                            ?>
                            <tr>
                              <td class="py-1">
                              <?php echo $i; ?>
                              </td>
                              <td>
                              <?php echo $ct->city_name; ?>
                              </td>

                               <td>

                  <?php if($ct->status==1){ 
                    ?><a href="javascript:void(0);" class=" btn-action btn btn-round btn-success btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Active
                      </a><?php
                  }elseif($ct->status==0) {
                    ?><a href="javascript:void(0);"  class=" btn-action btn btn-round btn-danger btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Inactive
                      </a><?php
                  } ?>

</td>



                              <td>
                             <?php if($ct->status==1)
                                {
                                  $url = base_url('/index.php/Admin/change_status_city').'?id='.$ct->id.'&status=0&request=2';
                                ?>
                                <a class="btn btn-round btn-danger round-btn changeStatus btn4" status = "1"  href="<?php echo $url;?>"></i>Deacitvate</a>
                                 
                                <?php
                                }
                                elseif($ct->status==0) {
                                   $url = base_url('/index.php/Admin/change_status_city').'?id='.$ct->id.'&status=1&request=2';
                                ?>
                                <a class="btn btn-round btn-success round-btn btn3 changeStatus" status = "2" href="<?php echo $url;?>">Activate</a>
                                 
                                <?php
                                } ?>
                                <a class="btn btn-round btn-primary round-btn" href="<?php echo base_url('/index.php/Admin/city_list');?>?id=<?php echo $ct->id; ?>&status=1&request=2"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
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
