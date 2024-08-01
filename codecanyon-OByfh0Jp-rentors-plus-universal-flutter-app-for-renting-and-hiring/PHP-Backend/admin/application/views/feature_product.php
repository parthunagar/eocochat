<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Feature Products Request</h3>
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
                          <th>Action</th>
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
                      <a class="btn pro-btn btn3 changeStatus" href="<?php echo base_url('/index.php/Admin/approve_feature_subscription');?>?id=<?php echo $product->id; ?>&feature=1" status="3"><i class="fa fa-check" aria-hidden="true"></i></a>

                         <a class="btn pro-btn btn6 changeStatus" href="<?php echo base_url('/index.php/Admin/approve_feature_subscription');?>?id=<?php echo $product->id; ?>&feature=0" status="5"><i class="fa fa-times" aria-hidden="true"></i></a>
                        
                        
                        
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
