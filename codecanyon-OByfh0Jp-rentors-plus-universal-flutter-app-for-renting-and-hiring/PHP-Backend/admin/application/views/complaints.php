RentAndHire/application/controllers/Product.php<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
    <div class="title_left">
    <h3>All Complaints</h3>
    </div>
  </div>

  <div class="clearfix"></div>
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title brdr1">
          <small class="sub-head">Complaints</small>
          <div class="clearfix"></div>
        </div>
        
       <!--  <a href="" class="filtr-bg"><i class="fa fa-filter" aria-hidden="true"></i></a> -->
        
        <div class="x_content">
          <table id="datatable" class="table table2">
            <thead>
              <tr>
                <th>S. No</th>
                <th>User Name</th>
                <th>User Email</th>
                <th>User Contact Number</th>
                <th>Title</th>
                <th>Complaints</th>
              </tr>
            </thead>
            <tbody>
              <?php
              $i=0;
             foreach ($complaints as $com) {
                $i++;
                ?>
                <tr>
                  <td class="py-1">
                  <?php echo $i; ?>
                  </td>
                  <td>
                  <?php echo $com['user_name']; ?>
                  </td>
                  <td>
                  <?php //echo $com['user_email']; ?>********
                  </td>
                  <td>
                  <?php 
                  if(!empty($com['mobile'])) { 
                   // echo $com['country_code'].' '.$com['mobile']; 
                  } 
                  ?>********
                  </td>
                 <td><?php echo $com['title']; ?></td>
                 <td><?php echo $com['complaint']; ?></td>
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
