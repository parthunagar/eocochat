 <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            
            
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_content">
                     <div class="" role="tabpanel" data-example-id="togglable-tabs">
                         <div class="btn-group dropdown pull-right">
                    <a href="<?php echo base_url('index.php/Admin/product_list'); ?>" class="filtr-bg"  aria-haspopup="true" aria-expanded="false"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                     

                  
                  </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">
                     
                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                          <li role="presentation" class="active bck-clr"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Product Details</a>
                          </li>
                         <!--  <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">Post Request</a>
                          </li> -->
                          <li role="presentation" class=" bck-clr"><a href="#tab_content4" role="tab" id="profile-tab3" data-toggle="tab" aria-expanded="false">Documents</a>
                          </li>

                           <li role="presentation" class=" bck-clr"><a href="#tab_content5" role="tab" id="profile-tab4" data-toggle="tab" aria-expanded="false">Images</a>
                          </li>

                        </ul>
                        <div id="myTabContent" class="tab-content">
                          <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">

                            <!-- start recent activity -->
                            <ul class="messages">
                              <li>
                                <img src="<?php echo base_url('/assets/images/faces/face1.jpg'); ?>" class="avatar" alt="Avatar">
                                
                                <div class="message_wrapper">
                                  <h4 class="heading"><?php echo ucfirst($productDetails->name); ?></h4>

                                    
      <table id="" class="table table-striped table-bordered">
        <thead>
         <tr>
          <th>Field</th>
          <th>Value</th>
          
          </tr>
        </thead>
        <tbody>
          <?php $details = json_decode($productDetails->details); 
             // echo "<pre>";print_r($details);
              foreach ($details as $key => $value) {
                ?>


                  <tr>
                    <td><?php echo $key;?></td>
                    <?php 
                    if($key == 'fileds'){
                      ?><td><?php
                         foreach($value as $val){
                          //print_r($val);die;
                          ?>
                            <?php echo $val->key;?> : <?php echo $val->value;?> <br> 
                          
                           
                            <?php
                        }
                    }
                     else{
                      ?><td><?php echo $value;?><td><?php

                    } ?>
                  </td>
                    
                  </tr>


                  <?php
              } 
          ?>
        </tbody> 
      </table>
  
                                  <blockquote class="message" style="word-wrap: break-word;"><?php //echo ucfirst($productDetails->details); ?></blockquote>
                                  
                                  <div class="btn-bck">


                                  <a href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $productDetails->id; ?>&status=1&details=1" status="3" class="btn3 changeStatus">Approve</a>
                                  <a href="<?php echo base_url('/index.php/Admin/change_approved_status');?>?id=<?php echo $productDetails->id; ?>&status=2&details=1" status="5" class="btn4 changeStatus">Reject</a>


                                  </div>
                                  <br />
                                  <p class="url">
                                    <span class=" " aria-hidden="true" data-icon=""></span>
                                    <a href="#" class="col-md-4 col-sm-4 col-xs-12"><i class="fa fa-paperclip"></i><b> Category :</b> <?php echo $productDetails->category_name; ?></a>
                                    
                                    <span class="" aria-hidden="true" data-icon=""></span>
                                    <a href="#" class="col-md-4 col-sm-4 col-xs-12"><i class="fa fa-paperclip"></i><b>Sub Category: </b> <?php //echo $postrequest; ?> </a>

                                    <span class="" aria-hidden="true" data-icon=""></span>
                                    <a href="#" class="col-md-4 col-sm-4 col-xs-12"><i class="fa fa-paperclip"></i><b> Total Wish List : </b><?php echo $wishlist; ?> </a>
                                   
                                  </p>


                                </div>
                              </li>
                            
                            </ul>
                            <!-- end recent activity -->

                          </div>
                          
  <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
      <table id="example" class="table table-striped table-bordered">
        <thead>
         <tr>
          <th>User Name</th>
          <th>Likes</th>
          <th>Comments</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($getPosts as $getPosts) { ?>
          <tr>
          <td><?php echo $getPosts->user_name; ?></td>
          <td><?php echo $getPosts->likes; ?></td>
          <td><?php echo $getPosts->comments; ?></td>             
          </tr>
          <?php } ?>
        </tbody> 
      </table>
  </div>



<div role="tabpanel" class="tab-pane fade" id="tab_content4" aria-labelledby="profile-tab3">
 
     <div class="x_content">

            <div class="row">
                    
                    <?php
                    if(!empty($productDetails->details)){
                      $documetns = json_decode($productDetails->details);
                      if(!empty($documetns->document)){
                          $documetns = explode(',',$documetns->document);
                          foreach($documetns as $doc){
                            $doc = str_replace(array('[',']'),'',$doc);
                            ?>
                           <div class="col-md-55">
                              <div class="thumbnail">
                                <div class="view-first">
                                  <img style="width: 100%; display: block;" src="<?php echo $doc;?>" alt="Document" />
                                 </div>
                                
                              </div>
                            </div>
                          <?php 
                          }
                      }else{
                        ?>No Documents Available<?php
                      }
                    }
                    ?>
                     

                  </div>
                  </div>
              </div>




<div role="tabpanel" class="tab-pane fade" id="tab_content5" aria-labelledby="profile-tab3">
 
     <div class="x_content">

            <div class="row">
                    
                    <?php

                    if(!empty($productDetails->details)){
                      $documetns = json_decode($productDetails->details);
                      if(!empty($documetns->images)){
                          $documetns = explode(',',$documetns->images);
                          foreach($documetns as $doc){
                            $doc = str_replace(array('[',']'),'',$doc);
                            ?>
                           <div class="col-md-55">
                              <div class="thumbnail">
                                <div class="view-first">
                                  <img style="width: 100%; display: block;" src="<?php echo $doc;?>" alt="Document" />
                                 </div>
                                
                              </div>
                            </div>
                          <?php 
                          }
                      }else{
                        ?>No Documents Available<?php
                      }
                    }
                    ?>
                     

                  </div>
                  </div>
              </div>





  </div>
  </div>
  </div>
  </div>
  </div>
  </div>
  </div>
  </div>
  </div>
        <!-- /page content -->
