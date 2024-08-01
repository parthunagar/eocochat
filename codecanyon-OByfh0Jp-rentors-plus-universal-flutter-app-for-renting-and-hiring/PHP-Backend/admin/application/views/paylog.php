<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
    <div class="title_left">
    <h3>All Pay Subscription Log</h3>
    </div>
  </div>

  <div class="clearfix"></div>
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title brdr1">
          <small class="sub-head">Pay Subscription Logs</small>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <table id="datatable" class="table table2">
            <thead>
              <tr>
                <th>S. No</th>
                <th>User Name</th>
                <th>User Email</th>
                <th>Plan Name</th>
                <th>Amount</th>
                <th>Currency Type</th>
                <th>Secret Key</th>
              </tr>
            </thead>
            <tbody>
              <?php
              $i=0;
             foreach ($paylog as $log) {
                $i++;
                ?>
                <tr>
                  <td class="py-1">
                  <?php echo $i; ?>
                  </td>
                  <td>
                  <?php echo $log->name; ?>
                  </td>
                  <td>
                  <?php //echo $log->email; ?>********
                  </td>
                  <td>
                  <?php echo $log->title; ?>
                  </td>
                  <td>
                  <?php echo $log->amount; ?>
                  </td>
                  <td>
                  <?php echo $log->currency; ?>
                  </td>


                  <td>
                  <?php echo $log->client_secret; ?>
                  </td>                  <!-- <td>
                  <?php 
                  //if(!empty($log->mobile)) { 
                    //echo $log->country_code.' '.$log->mobile; 
                  } 
                  ?>
                  </td> -->
                  
                </tr>
               
              </tbody>
            </table>
          </div>
        </div>
      </div>



    </div>
  </div>

</div>
<!-- /page content -->
