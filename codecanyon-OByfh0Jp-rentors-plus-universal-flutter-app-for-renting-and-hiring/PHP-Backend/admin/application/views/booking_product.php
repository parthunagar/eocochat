RentAndHire/application/controllers/Product.php<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
    <div class="title_left">
    <h3>Booking Request for Product</h3>
    </div>
  </div>

  <div class="clearfix"></div>
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title brdr1">
          <small class="sub-head">Booking Request for Product</small>
          <div class="clearfix"></div>
        </div>
        
        <div class="btn-group dropdown pull-right">
 

<label style="
    margin-right: 10px;
    margin-top: 10px;
">Status</label>
  <a href="" class="filtr-bg" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-filter" aria-hidden="true"></i></a>
   <div class="dropdown-menu drp-mn-bg">
  <div class="drp-btn-bg"><a class="dropdown-item btn2 w100" href="<?php echo base_url('index.php/Admin/product_booking_list');?>" status="3" style="padding: 2px 6px;font-size: 14px;">All</a></div>   
  <div class="drp-btn-bg"><a class="dropdown-item btn3 w100" href="<?php echo base_url('index.php/Admin/product_booking_list?status='.base64_encode('0')); ?>" status="3" style="padding: 2px 6px;font-size: 14px;">Pending</a></div>
  <div class="drp-btn-bg"><a class="dropdown-item btn4 w100" href="<?php echo base_url('index.php/Admin/product_booking_list?status='.base64_encode('1')); ?>" status="5" style="padding: 2px 6px;font-size: 14px;">Confirmed</a></div>

  </div>
</div>
        <div class="x_content">
          <table id="datatable" class="table table2">
            <thead>
              <tr>
                <th>S. No</th>
                <th>Product</th>
                <th>Booking Amount</th>
                <th>Duration</th>
                <th>Customer Name</th>
                
                <th>Customer Contact</th>
                <th>Customer Mail</th>
                <th>Vendor Name</th>
                
                <th>Vendor Contact</th>
                <th>Vendor Mail</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <?php
              $i=0;
             foreach ($bookingUSer as $user) {
                $i++;
                ?>
                <tr>
                  <td class="py-1">
                  <?php echo $i; ?>
                  </td>
                  <td> <?php echo $user['product_name']; ?></td>
                  <td>
                  <?php echo $user['payable_amount']; ?>
                  </td>
                  <td>
                  <?php echo $user['period']; ?>
                  </td>

                  <td> <?php echo $user['user_name']; ?></td>

                  <td>
                  <?php 
                  if(!empty($user['mobile'])) { 
                    //echo $user['country_code'].' '.$user['mobile']; 
                  } 
                  ?>********
                  </td>

                  <td> <?php //echo $user['user_email']; ?>********</td>

                  <td> <?php echo $user['vendor_name']; ?></td>

                  <td>
                  <?php 
                  if(!empty($user['vendor_mobile'])) { 
                    //echo $user['vendor_country_code'].' '.$user['vendor_mobile']; 
                  } 
                  ?>********
                  </td>

                  <td> <?php //echo $user['vendor_email']; ?>********</td>
                  <td>
                    <?php if($user['status'] == 1) { 
                      ?><a href="javascript:void(0);" class=" btn-action btn btn-round btn-success btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Confirmed
                      </a><?php
                        
                      }else{
                        ?><a href="javascript:void(0);"  class=" btn-action btn btn-round btn-primary btn-sm"  aria-haspopup="true" aria-expanded="false">
                       Pending
                      </a><?php
                      }
                     
?>
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
