<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>All Wish List</h3>
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
                  <div class="x_title">
                    <small>Wish List</small>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <!-- <p class="text-muted font-13 m-b-30">
                      DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: <code>$().DataTable();</code>
                    </p> -->
                    <table id="datatable" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                  <th>S. No.</th>
                  <th>User Name</th>
                  <th>Product Name</th>
                  <th>Status</th>
                  <th>Manage</th>
                </tr>
                      </thead>


                      <tbody>
                        <?php $i=0; foreach ($wishdata as $wishdata) {
                $i++; ?>
                <tr>
                  <td class="py-1"><?php echo $i; ?></td>
                  <td><?php echo $wishdata->userName; ?></td>
                  <td><?php echo $wishdata->productName; ?></td>
                  <td>
                   <?php if($wishdata->status==1) { ?>
                   <label class="btn btn-round btn-success round-btn">Active</label>
                   <?php } elseif($wishdata->status==0) {  ?>
                   <label class="btn btn-round btn-danger round-btn">Deactive</label>
                   <?php } ?>
                  </td>
                   <td>
                      <div class="btn-group dropdown">
                      <button type="button" class="btn btn-primary" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Manage
                      </button>
                       <div class="dropdown-menu">
                    <a class="dropdown-item" href="<?php echo base_url('/index.php/Admin/change_status_wishlist');?>?id=<?php echo $wishdata->id; ?>&status=1&request=2"><i class="fa fa-reply fa-fw"></i>Active</a>
                    <a class="dropdown-item" href="<?php echo base_url('/index.php/Admin/change_status_wishlist');?>?id=<?php echo $wishdata->id; ?>&status=0&request=2"><i class="fa fa-reply fa-fw"></i>Deactive</a>
                    <a class="dropdown-item" href="<?php echo base_url('/index.php/Admin/change_status_wishlist');?>?id=<?php echo $wishdata->id; ?>&status=2&request=3"><i class="fa fa-reply fa-fw"></i>Delete</a>
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
