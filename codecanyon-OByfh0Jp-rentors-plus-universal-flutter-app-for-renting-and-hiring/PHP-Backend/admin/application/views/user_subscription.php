


<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
           











           

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title brdr1">
                    <small class="sub-head">Subscribed User List</small>
                    <div class="clearfix"></div>
                  </div>
                 
                  
                  
                  <div class="x_content">
                    <table id="datatable" class="table table2">
                      <thead>
                        <tr>
                          <th>S. No</th>
                          <th>Name</th>
                          <th>Email Id</th>
                          <th>Subsciption Plan</th>
                          <th>Type</th>
                          <th>Start Date</th>
                          <th>End Date</th>
                          <th>Total Payment</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php
                        $i=0;
                        if(!empty($user_subscription)){
                          foreach ($user_subscription as $subscrip) {
                            $i++;
                            ?>
                            <tr>
                              <td class="py-1">
                              <?php echo $i; ?>
                              </td>
                              <td>
                              <?php echo $subscrip->name; ?>
                              </td>
                              <td>
                              <?php //echo $subscrip->email; ?>********
                              </td>
                            <!--  <td>
                  <?php 
                  if(!empty($subscrip->mobile)) { 
                    //echo $subscrip->country_code.' '.$subscrip->mobile; 
                  } 
                  ?>********
                  </td> -->

                              <td>
                              <?php echo ucfirst($subscrip->title); ?>
                              </td>

                               <td>
                              <?php 
                              echo ucfirst($subscrip->type); ?>
                              </td>
                               
                            
                               
                               <td>
                              <?php echo $subscrip->start_date; ?>
                              </td>
                             
                              <td>
                              <?php echo $subscrip->expiry_date; ?>
                              </td>
                             
                              <td>
                              <span>Rs.5,000/-</span>
                              </td>
                                <td>
                      


                      
                         <a class="btn pro-btn btn3 changeStatus" title = "Approve" href="<?php echo base_url('/index.php/Admin/approve_user_Subscription');?>?id=<?php echo $subscrip->id; ?>&status=1" status="3"><i class="fa fa-check" aria-hidden="true"></i></a>
                        
                         <a class="btn pro-btn btn6 changeStatus" title = "Reject" href="<?php echo base_url('/index.php/Admin/approve_user_Subscription');?>?id=<?php echo $subscrip->id; ?>&status=0" status="5"><i class="fa fa-times" aria-hidden="true"></i></a>
                       
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
