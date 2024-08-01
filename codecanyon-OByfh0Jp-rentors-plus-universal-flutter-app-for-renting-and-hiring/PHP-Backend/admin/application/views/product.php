<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>All Products</h3>
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
                    <small class="sub-head">Products</small>
                    <div class="clearfix"></div>
                  </div>
                  
                   <div class="btn-group dropdown pull-right">
 <label style="
    margin-right: 10px;
    margin-top: 10px;
">Status</label>


  <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
   <div class="dropdown-menu drp-mn-bg">
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/product_list');?>" status="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>   
  <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/product_list?status='.base64_encode('1')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Confirmed</a></div>
  <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/product_list?status='.base64_encode('2')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Rejected</a></div>
  <div class="drp-btn-bg"><a class="dropdown-item btn5 w100 drp-btn100" href="<?php echo base_url('index.php/Admin/product_list?status='.base64_encode('0')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Pending</a></div>

  </div>
</div>
                  
                  <div class="x_content">
                    <!-- <p class="text-muted font-13 m-b-30">
                      DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: <code>$().DataTable();</code>
                    </p> -->
                    <table id="datatable" class="table table2">
                      <thead>
                       <tr>
                          <th>S. No.</th>
                          <th>Product Id</th>
                          <th>Product Name</th>
                          <th>Category Name</th>
                          <th>Sub Category Name</th>
                          <th>Status</th>
                          <th>Manage</th>
                        </tr>
                      </thead>
                    <tbody>
                  <?php $i=0; 

                  foreach ($product as $product) {
                    $product = (object)$product;
                $i++; ?>
                <tr>
                  <td class="py-1"><?php echo $i; ?></td>
                  <td class="py-1"><?php echo $product->product_id; ?></td>
                  <td><?php echo $product->name; ?></td>
                  <td><?php echo $product->category_name; ?></td>
                  <td><?php echo $product->sub_cat_name; ?></td>
                  <td>
                    <?php if($product->is_approved == 1){
                      $button = "Confirmed";
                      $class = 'btn-success';
                    }else if($product->is_approved == 0){
                      $button = "Pending";
                      $class = 'btn-primary';
                    }else{
                      $button = "Rejected";
                      $class = "btn-danger";
                    }
                    ?>
                      <div class="btn-group dropdown">
                      <button type="button" class="btn btn-round btn-action <?php echo $class; ?>  dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $button;?>
                      </button>
                           <div class="dropdown-menu">
                  <!--   <a class="dropdown-item" href="<?php //echo base_url('/index.php/Admin/change_status_product');?>?id=<?php //echo $product->id; ?>&status=1&request=2"><i class="fa fa-check fa-fw"></i>Active</a>


                    <a class="dropdown-item" href="<?php //echo base_url('/index.php/Admin/change_status_product');?>?id=<?php //echo $product->id; ?>&status=0&request=2"><i class="fa fa-check fa-fw"></i>Deactive</a>
 -->

                   <!--  <a class="dropdown-item" href="<?php //echo base_url('index.php/Admin/editproduct/').$product->id ?>"><i class="fa fa-check fa-fw"></i>Edit</a>

 -->                    
                     <!-- <a class="dropdown-item changeStatus btn3" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=1" status="3" style="padding: 12px 16px;font-size: 14px;">Confirm</a><br/>
                    
                     <a class="dropdown-item changeStatus btn6" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=0" status="4" style="padding: 12px 16px;font-size: 14px;">Pending</a><br/>
                  
                     <a class="dropdown-item changeStatus btn4" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=2" status="5" style="padding: 12px 16px;font-size: 14px;">Rejected</a> -->
 
                  </div>
                    </div>
                  </td>

                   <td>
                      <a class="btn btn6" style="max-width:29px !important;" href="<?php echo base_url('/index.php/Admin/productDetails');?>?id=<?php echo $product->id; ?>"><i class="fa fa-eye" aria-hidden="true"></i></a>


                      <?php if($product->is_approved == 1){
                       ?>
                         <a class="btn pro-btn btn6 changeStatus" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=2&user=<?php echo $product->user_id; ?>" status="5"><i class="fa fa-times" aria-hidden="true"></i></a>
                        <?php
                      }else if($product->is_approved == 0){
                        ?>
                         <a class="btn pro-btn btn3 changeStatus" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=1&user=<?php echo $product->user_id; ?>" status="3"><i class="fa fa-check" aria-hidden="true"></i></a>
                        <?php
                      }else{
                        ?>
                         <a class="btn pro-btn btn3 changeStatus" href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $product->id; ?>&status=1&user=<?php echo $product->user_id; ?>" status="3"><i class="fa fa-check" aria-hidden="true"></i></a>
                        <?php
                      }
                      ?>
                      
                      <a class="btn pro-btn btn6 productDelete" style="max-width:29px !important;" href="<?php echo base_url('/index.php/Admin/deleteProduct');?>?id=<?php echo $product->id; ?>"><i class="fa fa-trash" aria-hidden="true"></i></a>
                    </td>
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
