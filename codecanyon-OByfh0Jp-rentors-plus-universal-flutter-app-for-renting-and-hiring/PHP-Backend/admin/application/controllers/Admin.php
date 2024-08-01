<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends CI_Controller
{
  public $sidebar='common/sidebar.php';

    public function __construct()
    {
        parent::__construct();
        require_once APPPATH . "/third_party/FCMPushNotification.php";
        $this -> load -> library('session');
        $this -> load -> helper('form');
        $this -> load -> helper('url');
        $this -> load -> database();
        $this->load->library('csvimport');
        $this -> load -> library('form_validation');
        $this -> load -> model('Comman_model');
        $this -> load -> model('Api_model');
    }

    public function index()
    {
      redirect('index.php/Admin/home');
    }
    public function home()
    {
        if(isset($_SESSION['name'])) 
        { 
            $data['user']=$this->Api_model->getCountAll('users');
            /*$data['function']=$this->Api_model->getCountAll('category');
            $data['service_list']=$this->Api_model->getCountAll('sub_category');*/
           // $data['product']=$this->Api_model->getCountAll('products');

            $product=$this->Api_model->getAllDataLimit('products',3);

            $products= array();
            foreach ($product as $product) 
            {
              $getUser= $this->Api_model->getSingleRow('users',array('id'=>$product->user_id));
               if(!empty($getUser->name)){
               $product->userName= $getUser->name;
               }else{
                 $product->userName= "";
               }
               if(!empty($getUser->email)) {
                   $product->email= $getUser->email;
               }else{
                $product->email= "";
               }
              
              array_push($products, $product);
            }

           // $postrequest=$this->Api_model->getAllDataLimit('post_request',5);

           /* $postrequests= array();
            foreach ($postrequest as $postrequest) 
            {
               $getCategory= $this->Api_model->getSingleRow('category', array('id'=>$postrequest->category_id));
                $getSubCategory= $this->Api_model->getSingleRow('sub_category', array('id'=>$postrequest->sub_category_id));
              $getUser= $this->Api_model->getSingleRow('users', array('id'=>$postrequest->user_id));
              $postrequest->userName= @$getUser->name;
              $postrequest->email= @$getUser->email;
              $postrequest->categoryName= @$getCategory->name;
              $postrequest->subCategoryName= @$getSubCategory->name;
              array_push($postrequests, $postrequest);
            }*/

            $users= $this->Api_model->getAllData('users');
            if($users)
            {
              $data['monthly_user']=$this->Api_model->getMontlyUserCount();
            }
            else
            {
              $data['monthly_user']=array();
            }

            /*
            $data['active_user']=$this->Api_model->getCount('users',array('status'=>1));
            $data['deactive_user']=$this->Api_model->getCount('users',array('status'=>1));*/

            $data['products']=$products;
            $data['pending_product'] = $this->Api_model->get_pending_products();
            $data['total_pending_product'] = $this->Api_model->get_products_count('pending');
            $data['total_product'] = $this->Api_model->get_products_count('all');
            $data['total_confirm_product'] = $this->Api_model->get_products_count('confirm');

            $todays_subsription = $this->Api_model->getCount('user_subscription',array(DATE('start_date')=>date('Y-m-d')));

            $data['todays_subsription'] = (!empty($todays_subsription) ? $todays_subsription : '0'); 
            $data['pending_approval'] = $this->Api_model->getCountPendingProducts('pending');
            $data['today_feature'] = $this->Api_model->getCountPendingProducts('today_feature');
            $data['feature'] = $this->Api_model->getCountPendingProducts('feature');
            $data['today_product_new'] = $this->Api_model->getCountPendingProducts('today_product_new');
            $data['today_user_new'] = $this->Api_model->getTodaysUser();
            $data['subsribed_user'] = $this->Api_model->getSubscribedUser('user');
            $data['subsribed_user_expired'] = $this->Api_model->getExpiredSubscribedUsers('user_exp');
            $data['subsribed_user_count'] = $this->Api_model->getSubscribedUser('user_count');
           // echo $this->db->last_query();die;
            $data['product_booking_count'] = $this->Api_model->getBookedProduct('product_booking_count');
           // print_r($data['product_booking_count']);die;
            $data['product_booking'] = $this->Api_model->getBookedProduct('booking');
            $data['product_booking_expiry'] = $this->Api_model->getBookedProductExpiry();
            $data['complaints'] = $this->Api_model->getAllcmplaints('5');
            $data['today_complaints'] = $this->Api_model->getAllcmplaints('new');
            $data['week_revenue'] = $this->Api_model->get_revenue_data('week');
            $data['month_revenue'] = $this->Api_model->get_revenue_data('month');
            $data['year_revenue'] = $this->Api_model->get_revenue_data('year');
            $data['total_revenue'] = $this->Api_model->get_revenue_data('total');
            //echo $this->db->last_query();die;


            

            //echo "<pre>";print_r($data['subsribed_user']);die;
            //echo $this->db->last_query();die;


           // $data['total_subsription'] = $this->Api_model->get_user_subscription('all');
            //$data['active_subsription'] = $this->Api_model->get_user_subscription('active');
          //  echo $this->db->last_query();die;
            //echo "<pre>";print_r($data);die;
            //$data['postrequests']=$postrequests;
        
            $data['page']='home';
            $this -> load -> view('common/head.php');
            $this -> load -> view($this->sidebar, $data);
            $this -> load ->view('dashboard.php', $data);
            $this -> load -> view('common/footer.php');
        }
        else
        {
            redirect('');
        }
    }

    public function login()
    {
        $email= $this->input->post('email', TRUE);
        $password=$this->input->post('password', TRUE);
        $data['email']= $email;
        $data['password']= $password;
        $sess_array=array();
        $getdata=$this->Api_model->getSingleRow('admin',$data);
        if($getdata)
        {           
          if($getdata->status==1)
          {
            
            $this->session->unset_userdata($sess_array);
           // $last_login = $this->time_elapsed_string($getdata->last_login);
           $last_login = $this->time_elapsed_string(strtotime($getdata->last_login));
           // print($last_login);die;
            $sess_array = array(
             'name' => $getdata->name,
             'id' => $getdata->id,
             'last_login' => $last_login,
            );
            $this->session->set_userdata( $sess_array);
            $dataget['get_data'] =$getdata;
            $dataget['see_data'] =$sess_array;
            $where = array('id'=>$getdata->id);
            $data = array('last_login'=>date('Y-m-d H:i:s'));
            $update= $this->Api_model->updateSingleRow('admin', $where, $data);
            redirect('index.php/Admin');    
          }
          else
          {
            $this->session->set_flashdata('block', 'You action has been block. Contact to admin.');
            redirect('');
          }
        }
        else
        {
          $this->session->set_flashdata('msg', 'Please enter valid Username or Password');
          redirect('');
        }
    }


    function time_elapsed_string($time, $full = false) 
    {
    // Calculate difference between current 
    // time and given timestamp in seconds 
    $diff     = time() - $time; 
      //echo $diff;die;
    // Time difference in seconds 
    $sec     = $diff; 
      
    // Convert time difference in minutes 
    $min     = round($diff / 60 ); 
      
    // Convert time difference in hours 
    $hrs     = round($diff / 3600); 
      
    // Convert time difference in days 
    $days     = round($diff / 86400 ); 
      
    // Convert time difference in weeks 
    $weeks     = round($diff / 604800); 
      
    // Convert time difference in months 
    $mnths     = round($diff / 2600640 ); 
      
    // Convert time difference in years 
    $yrs     = round($diff / 31207680 ); 
      
    // Check for seconds 
    if($sec <= 60) { 
        $login =  "$sec seconds ago"; 
    } 
      
    // Check for minutes 
    else if($min <= 60) { 
        if($min==1) { 
            $login =  "one minute ago"; 
        } 
        else { 
            $login =  "$min minutes ago"; 
        } 
    } 
      
    // Check for hours 
    else if($hrs <= 24) { 
        if($hrs == 1) {  
            $login =  "an hour ago"; 
        } 
        else { 
            $login =  "$hrs hours ago"; 
        } 
    } 
      
    // Check for days 
    else if($days <= 7) { 
        if($days == 1) { 
            $login =  "Yesterday"; 
        } 
        else { 
            $login =  "$days days ago"; 
        } 
    } 
      
    // Check for weeks 
    else if($weeks <= 4.3) { 
        if($weeks == 1) { 
            $login = "a week ago"; 
        } 
        else { 
            $login = "$weeks weeks ago"; 
        } 
    } 
      
    // Check for months 
    else if($mnths <= 12) { 
        if($mnths == 1) { 
            $login = "a month ago"; 
        } 
        else { 
            $login = "$mnths months ago"; 
        } 
    } 
      
    // Check for years 
    else { 
        if($yrs == 1) { 
            $login = "one year ago"; 
        } 
        else { 
            $login = "$yrs years ago"; 
        } 
    } 
    return $login;
} 




    public function users()   
    {
      if(isset($_SESSION['name'])) 
      {
        $status = '';
        if(!empty($_GET) && !empty($_GET['status'])){
            $status = base64_decode($_GET['status']);
        }

        $user=$this->Api_model->getAllUserData('users',$status);
        $data['user']= $user;
        //echo "<pre>";print_r($user);die;
        $data['page']='users';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('users.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
          redirect('');
      }
    }
     public function userDetails()
    {
      if(isset($_SESSION['name'])) 
      {
        $id= $_GET['id'];
        $Class= $_GET['Class'];
        $userDetails = $this->Api_model->getUserAllDetails($id);
        
        $data['userDetails']= $userDetails;
        $data['ClassName']= $Class;
        $data['page']='users';
        //echo "<pre>";print_r($data);die;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('userDetails.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }
    }  


    public function change_status_user()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('users', $where, $data);
      //echo $this->db->last_query();die;
      redirect('index.php/Admin/users');      
    }

    public function change_verified_status_user(){

    if(!empty($_GET)){
      $page = $_GET['page'];
      $id= $_GET['id'];
      $status= $_GET['status'];
      $message = 'congratulation!! Your profile has been verified successfully.';
      $title = 'Profile verified';
    }else{
      $page = $this->input->post('page');
      $id = $this->input->post('userId');
       $message = 'Your Profile has been Rejected. <br/>';
      $message .= $this->input->post('message');
      $status = '2';
      $title = 'Profile Rejected';
    }

    $where = array('user_id'=>$id);
    $data = array('is_verified'=>$status);
    $update= $this->Api_model->updateSingleRow('user_profile', $where, $data);

    $user_id = $id;
    $title   = $title;
    $msg     = $message;

    $where = array('id' => $user_id);
    $userTokens = $this->Api_model->getAllDataWhereLimit('users',$where);
    if(!empty($userTokens) && !empty($userTokens[0]->device_token)){
      $device_token_array = explode(',', $userTokens[0]->device_token);
      $sendMsg = 'false';
      foreach($device_token_array as $device_token){
        $device_id = $device_token;
        $message = $msg;
        $myObj['Body'] = $message;
        $myObj['Type'] = 'Nofification';
        $push_msg = json_encode($myObj);
        $this->pushNotification($user,'user status change',$push_msg);
      }
    }
    if(!empty($page) && $page == 'details'){
      redirect('index.php/Admin/userDetails?id='.$user_id); 
    }else{
      redirect('index.php/Admin/users'); 
    }
    
  }

    public function add_category()
    {
     // print_r($_POST);die;
      $icon_value = $this->input->post('icon_value');
      $icon_old = $this->input->post('icon_old');
      $category_color = $this->input->post('category_color');



      //upload icon
      //unlink_path = $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/category/';
      $unlink_path = $this->config->item('upload_url');
      $unlink_path = $unlink_path.'category/';

      $url = str_replace("/admin","",base_url());
      $iconArray = $this->input->post('iconArray');
      $iconArray = explode(',',$iconArray);
      foreach ($iconArray as $arr) {
        if($arr != $icon_value){
          @unlink($unlink_path.$arr);
        }
      }
      if(empty($icon_old)  && empty($icon_value)){
         $icon_value = '';
      }
      else if(!empty($icon_old)  && empty($icon_value)){
         $icon_value = $url.'uploads/category/'.$icon_old;
      }else if(!empty($icon_old) && !empty($icon_value)){
       @unlink($unlink_path.$icon_old);
       $icon_value = $url.'uploads/category/'.$icon_value;
      }else{
        $icon_value = $url.'uploads/category/'.$icon_value;
      }
      //echo $icon_value;die;
      //upload image

      $imageArrayPush = $this->input->post('imageArrayPush');
      $imageArrayPushArray=array();
      if(!empty($imageArrayPush)){
        $imageArrayPush = explode(',', $imageArrayPush);
        foreach ($imageArrayPush as $img) {
          if(!empty($img)){
            $img_result['image'] = $url.'uploads/category/'.$img;
            array_push($imageArrayPushArray,$img_result);
          }
        }
        $imageArrayPushArray = json_encode($imageArrayPushArray);
        $data['category_image'] = $imageArrayPushArray;
      }else{
        $data['category_image'] = '';
      }
      $cat_id = '';
      $data['category_color'] = $category_color;
        if(isset($_GET) && !empty($_GET['id'])){
          $cat_id = $_GET['id'];
          if(!empty($_POST)){
            $where = array('id'=>$cat_id);
            $data['name']= $this->input->post('name', TRUE);
            $data['updated_at']=time();

            $data['category_icon'] = $icon_value;
 
            $update= $this->Api_model->updateSingleRow('category', $where, $data);
          }
        }else{
          $data['status'] = $this->input->post('cstatus');
          $data['category_icon'] = $icon_value;
          $data['name']= $this->input->post('name', TRUE);
          $data['created_at']=time();
          $data['updated_at']=time();
          $this->Api_model->insertGetId('category',$data);
          //echo $this->db->last_query();die;
        }
        redirect('index.php/Admin/category_list');
        
    }

public function test123(){
  $setting = $this->Api_model->getAllData('setting');
  if(!empty($setting)){
    echo $setting[0]->firebase_api_key;
  }
}

    public function putnotification()
    {




 /* $arrayVariable = [
    'title'  => 'sdfdsfds',
    'message' => 'test',
    'userId' => '110,111',
  ];
*/

        $id = explode(',', $_POST['userId']);
        $count = count($id);
       //print_r($id);die;
      $api_key= getenv('FIREBASE_KEY');
        /*$setting = $this->Api_model->getAllData('setting');
        if(!empty($setting)){
          $api_key = $setting[0]->firebase_api_key;
        }*/

        for ($i = 0; $i < $count; $i++) {
            $user_id = $id[$i];
            $title   = $_POST['title'];
            $msg     = $_POST['message'];
            if ($user_id != ''){
                /*$getToken     = $this->Api_model->getSingleRow('users_authentication', array(
                    'user_id' => $user_id
                ));
                echo $this->db->last_query;die;
                $device_token = $getToken->token;
                $this->firebase_with_class($device_token, '', '', $title, $msg);*/
                $where = array('id' => $user_id);
                $userTokens = $this->Api_model->getAllDataWhereLimit('users',$where);
                if(!empty($userTokens) && !empty($userTokens[0]->device_token)){
                   $device_token_array = explode(',', $userTokens[0]->device_token);
                   $sendMsg = 'false';
                   foreach($device_token_array as $device_token){

              $device_id = $device_token;
                      $message = $msg;
                     $myObj['Body'] = $message;
                $myObj['Type'] = 'Nofification';

                $push_msg = json_encode($myObj);


                      /*$device_id = "fzHd9G0wx_c:APA91bE8coIWjsxUFUeBqKdSASNAVNAQZsScaA4S4Jic8dkFwShZa4muVPkFWYt3JHVsiUVe7s_iJy4QY1AWIZBmnbtgkAiW21BP5SetaGfUn-2zpD2MS8PyhvN-CrzvmFgo1fv3Yj0j";*/

                      

                      //API URL of FCM
                      $url = 'https://fcm.googleapis.com/fcm/send';

                      /*api_key available in:
                      Firebase Console -> Project Settings -> CLOUD MESSAGING -> Server key*/    
                      $api_key = $api_key;
                      $msgobj = json_decode($push_msg);
                    $_body= $msgobj->Body;
                    $_type= $msgobj->Type;
                                  

          $dataa = array (
              "message" => $_body,
              "type" => $_type,
          );
                      $fields = array (
                          'registration_ids' => array (
                              $device_id
                          ),
                          'data' => $dataa
                      );

                      //header includes Content type and api key
                      $headers = array(
                          'Content-Type:application/json',
                          'Authorization:key='.$api_key
                      );
                                  
                      $ch = curl_init();
                      curl_setopt($ch, CURLOPT_URL, $url);
                      curl_setopt($ch, CURLOPT_POST, true);
                      curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                      curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
                      $result = curl_exec($ch);
                      if ($result === FALSE) {
                          die('FCM Send Error: ' . curl_error($ch));
                      }
                      curl_close($ch);
                      $result = json_decode($result,true);
                      //print_r($result);die;
                      $success = $result['success'];
                      if($success == 1){
                          $sendMsg = 'true';
                      }
                     }
                   if($sendMsg == 'true'){
                      $data['user_id']    = $user_id;
                      $data['title']      = $title;
                      $data['type']       = "10010";
                      $data['msg']        = $msg;
                      $data['created_at'] = time();
                      $this->Api_model->insert('notifications', $data);
                   }
                }

               
               
               




            }
        }
        redirect('index.php/Admin/notifaction');
    }

    public function notifaction()
    {
        $AllUsers = array();
        $users = $this->Api_model->getAllData('users');
        if(!empty($users)){
          foreach ($users as $value) {
            $dataDetails = $this->Api_model->getRenterRenteeDetails($value->id);
            if(!empty($dataDetails)){
              $type = 'Renter';
            }else{
              $type = 'Rentee';
            }
           // echo $type;die;
            $value->type = $type;
            array_push($AllUsers, $value);
          }
        }

         $data['type_action']='';
        $data['user']=$AllUsers;
        $data['page']='notification';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('notification.php', $data);
        $this -> load -> view('common/footer.php');
    }


    public function notifaction_type()
    {

        $status = '';
        if(!empty($_GET) && !empty($_GET['sstatus'])){
           $status = base64_decode($_GET['sstatus']);
        }
        $AllUsers = array();
        $users = $this->Api_model->getAllData('users');
        if(!empty($users)){
          foreach ($users as $value) {
            $dataDetails = $this->Api_model->getRenterRenteeDetails($value->id);
            if(!empty($dataDetails)){
              if($status == 'Renter'){
                  $type = 'Renter';
                  $value->type = $type;
                  array_push($AllUsers, $value);
              }
             
            }else{
                if($status == 'Rentee'){
                  $type = 'Rentee';
                  $value->type = $type;
                  array_push(
                  $AllUsers, $value);
                }

            }

            





           // echo $type;die;
           
          }
        }


        $data['user']=$AllUsers;
        $data['type_action']=$status;
        $data['page']='notification';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('notification.php', $data);
        $this -> load -> view('common/footer.php');
    }

    public function change_status_cat()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('category', $where, $data);
      //echo $this->db->last_query();die;
      redirect('index.php/Admin/category_list');      
    }

    public function change_status_subcat()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('sub_category', $where, $data);
      //echo $this->db->last_query();die;
      redirect('index.php/Admin/subcategory_list');      
    }

    public function category_list($id='')
    {
      $id = $this->uri->segment(3);
      if(isset($_SESSION['name'])) 
      {
        if(!empty($_GET['id']) && isset($_GET['id'])){
          $id  = $_GET['id'];
          $getCat  = $this->Api_model->getSingleRow('category', array(
             'id' => $id
          ));

         // echo $getCat->name;die;
          $data['cat_name'] = $getCat->name;
          $data['cats'] = $getCat;

        }

        $status = '';
        if(!empty($_GET) && !empty($_GET['cstatus'])){
            $status = base64_decode($_GET['cstatus']);
            $category= $this->Api_model->getAllDataWhereLimit('category',array('status'=>$status));
        }else{
           $category= $this->Api_model->getAllData('category');
        }

      
     
        $data['category']= $category;
        $data['page']='category_list';
        $data['cat_id'] = $id;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('category.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }
    }

     public function product_list()
    {   

         $status = '';
        if(!empty($_GET) && !empty($_GET['status'])){
            $status = base64_decode($_GET['status']);
            $where = array('status'=>$status,'is_delete'=>'0');
        }else{
           $subcategory= $this->Api_model->getAllData('sub_category');
           $where = array('is_delete'=>'0');
        }


        $data['product']=  $this->Api_model->getAllDataProduct($where,'products');
        $data['page']='product_list';
       // echo "<pre>";print_r($data);die;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('product.php', $data);
        $this -> load -> view('common/footer.php');
    }

    public function change_status_product()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('products', $where, $data);
      redirect('index.php/Admin/product_list');      
    }
    public function change_approved_status(){
      //print_r($_GET);die;
      $id= $_GET['id'];
      $status= $_GET['status'];
      $user= $_GET['user'];
      if($status == 2){
        $pstatus = 0;
        $pmsg = "Your Product is Unpublished now";
      }else{
        $pstatus = 1;
        $pmsg = "Your Product is Published now";
      }
      $details= @$_GET['details'];
      $where = array('id'=>$id);
      $data = array('is_approved'=>$status,'status' =>$pstatus);
      $update= $this->Api_model->updateSingleRow('products', $where, $data);
      if(!empty($user)){
          $myObj['Body'] = $pmsg;
          $myObj['Type'] = 'Nofification';
          $push_msg = json_encode($myObj);
          $this->pushNotification($user,'product status change',$push_msg);
      }
      if($details == 1){
        redirect('index.php/Admin/productDetails?id='.$id);
      }else{
        redirect('index.php/Admin/product_list');
      }
      
    }


     public function pushNotification($id,$title,$message){
          $success = '';
          $api_key= '';
          $setting = $this->Api_model->getAllData('setting');
          if(!empty($setting)){
            $api_key = $setting[0]->firebase_api_key;
          }
          $api_key = getenv('FIREBASE_KEY');
          $_thread_id = '';
          $user_id = $id;
          $title   = $title;
          $msg     = $message;
      $msgobj = json_decode($msg);
      $_body= $msgobj->Body;
      $_type= $msgobj->Type;
      if(!empty($msgobj->Thread_id)){
         $_thread_id= $msgobj->Thread_id;
         $dataa = array (
            "message" => $_body,
            "type" => $_type,
            "thread_id" => $_thread_id
        );
      }else{
          $dataa = array (
              "message" => $_body,
              "type" => $_type,
          );
      }
     
      
          if ($user_id != ''){
            $where = array('id' => $user_id);
            $userTokens = $this->Api_model->getAllDataWhere($where,'users');
           // print_r($userTokens);die;
            if(!empty($userTokens) && !empty($userTokens[0]->device_token)){
              $device_token_array = explode(',', $userTokens[0]->device_token);
              $sendMsg = 'false';
              foreach($device_token_array as $device_token){
                $device_id = $device_token;
                $url = 'https://fcm.googleapis.com/fcm/send';
                /*api_key available in:
                Firebase Console -> Project Settings -> CLOUD MESSAGING -> Server key*/    
                $api_key = $api_key;
                $fields = array (
                'registration_ids' => array (
                        $device_id
                ),
                'data' => $dataa
                );
               

                //header includes Content type and api key
                $headers = array(
                'Content-Type:application/json',
                'Authorization:key='.$api_key
                );
                        
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
                $result = curl_exec($ch);
                if ($result === FALSE) {
                  die('FCM Send Error: ' . curl_error($ch));
                }
                curl_close($ch);
                $result = json_decode($result,true);
                $success = $result['success'];
                if($success == 1){
                 $sendMsg = 'true';
                }
              }
              if($sendMsg == 'true' && $_type!= 'Chat'){
              $data['user_id']    = $user_id;
              $data['title']      = $title;
              $data['type']       = $_type;
              $data['msg']        = $_body;
              $data['created_at'] = date('Y-m-d h:i:s');
              $this->db->insert('notifications',$data);
              
              }
            }
          }
          return $success; 
        }


    public function productDetails()
    {
      if(isset($_SESSION['name'])) 
      {
        $id= $_GET['id'];

        $productDetail= $this->Api_model->getSingleRow('products', array('id'=>$id));
        $data['wishlist']=$this->Api_model->getCount('wish_list', array('product_id'=>$id));

        

        $getGuest=  $this->Api_model->getAllDataWhere(array('product_id'=>$id), 'wish_list');

        $getGuests= array();

        foreach ($getGuest as $getGuest) 
        {
          $getUser= $this->Api_model->getSingleRow('users', array('id'=>$getGuest->user_id));
          if($getUser)
          {
            if($getUser->email)
            {
              $getUser->userName= $getUser->email;
            }
            else
            {
              $getUser->userName= "";
            }
            $getUser->prodcut= $getGuest->product_id;
          }
          array_push($getGuests, $getUser);
        }


       /* $getPost=  $this->Api_model->getAllDataWhere(array('user_id'=>$productDetail->user_id), 'post_request');
        $getPosts= array();

        foreach ($getPost as $getPost) 
        {
          $getUser= $this->Api_model->getSingleRow('users', array('id'=>$getPost->user_id));
        
          $getPost->user_name= $getUser->email;

          $getPost->comments= $this->Api_model->getCountWhere('review', array('product_id'=>$getPost->id));
          $getPost->likes= $this->Api_model->getCountWhere('like_product', array('product_id'=>$getPost->id));
          array_push($getPosts, $getPost);
        }

        $data['getPosts']= $getPosts;*/
        $data['productDetails']= $productDetail;
        $data['getGuests']= $getGuests;
       
        $data['page']='functions_list';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('productDetails.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }
    }     

    public function subcategory_list(){
      if (isset($_SESSION['name'])) {
        $sub_cat_id = '';
        $getSubCat = '';
        if(isset($_GET) && !empty($_GET['id'])){
          $sub_cat_id = $_GET['id'];
            $getSubCat  = $this->Api_model->getSingleRow('sub_category', array(
                'id' => $sub_cat_id
            ));
            
        }
        $data['sub_cat_data'] = $getSubCat;
        $status = '';
        if(!empty($_GET) && !empty($_GET['cstatus'])){
            $status = base64_decode($_GET['cstatus']);
            $subcategory= $this->Api_model->getAllDataWhereLimit('sub_category',array('status'=>$status));
        }else{
           $subcategory= $this->Api_model->getAllData('sub_category');
        }



        //$subcategory =  $this->Api_model->getAllData('sub_category');
        $data['category_id']  = $this->Api_model->getAllData('category');
        $subcategorys = array();
        foreach ($subcategory as $subcategory){
          $category=$this->Api_model->getSingleRow('category', array('id'=>$subcategory->category_id));
          $subcategory->categoryName= $category->name;
          if(!empty($subcategory->form_field)){
              $form_field = json_decode($subcategory->form_field);
              $form_field_value = array();
              foreach ($form_field as  $value) {
                $value = $value->lable;
                $form_field_value[] =$value;
              }
              $form_field_valuee= implode(',', $form_field_value);
              $form_fields = $form_field_valuee;
              $subcategory->fome_field_val= $form_fields;
          }
          array_push($subcategorys, $subcategory);
        }
        $data['subcategory']=$subcategorys;
        $data['page']='subcategory';
        $this->load->view('common/head.php');
        $this->load->view('common/sidebar.php', $data);
        $this->load->view('subcategory.php', $data);
        $this->load->view('common/footer.php');
      }else{

      }
    }

    public function add_subcategory(){
      if (isset($_SESSION['name'])) {
        $this->form_validation->set_rules('name', 'Name', 'required');
        $this->form_validation->set_rules('category_id', 'Category Name ', 'required');
        if($this->form_validation->run() != FALSE) {

        $icon_value = $this->input->post('icon_value');
        $icon_old = $this->input->post('icon_old');


        //upload icon
       // $unlink_path = $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/subcategory/';
        $unlink_path = $this->config->item('upload_url');
        $unlink_path = $unlink_path.'subcategory/';
        $url = str_replace("/admin","",base_url());
        $iconArray = $this->input->post('iconArray');
        $iconArray = explode(',',$iconArray);
        foreach ($iconArray as $arr) {
          if($arr != $icon_value){
            @unlink($unlink_path.$arr);
          }
        }

        if(!empty($icon_old)  && empty($icon_value)){
           $icon_value = $url.'uploads/subcategory/'.$icon_old;
        }else if(!empty($icon_old) && !empty($icon_value)){
         @unlink($unlink_path.$icon_old);
         $icon_value = $url.'uploads/subcategory/'.$icon_value;
        }else{
          $icon_value = $url.'uploads/subcategory/'.$icon_value;
        }
//echo  $icon_value;die;
        //upload image
        $imageArrayPush = $this->input->post('imageArrayPush');
        $imageArrayPushArray=array();
        if(!empty($imageArrayPush)){
          $imageArrayPush = explode(',', $imageArrayPush);
          foreach ($imageArrayPush as $img) {
            if(!empty($img)){
              $img_result['image'] = $url.'uploads/subcategory/'.$img;
              array_push($imageArrayPushArray,$img_result);
            }
          }
          $imageArrayPushArray = json_encode($imageArrayPushArray);
          $data['sub_cat_image'] = $imageArrayPushArray;
        }else{
          $data['sub_cat_image'] = '';
        }

        $data['sub_cat_icon'] = $icon_value;
         $data['status'] = $this->input->post('cstatus');

         $varification = $this->input->post('varified');
         if($varification ==1){
            $varified = 1;
         }else{
          $varified = 0;
         }


          $sub_cat_id = '';
          if(isset($_GET) && !empty($_GET['id'])){
            $sub_cat_id = $_GET['id'];
            if(!empty($_POST)){
              $where = array('id'=>$sub_cat_id);
              $formfield = $this->input->post('formfield');
              $form_field_array=array();
              if(!empty($formfield)){
                foreach ($formfield as $field) {
                  if(!empty($field)){
                    $field_result['lable'] = $field;
                    array_push($form_field_array,$field_result);
                  }
                }
                $form_field_array = json_encode($form_field_array);
                $data['form_field'] = $form_field_array;
              }else{
                $data['form_field'] = '[]';
              }
              $data['name']            = $this->input->post('name');
              $data['category_id']     = $this->input->post('category_id');
              $data['verification_required'] = $varified;
              $data['updated_at']      = time();
              $update= $this->Api_model->updateSingleRow('sub_category', $where, $data);
            }
          }else{
            $formfield = $this->input->post('formfield');
            $form_field_array=array();
            if(!empty($formfield)){
              foreach ($formfield as $field) {
                if(!empty($field)){
                  $field_result['lable'] = $field;
                  array_push($form_field_array,$field_result);
                }
              }
              $form_field_array = json_encode($form_field_array);
              $data['form_field'] = $form_field_array;
            }else{
              $data['form_field'] = '[]';
            }
            $data['name']            = $this->input->post('name');
            $data['category_id']     = $this->input->post('category_id');
            $data['verification_required'] = $varified;
            $data['created_at']      = time();
            $data['updated_at']      = time();
            //echo "<pre>";print_r($data);die;
            $this->Api_model->insert('sub_category', $data);

          }
        }
        redirect('index.php/Admin/subcategory_list/');
      }
    }


    public function add_subcategoryyy()
    {
        if (isset($_SESSION['name'])) {
          $sub_cat_id = '';
          if(isset($_GET) && !empty($_GET['id'])){
            $sub_cat_id = $_GET['id'];
              if(!empty($_POST)){
                $where = array('id'=>$isub_cat_id);
                $data['name']= $this->input->post('name', TRUE);
                $data['updated_at']=time();
                $update= $this->Api_model->updateSingleRow('category', $where, $data);
              }else{
                $getSubCat  = $this->Api_model->getSingleRow('sub_category', array(
                  'id' => $sub_cat_id
                ));
                $data['sub_cat_data'] = $getSubCat;
              }
          }else{
            $this->form_validation->set_rules('name', 'Name', 'required');
            $this->form_validation->set_rules('category_id', 'Category Name ', 'required');
            if ($this->form_validation->run() == FALSE) {
              $subcategory =  $this->Api_model->getAllData('sub_category');
              $data['category_id']  = $this->Api_model->getAllData('category');
              $subcategorys = array();
              foreach ($subcategory as $subcategory) 
              {
                $category=$this->Api_model->getSingleRow('category', array('id'=>$subcategory->category_id));
                $subcategory->categoryName= $category->name;
                if(!empty($subcategory->form_field)){
                    $form_field = json_decode($subcategory->form_field);
                    $form_field_value = array();
                    foreach ($form_field as  $value) {
                      $value = $value->lable;
                      $form_field_value[] =$value;
                    }
                    $form_field_valuee= implode(',', $form_field_value);
                    $form_fields = $form_field_valuee;
                    $subcategory->fome_field_val= $form_fields;

                    //array_push($subcategory,$data['form_fields']);
                    //print_r($form_field_valuee);die;;
                }
                array_push($subcategorys, $subcategory);

              }
              $data['subcategory']=$subcategorys;
              $data['page']='subcategory';
                $this->load->view('common/head.php');
                $this->load->view('common/sidebar.php', $data);
                $this->load->view('subcategory.php', $data);
                $this->load->view('common/footer.php');
            } else {
                $formfield = $this->input->post('formfield');
                $form_field_array=array();
                if(!empty($formfield)){
                  foreach ($formfield as $field) {
                    //print_r();die;
                      $field_result['lable'] = $field;
                      array_push($form_field_array,$field_result);

                   }
                   $form_field_array = json_encode($form_field_array);
                   $data['form_field'] = $form_field_array;
              }else{
                $data['form_field'] = $form_field_array;
              }

                $data['name']            = $this->input->post('name');
                $data['category_id']     = $this->input->post('category_id');
                //$data['form_field']     = $form_field_array;
                $data['created_at']      = time();
                $data['updated_at']      = time();
                $id = $this->Api_model->insert('sub_category', $data);

                /* foreach ($formfield as $field){
                  $datasub['sub_cat_id']     = $id;
                  $datasub['form_field']     = $field;
                  $datasub['created_at']      = time();
                  $datasub['updated_at']      = time();
                  $this->Api_model->insert('sub_cat_form_fields', $datasub);
                  
               }*/
                redirect('index.php/Admin/add_subcategory');
            }
          }
 

        } else {
            redirect();
        }
    } 

     public function post_request()
    {
        $postData = $this->Api_model->getAllData('post_request');
        $postDatas=array();
        foreach ($postData as $postData) 
        {
          $user=$this->Api_model->getSingleRow('users', array('id'=>$postData->user_id));
          $category=$this->Api_model->getSingleRow('category', array('id'=>$postData->category_id));
          $subcategory=$this->Api_model->getSingleRow('sub_category', array('id'=>$postData->sub_category_id));
          $postData->userName= $user->name;
          $postData->categoryName= $category->name;
          $postData->subcategoryName= $subcategory->name;
          array_push($postDatas, $postData);
        }
        $data['page']='postData';
        $data['postData']=$postDatas;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('postRequest.php', $data);
        $this -> load -> view('common/footer.php');
    }

      public function change_status_postrequest()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('post_request', $where, $data);
      redirect('index.php/Admin/post_request');      
    }

     public function wish_list()
    {
        $wishdata = $this->Api_model->getAllData('wish_list');
        $wishdatas=array();
        foreach ($wishdata as $wishdata) 
        {
          $product=$this->Api_model->getSingleRow('products', array('id'=>$wishdata->product_id));
          $user=$this->Api_model->getSingleRow('users', array('id'=>$wishdata->user_id));
          $wishdata->productName= '';
          if(!empty($product)){
             $wishdata->productName= $product->name;
          }
          if ($user->name) {
          $wishdata->userName= $user->name;
          }else{
          $wishdata->userName= $user->email;
        }
          array_push($wishdatas, $wishdata);
        }
        $data['page']='wishdata';
        $data['wishdata']=$wishdatas;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('wishlist.php', $data);
        $this -> load -> view('common/footer.php');
    }

    public function change_status_wishlist()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $request= $_GET['request'];
      $where = array('id'=>$id);
      if($request == 3){
          $this->Api_model->deleteRecord($where,'wish_list');
      }else{
        $data = array('status'=>$status);
        $update= $this->Api_model->updateSingleRow('wish_list', $where, $data);
      }
      redirect('index.php/Admin/wish_list');      
    }

    public function logout()
    {
      $this->session->sess_destroy();         
        redirect('index.php/Admin/login', 'refresh');
    }

    //add icon or category and subcategory
    public function add_icon(){
      $filename = uniqid().$_FILES['icon']['name'];
      $this->load->helper('directory');
      $error_msg = '';
     // $path = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/category/";
      $upload_url = $this->config->item('upload_url');
      $path = $upload_url.'category/';
      $config['upload_path'] = $path;
      $config['allowed_types'] = 'JPG|jpg|JPEG|jpeg|PNG|png';
      $config['file_name'] = $filename;
      $config['max_size'] = '0';
      $config['max_width']  = '0';
      $config['max_height']  = '0';
      $this->load->library('image_lib', $config);
      $this->load->library('upload', $config);
      $this->upload->initialize($config);
      $url = str_replace("/admin","",base_url());
      if($this->upload->do_upload('icon')){
        $success = true;
        $response = $url.'uploads/category/'.$filename;
        $imageName = $filename;
      }else{
        $success = false;
        $response = array('error' => $this->upload->display_errors());
        $error_msg = strip_tags($response['error']);
        $imageName = '';
      }

      echo json_encode(array(
            'success' => $success,
            'response' => $response,
            'imageName' => $filename,
            'errorMessage' => $error_msg
        ));

    }


    //add subcat icon
    public function add_icon_sub(){
      $filename = uniqid().$_FILES['icon']['name'];
      $error_msg = '';
      $this->load->helper('directory');
      $upload_url = $this->config->item('upload_url');
      $path = $upload_url.'subcategory/';


     // $path = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/subcategory/";
      $config['upload_path'] = $path;
      $config['allowed_types'] = 'JPG|jpg|JPEG|jpeg|PNG|png';
      $config['file_name'] = $filename;
      $config['max_size'] = '0';
      $config['max_width']  = '0';
      $config['max_height']  = '0';
      $this->load->library('image_lib', $config);
      $this->load->library('upload', $config);
      $this->upload->initialize($config);
      $url = str_replace("/admin","",base_url());
      if($this->upload->do_upload('icon')){
        $success = true;
        $response = $url.'uploads/subcategory/'.$filename;
        $imageName = $filename;
      }else{
        $success = false;
        $response = array('error' => $this->upload->display_errors());
        $error_msg = strip_tags($response['error']);
        $imageName = '';
      }

      echo json_encode(array(
            'success' => $success,
            'response' => $response,
            'imageName' => $filename,
            'errorMessage' => $error_msg,
        ));

    }
    //add multiple images
    public function add_multiple_image(){
      $number_of_files_uploaded = count($_FILES['images']['name']);
      $this->load->library('upload');//loading the library
      //upload folder url
      //$path = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/category";
     // echo $path. ' ---- ';
      $error_msg = '';
      $upload_url = $this->config->item('upload_url');
      $path = $upload_url.'category';
      //echo $path;die;

      $url = str_replace("/admin","",base_url());
      $imageName = array();
      $images = array();
      $count = 0;
      for ($i = 0; $i <  $number_of_files_uploaded; $i++) {
          $_FILES['userfile']['name']     = $_FILES['images']['name'][$i];
          $_FILES['userfile']['type']     = $_FILES['images']['type'][$i];
          $_FILES['userfile']['tmp_name'] = $_FILES['images']['tmp_name'][$i];
          $_FILES['userfile']['error']    = $_FILES['images']['error'][$i];
          $_FILES['userfile']['size']     = $_FILES['images']['size'][$i];
          //configuration for un npload your images
          $config = array(
              'file_name'     => time(),
              'allowed_types' => 'jpg|jpeg|png|gif|jfif',
              'max_size'      => 3000,
              'overwrite'     => FALSE,
              'upload_path'
              =>$path
          );
          $this->upload->initialize($config);
          $errCount = 0;//counting errrs
          if (!$this->upload->do_upload())
          {
            $error = array('error' => $this->upload->display_errors());
            $response = array('error' => $this->upload->display_errors());
           $error_msg = strip_tags($response['error']);
              $success = false;
          }
          else
          {
              $filename = $this->upload->data();
              $images[] = array(
                  'fileName'=>$url.'uploads/category/'.$filename['file_name']
              );
              $imageName[] = $filename['file_name'];

              $success = true;
              $count = $i+1;
          }//if file uploaded
          
      }//for loop ends here
      //print_r($carImages);die;
      //echo json_encode($images);
      echo json_encode(array(
            'success' => $success,
            'response' => $images,
            'count' => $count,
            'imageName' =>$imageName,
            'errorMessage' => $error_msg,
        ));//sending the data to the jquery/ajax or you can save the files name inside your database.
    
    }

    public function remove_image(){
      $img = $this->input->post('path');
      $upload_url = $this->config->item('upload_url');
      $unlink_path = $upload_url.'category/'.$img;
      echo $unlink_path;
     // $unlink_path = $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/category/'.$img;
      var_dump(@unlink($unlink_path.$arr));die;
    }

    public function remove_image_subcat(){
      $img = $this->input->post('path');
      //$unlink_path = $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/subcategory/'.$img;
      $upload_url = $this->config->item('upload_url');
      $unlink_path = $upload_url.'subcategory/'.$img;
      @unlink($unlink_path.$arr);
    }


    public function add_multiple_image_subcat(){
      $error_msg = '';
        $number_of_files_uploaded = count($_FILES['images']['name']);
        $this->load->library('upload');//loading the library
       // $path = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/subcategory";
        $upload_url = $this->config->item('upload_url');
       $path = $upload_url.'subcategory';
        $url = str_replace("/admin","",base_url());
        $imageName = array();
        $images = array();
        $count = 0;
        for ($i = 0; $i <  $number_of_files_uploaded; $i++) {
          $_FILES['userfile']['name']     = $_FILES['images']['name'][$i];
          $_FILES['userfile']['type']     = $_FILES['images']['type'][$i];
          $_FILES['userfile']['tmp_name'] = $_FILES['images']['tmp_name'][$i];
          $_FILES['userfile']['error']    = $_FILES['images']['error'][$i];
          $_FILES['userfile']['size']     = $_FILES['images']['size'][$i];
          //configuration for un npload your images
          $config = array(
              'file_name'     => time(),
              'allowed_types' => 'jpg|jpeg|png|gif',
              'max_size'      => 3000,
              'overwrite'     => FALSE,
              'upload_path'
              =>$path
          );
          $this->upload->initialize($config);
          $errCount = 0;//counting errrs
          if (!$this->upload->do_upload())
          {
            $response = array('error' => $this->upload->display_errors());
        $error_msg = strip_tags($response['error']);
              $success = false;
          }
          else
          {
              $filename = $this->upload->data();
              $images[] = array(
                  'fileName'=>$url.'uploads/subcategory/'.$filename['file_name']
              );
              $imageName[] = $filename['file_name'];

              $success = true;
              $count = $i+1;
          }//if file uploaded
          
      }//for loop ends here
      //print_r($carImages);die;
      //echo json_encode($images);
      echo json_encode(array(
            'success' => $success,
            'response' => $images,
            'count' => $count,
            'imageName' =>$imageName,
            'errorMessage' => $error_msg
        ));//sending the data to the jquery/ajax or you can save the files name inside your database.
    
    }

    public function Subscription($id = ''){
      $id = $this->uri->segment(3);
      if(isset($_SESSION['name'])) 
      {
        if(isset($_GET) && !empty($_GET['id'])){
          $where = array('subscription.id'=>$_GET['id']);
          $subscribe_data= $this->Api_model->get_subcription($where);
          $data['subscribe_data'] = $subscribe_data;
          $data['id']  = $_GET['id'];
        }
        $subscription= $this->Api_model->get_subcription(array('subscription.type'=>'normal'));
        $data['subscription']= $subscription;
        //print_r($data);die;
       // echo "dfdsfdsf";die;
        $subscription_period = $this->Api_model->getAllData('subscription_period');

        $user_subscription = $this->Api_model->getUserSubscription('normal');
      //  echo "<pre>";print_r($user_subscription);die;
        $data['status_url'] = 'Subscription';
        $data['plan_periods'] = $subscription_period;
        $data['user_subscription'] = $user_subscription;
        $data['page']='subscription_list';
        $data['type'] = 'normal';
        //$data['cat_id'] = $id;
      // echo "<pre>";print_r($data);die;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('subscription.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }
    }


    public function feature_subscription($id = ''){
      $id = $this->uri->segment(3);
      if(isset($_SESSION['name'])) 
      {
        if(isset($_GET) && !empty($_GET['id'])){
          $where = array('subscription.id'=>$_GET['id']);
          $subscribe_data= $this->Api_model->get_subcription($where);
          $data['subscribe_data'] = $subscribe_data;
          $data['id']  = $_GET['id'];
        }
        $subscription= $this->Api_model->get_subcription(array('subscription.type'=>'feature'));
        $data['subscription']= $subscription;
        //print_r($data);die;
       // echo "dfdsfdsf";die;
        $subscription_period = $this->Api_model->getAllData('subscription_period');

        $user_subscription = $this->Api_model->getUserSubscription('feature');
      //  echo "<pre>";print_r($user_subscription);die;
        $data['status_url'] = 'feature_subscription';
        $data['plan_periods'] = $subscription_period;
        $data['user_subscription'] = $user_subscription;
        $data['page']='subscription_list';
        $data['type'] = 'feature';
        //$data['cat_id'] = $id;
      // echo "<pre>";print_r($data);die;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('feature_subscription.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }
    }

    public function add_subscription($id = 0){
      if (isset($_SESSION['name'])) {
        if(isset($_GET) && !empty($_GET['id'])){
           $id = $_GET['id'];
            if(!empty($_POST)){
              $type = $this->input->post('type');
              $where = array('id'=>$id);
              //$data['status'] = $this->input->post('status');
              $data['title'] = $this->input->post('plan_name');
              $data['period']= $this->input->post('period');
              $data['price']= $this->input->post('price');
              $data['no_of_products']= $this->input->post('no_of_products');

              //$data['description']= $this->input->post('description');
              $data['currency_type']= $this->input->post('currency_type');
              $data['type']= $type;
              $data['updated_at']=time();
               //print_r($data);die;
              $update= $this->Api_model->updateSingleRow('subscription', $where, $data);
            }
          }else{
            $type = $this->input->post('type');
           // $data['status'] = $this->input->post('status');
             $data['title'] = $this->input->post('plan_name');
            $data['period']= $this->input->post('period');
            $data['price']= $this->input->post('price');
             $data['no_of_products']= $this->input->post('no_of_products');
            //$data['description']= $this->input->post('description');
            $data['currency_type']= $this->input->post('currency_type');
             $data['type']= $type;
            $data['created_at']=time();
            $data['updated_at']=time();
            $this->Api_model->insertGetId('subscription',$data);
            //echo $this->db->last_query();die;
          }
        }
        if($type == 'feature'){
          redirect('index.php/Admin/feature_subscription');
        }else{
          redirect('index.php/Admin/subscription');
        }
        
    }

      public function change_status_subscription()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('subscription', $where, $data);
      //echo $this->db->last_query();die;
      redirect('index.php/Admin/Subscription');      
    }


    public function city_list($id = 0){

      if(isset($_SESSION['name'])) {
        if(isset($_GET) && !empty($_GET['id'])){
          $id = $_GET['id'];
          $where = array('subscription.id'=>$_GET['id']);
          $city_data= $this->Api_model->getSingleRow('city', array(
             'id' => $id
          ));
          $data['city_data'] = $city_data;
          $data['id']  = $_GET['id'];
        }
        $status = '';
        if(!empty($_GET) && !empty($_GET['cstatus'])){
            $status = base64_decode($_GET['cstatus']);
            $city= $this->Api_model->getAllDataWhereLimit('city',array('status'=>$status));
        }else{
           $city= $this->Api_model->getAllData('city');
        }




       // $city = $this->Api_model->getAllData('city');
        $data['city'] = $city;
        $data['id'] = $id;
        //echo "<pre>";print_r($data);die;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('city.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }

    }

    public function add_city($id = 0){
      if (isset($_SESSION['name'])) {
        //echo $_GET['id'];
        if(isset($_GET) && !empty($_GET['id'])){
           $id = $_GET['id'];
            if(!empty($_POST)){
              $where = array('id'=>$id);
              
              $data['city_name']= $this->input->post('city_name');
              $data['updated_at']=time();
              // print_r($data);die;
              $update= $this->Api_model->updateSingleRow('city', $where, $data);
            }
          }else{
            $data['city_name'] = $this->input->post('city_name');
            
            $data['created_at']=time();
            $data['updated_at']=time();
            $data['status']=1;
            $this->Api_model->insertGetId('city',$data);
          }
        }
        redirect('index.php/Admin/city_list');
    }
    public function change_status_city()
    {
      $id= $_GET['id'];
      $status= $_GET['status'];
      $where = array('id'=>$id);
      $data = array('status'=>$status);
      $update= $this->Api_model->updateSingleRow('city', $where, $data);
      //echo $this->db->last_query();die;
      redirect('index.php/Admin/city_list');      
    }

    public function test(){
      $product = $this->Api_model->getAllData('products');
      foreach($product as $pr){
        $pId = 'R'.rand(0,9).rand(0,9).rand(0,9).rand(0,9).rand(0,9);
        $where = array('id'=>$pr->id);
              
              $data['product_id']= $pId;
              $update= $this->Api_model->updateSingleRow('products', $where, $data);
        
      }
    }


    //home slider

    public function home_slider(){
      $data['slider'] = 'slider';
//$dir =  $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/home/';
       $upload_url = $this->config->item('upload_url');
        $dir = $upload_url.'home/';
      $sliderImage = [];
      if (is_dir($dir)) {
        if ($dh = opendir($dir)) {
            while (($file = readdir($dh)) !== false) {
              if($file == '.' || $file == '..'){
              }else{
                $sliderImage[] = $file;
              }
              }
            }
            closedir($dh);
        }
      $data['sliderImage'] = $sliderImage;
      $this -> load -> view('common/head.php');
      $this -> load -> view($this->sidebar, $data);
      $this -> load ->view('slider.php', $data);
      $this -> load -> view('common/footer.php');
    }
    public function remove_image_homeslider(){
      $img = $this->input->post('path');
      $id = substr($img, strrpos($img, '/') + 1);
      //$unlink_path = $_SERVER["DOCUMENT_ROOT"].'/rental/rentors/uploads/home/'.$img;
      $upload_url = $this->config->item('upload_url');
      $unlink_path = $upload_url.'home/'.$id;
      @unlink($unlink_path.$arr);
    }


    public function add_multiple_image_homeslider(){
        $number_of_files_uploaded = count($_FILES['images']['name']);
        $this->load->library('upload');//loading the library
      //  $path = $_SERVER['DOCUMENT_ROOT']."/rental/rentors/uploads/home";
        $error_msg = '';
         $upload_url = $this->config->item('upload_url');
        $path = $upload_url.'home/';


        $url = str_replace("/admin","",base_url());
        $imageName = array();
        $images = array();
        $count = 0;
        for ($i = 0; $i <  $number_of_files_uploaded; $i++) {
          $_FILES['userfile']['name']     = $_FILES['images']['name'][$i];
          $_FILES['userfile']['type']     = $_FILES['images']['type'][$i];
          $_FILES['userfile']['tmp_name'] = $_FILES['images']['tmp_name'][$i];
          $_FILES['userfile']['error']    = $_FILES['images']['error'][$i];
          $_FILES['userfile']['size']     = $_FILES['images']['size'][$i];
          //configuration for un npload your images
          $config = array(
              'file_name'     => time(),
              'allowed_types' => 'jpg|jpeg|png|gif',
              'max_size'      => 3000,
              'overwrite'     => FALSE,
              'upload_path'
              =>$path
          );
          $this->upload->initialize($config);
          $errCount = 0;//counting errrs
          if (!$this->upload->do_upload())
          {
            $response = array('error' => $this->upload->display_errors());
        $error_msg = strip_tags($response['error']);
              $success = false;
          }
          else
          {
              $filename = $this->upload->data();
              $images[] = array(
                  'fileName'=>$url.'uploads/home/'.$filename['file_name']
              );
              $imageName[] = $filename['file_name'];

              $success = true;
              $count = $i+1;
          }//if file uploaded
          
      }//for loop ends here
      //print_r($carImages);die;
      //echo json_encode($images);
      echo json_encode(array(
            'success' => $success,
            'response' => $images,
            'count' => $count,
            'imageName' =>$imageName,
            'errorMessage' =>$error_msg,
        ));//sending the data to the jquery/ajax or you can save the files name inside your database.
    
    }

    public function setting(){

      if(isset($_SESSION['name'])) {
        $setting = $this->Api_model->getAllData('setting');
        if(!empty($setting)){
          $setting = $setting[0];
        }
        $data['setting'] = $setting;
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('setting.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else
      {
        redirect('');
      }

    }
    public function add_setting(){
      if (isset($_SESSION['name'])) {
        $data['firebase_api_key']= $this->input->post('firebase');
        $data['stripe_api_key']= $this->input->post('stripe');

        $data['sendgrid_email']= $this->input->post('sendgrid_email');
        $data['sendgrid_key']= $this->input->post('sendgrid_key');
       /* $data['smtp_user']= $this->input->post('smtp_user');
        $data['smtp_pass']= $this->input->post('smtp_pass');*/
        
        $id= $this->input->post('id');
        $data['updated_at']=time();
        $where = array('id'=>$id);
        $update= $this->Api_model->updateSingleRow('setting', $where, $data);
      }
      redirect('index.php/Admin/setting');
    }

    public function pay_subscription_log(){
      if(isset($_SESSION['name'])){
        $paylog=$this->Api_model->getAllPaySubsriptionData('pay_subscription_log');
        $data['paylog']= $paylog;
        $data['page']='users';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('paylog.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else{
          redirect('');
      }
    }

    public function product_booking_list(){
      if(isset($_SESSION['name'])){
         $status = '';
         $where = '';
        if(!empty($_GET) && !empty($_GET['status'])){
            $status = base64_decode($_GET['status']);
           
        }
        $bookingUSer=$this->Api_model->booking_requested_user($status);
        $bookingProduct = array();
        if(!empty($bookingUSer)){
           foreach ($bookingUSer as $value) {
              $book = $value;
              $puser = $this->Api_model->getProductOwnerInfo($value['user_id']);
              $book['vendor_name'] = @$puser->name;
              $book['vendor_email'] = @$puser->email;
              $book['vendor_mobile'] = @$puser->mobile;
              $book['vendor_country_code'] = @$puser->country_code;
              array_push($bookingProduct, $book);
           }
        }
        $data['bookingUSer']= $bookingProduct;

        $data['page']='users';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('booking_product.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else{
          redirect('');
      }
    }

    public function deleteProduct(){
      $id= $_GET['id'];
      $where = array('id'=>$id);
      $data = array('is_delete'=>1);
      $update= $this->Api_model->updateSingleRow('products', $where, $data);
      redirect('index.php/Admin/product_list');    

    }

    public function complaints(){
      if(isset($_SESSION['name'])){
        $complaints=$this->Api_model->getAllcmplaints('all');
        $data['complaints']= $complaints;
        $data['page']='complaints';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('complaints.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else{
          redirect('');
      }
    }

    public function change_password(){
      $id = $this->session->userdata('id');
      if(isset($_SESSION['name'])){
         $getPassword  = $this->Api_model->getSingleRow('admin', array(
             'id' => $id
          ));

        
        $data['old_password']= $getPassword->password;
        $data['login_email']= $getPassword->email;
        $data['page']='change_password';
        $this -> load -> view('common/head.php');
        $this -> load -> view($this->sidebar, $data);
        $this -> load ->view('change_password.php', $data);
        $this -> load -> view('common/footer.php');
      }
      else{
          redirect('');
      }
    }

    public function change_login_password(){
      $id = $this->session->userdata('id');
      $new_pass= $this->input->post('new_pass');
      $data['password'] =$new_pass;
      $where = array('id'=>$id);
      $update= $this->Api_model->updateSingleRow('admin', $where, $data);
      redirect('index.php/Admin/change_password');  
    }


    public function forgot_password(){
      $email= $this->input->post('email');
      
      $data['email']= $email;
      $sess_array=array();
      $getdata=$this->Api_model->getSingleRow('admin',$data);
      if($getdata){           
        if($getdata->status==1){
          $emailToken = sha1(uniqid());
          $where = array('id'=>$getdata->id);
          $data = array('verified_code'=>$emailToken);
          $update= $this->Api_model->updateSingleRow('admin', $where, $data);
          $msg =  "We recently received a password reset request for your email address. if you would like to reset your password, please do so using the following link<br></br>";
          $msg .= '<a href='.base_url('index.php/Admin/resetPassword/'.$emailToken).'>Click here for reset your password</a>';
          echo $msg;die;
          $this->send_email_sendgrid($email, 'RentAndHire - Password Reset Request', $msg);
          $this->session->set_flashdata('success', 'success');
          redirect('index.php/Login/forgotpassword');
        }
        else
        {
          $this->session->set_flashdata('block', 'You action has been block. Contact to admin.');
          redirect('index.php/Login/forgotpassword');
        }
      }
      else
      {
        $this->session->set_flashdata('msg', 'Please enter valid Username or Password');
        redirect('index.php/Login/forgotpassword');
      }

      


     
    }

    public function send_email_sendgrid($emailfrom,$subject, $msg){
      require 'vendor/autoload.php';
      $from_user = getenv('SENDGRID_EMAIL');
      $sendgrid_key = getenv('SENDGRID_KEY');
      $email = new \SendGrid\Mail\Mail();
      $email->setFrom($from_user, "RentAndHire");
      $email->setSubject($subject);
      $email->addTo($emailfrom, "Example User");
      $email->addContent("text/plain", "and easy to do anywhere, even with PHP");
      $email->addContent(
          "text/html", $msg
      );
      $sendgrid = new \SendGrid($sendgrid_key);
      try {
         $response = $sendgrid->send($email);
      } catch (Exception $e) {
        echo 'Caught exception: '. $e->getMessage() ."\n";
      }
    }

    public function resetPassword($code=''){
        if($code){
          $data['verified_code']= $code;
          $getdata=$this->Api_model->getSingleRow('admin',$data);
          if($getdata){           
            if($getdata->status==1){
              $this->load ->view('resetpassword.php',$data); 
            }
            else
            {
              $this->session->set_flashdata('block', 'You action has been block. Contact to admin.');
              redirect('index.php/Login');
            }
          }
          else
          {
            $this->session->set_flashdata('msg', 'Activation link is already used. You can not use it again!');
            redirect('index.php/Login');
          }
        }else{
            $this->session->set_flashdata('invalid_url', 'Invalid Url');
            redirect('index.php/Login');
        }
    }

    public function reset_my_password(){
      $code = $this->input->post('varified_code');
      $new_password = $this->input->post('new_password');
      $data['verified_code']= $code;
      $getdata=$this->Api_model->getSingleRow('admin',$data);
      if($getdata){           
        if($getdata->status==1){
            $where = array('id'=>$getdata->id);
            $data = array('verified_code'=>'','password'=>$new_password);
            $update= $this->Api_model->updateSingleRow('admin', $where, $data);
            $this->session->set_flashdata('success', 'Your password reset successfully!.');
            redirect('index.php/Admin/resetPassword/'.$code);
        }
        else
        {
          $this->session->set_flashdata('block', 'You action has been block. Contact to admin.');
          redirect('index.php/Admin/resetPassword/'.$code);
        }
      }
      else
      {
        $this->session->set_flashdata('msg', 'Activation link is already used. You can not use it again!');
        redirect('index.php/Admin/resetPassword/'.$code);
      }
      
  }


    public function send_msg_to_users(){
      print_r($_POST);die;
    }

}