<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MyModel extends CI_Model {

    var $client_service = "frontend-client";
    var $auth_key       = "simplerestapi"; 

    public function check_auth_client(){
        $client_service = $this->input->get_request_header('Client-Service', TRUE);
        $auth_key  = $this->input->get_request_header('Auth-Key', TRUE);
        if($client_service == $this->client_service && $auth_key == $this->auth_key){
            return true;
        } else {
            return json_output(200,array('status' => 401,'message' => 'Unauthorized.'));//on mobile dev request sending 200 response with status as 401
        }
    }

    public function login($username,$password,$device_token)
    {
        $q  = $this->db->select('password,id,name')->from('users')->where('email',$username)->get()->row();
        $imagep = '';
        if($q == ""){
            return array('status' => 401,'message' => 'User not found.','token'=>'null');
        } else {
            $hashed_password = $q->password;
            $id              = $q->id;
            $name            = $q->name;
            $image  = $this->db->select('profile_pic')->from('user_profile')->where('user_id',$id)->get()->row();
            if(!empty($image) && ($image->profile_pic != "NA")){
              $imagep = $image->profile_pic;
            }
            //if (hash_equals($hashed_password, crypt($password, $hashed_password))) {
			if (crypt($password, $hashed_password) == $hashed_password) {
               $last_login = date('Y-m-d H:i:s');
			   $salt = uniqid('', true);
				$algo = '6'; // CRYPT_SHA512
				$rounds = '5042';
				$cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
               $token = crypt(substr( md5(rand()), 0, 7), $cryptSalt);
               $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
               $this->db->trans_start();
               $this->db->where('id',$id)->update('users',array('last_login' => $last_login));
               $this->db->insert('users_authentication',array('users_id' => $id,'token' => $token,'expired_at' => $expired_at));
               if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  return array('status' => 500,'message' => 'Internal server error.','token'=>'null');
               } else {
                  $check_device_token = $this->db->select('device_token')->from('users')->where('id',$id)->get()->row();

                  if(!empty($check_device_token->device_token)){
                    $exist_token = explode(',',$check_device_token->device_token);
                    $checkToken = false;
                    foreach($exist_token as $etoken){
                      if($etoken == $device_token){
                        $checkToken = true;
                      }
                    }
                    if($checkToken == false){
                      $device_token = $check_device_token->device_token. ','.$device_token;  
                       $this->db->where('id',$id)->update('users',array('device_token' => $device_token));
                    }
                    
                  }else{
                    $this->db->where('id',$id)->update('users',array('device_token' => $device_token));
                  }
                 
                  $this->db->trans_commit();
                  return array('id' => $id, 'token' => $token,'email' =>$username,  'name'=>$name,'user_profile'=>$imagep);
               }
            } else {
              return array('token' => 'null', 'status' => 401,'message' => 'Incorrect Password.');
            }
        }
    }


    public function loginwithmobile($mobile,$country_code,$device_token)
    {





    $this->db->insert('users',array('email'=>'','name'=>'','device_token'=>$device_token));
    $insert_id = $this->db->insert_id();


    //echo $insert_id;die;

    $t=time();
    $this->db->insert('user_profile',array('mobile'=>$mobile,'country_code'=>$country_code,'user_id' => $insert_id,'type' =>'1','name' =>'NA','last_name' => 'NA','profile_pic' => 'NA','created_at' => $t,'updated_at' => $t));

     $q  = $this->db->select('mobile,user_id,name')->from('user_profile')->where('id',$insert_id)->get()->result();
        
        if($q == ""){
            return array('status' => 401,'message' => 'User not found.');
       } else {
            $hashed_password = @$q[0]->mobile;  
            $id              = @$q[0]->user_id;
            $name            = @$q[0]->name;
      if (crypt($mobile, $hashed_password) != $hashed_password) {
               $last_login = date('Y-m-d H:i:s');
         $salt = uniqid('', true);
        $algo = '6'; // CRYPT_SHA512
        $rounds = '5042';
        $cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
               $token = crypt(substr( md5(rand()), 0, 7), $cryptSalt);
               $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
               $this->db->trans_start();
               $this->db->where('id',$id)->update('users',array('last_login' => $last_login));
               $this->db->insert('users_authentication',array('users_id' => $id,'token' => $token,'expired_at' => $expired_at));
               if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  return array('status' => 500,'message' => 'Internal server error.');
               } else {
                  $this->db->trans_commit();
                  return array('id' => $id, 'token' => $token, 'mobile' =>$mobile, 'country_code'=>$country_code, 'name' =>$name);
               }
            } else {
              return array('status' => 401,'message' => 'Wrong password.');
            }
        }
    }

     public function loginwithmobiless($mobile,$country_code,$device_token)
    {
        $q  = $this->db->select('mobile,user_id,name')->from('user_profile')->where('mobile',$mobile)->get()->row();

        if($q == ""){
            return array('status' => 401,'message' => 'User not found.');
        } else {
            $hashed_password = $q->mobile;  
            $id              = $q->user_id;
            $name            = $q->name;
            //if (hash_equals($hashed_password, crypt($password, $hashed_password))) {
      if (crypt($mobile, $hashed_password) != $hashed_password) {
               $last_login = date('Y-m-d H:i:s');
         $salt = uniqid('', true);
        $algo = '6'; // CRYPT_SHA512
        $rounds = '5042';
        $cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;

               $token = crypt(substr( md5(rand()), 0, 7), $cryptSalt);
               $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
               $this->db->trans_start();
               $check_device_token = $this->db->select('device_token')->from('users')->where('id',$id)->get()->row();

                  if(!empty($check_device_token->device_token)){
                    $exist_token = explode(',',$check_device_token->device_token);
                    $checkToken = false;
                    foreach($exist_token as $etoken){
                      if($etoken == $device_token){
                        $checkToken = true;
                      }
                    }
                    if($checkToken == false){
                      $device_token = $check_device_token->device_token. ','.$device_token;  
                       $this->db->where('id',$id)->update('users',array('device_token' => $device_token));
                    }
                    
                  }



               $this->db->where('id',$id)->update('users',array('last_login' => $last_login));
               $this->db->insert('users_authentication',array('users_id' => $id,'token' => $token,'expired_at' => $expired_at));
               if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  return array('status' => 500,'message' => 'Internal server error.');
               } else {
                  $this->db->trans_commit();
                  return array('id' => $id, 'token' => $token, 'mobile' =>$mobile, 'country_code' =>$country_code, 'name' =>$name);
               }
            } else {
               return array('status' => 401,'message' => 'Wrong password.');
            }
        }
    }


    public function logout()
    {
		$this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $token     = $this->input->get_request_header('Authorization', TRUE);
        $this->db->where('users_id',$users_id)->where('token',$token)->delete('users_authentication');
        return array('status' => 200,'message' => 'Successfully logout.');
    }

    public function auth()
    {
		$this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $token     = $this->input->get_request_header('Token', TRUE);
        $q  = $this->db->select('expired_at')->from('users_authentication')->where('users_id',$users_id)->where('token',$token)->get()->row();
        if($q == ""){
            return json_output(200,array('status' => 401,'message' => 'Auth Failed'));
			//on mobile dev request sending 200 response with status as 401
        } else {
            if($q->expired_at < date('Y-m-d H:i:s')){
                return json_output(200,array('status' => 401,'message' => 'Your session has been expired.'));
            } else {
                $updated_at = date('Y-m-d H:i:s');
                $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
                $this->db->where('users_id',$users_id)->where('token',$token)->update('users_authentication',array('expired_at' => $expired_at,'updated_at' => $updated_at));
                return array('status' => 200,'message' => 'Authorized.');
            }
        }
    }

	public function signup($data)
    {
      if (@$data['name']) {
        $name=$data['name'];
      }else{
        $name="";
      }  
      $this->db->insert('users',array('email'=>$data['email'],'name'=>$name,'password'=>$data['password']));
  		$insert_id = $this->db->insert_id();
  		$t=time();
      if (@$data['type']) {
        $type=$data['type'];
      }else{
        $type=1;
      }    
  		$this->db->insert('user_profile',array('user_id' => $insert_id,'type' =>$type,'name' =>$name,'last_name' => 'NA','profile_pic' => 'NA','created_at' => $t,'updated_at' => $t));
        /*$result=  $this->db->select('*')->from('users')->Where('id',$insert_id)->get()->row();
        return array('status' => 200,'message' => 'Success','data' => $result);*/
          return array('status' => 201,'message' => 'Data has been created.','insert_id'=>$insert_id);
    }
	//timezone cheat
	/*
		$timestamp = 1578124167;
		
		$datetime = new DateTime("@$timestamp");
		$datetimeFormat = $datetime->format('d-m-Y H:i:s');
		$timezoneFrom="UTC";
		$timezoneTo='Asia/Kolkata';
		$displayDate = new DateTime($datetimeFormat, new DateTimeZone($timezoneFrom));
		$displayDate->setTimezone(new DateTimeZone($timezoneTo));
		echo $displayDate->format('d-m-Y H:i:s'); 
	*/


	public function list_all_data($table)
		{
			//echo $this->input->get('param2');die;
			$result=  $this->db->select('*')->from($table)->order_by('id','desc')->get()->result();
			return array('status' => 200,'message' => 'Success','data' => $result);
			
			/*$this->db->select('category.name as ok,sub_category.*');
			$this->db->from('category');
			$this->db->join('sub_category', ' sub_category.category_id = category.id ', 'left outer'); 
			$query = $this->db->get();
			$result =  $query->result();*/
			//var_dump( $result); die;
			
		}
		
		
	public function get_categories()
		{
			$query = $this->db->get('category');
			$return = array();

			foreach ($query->result() as $category)
			{
				$category->sub_category = $this->get_sub_categories($category->id); // Get the categories sub categories
				//print_r ($category->sub_category); die; 
				//$category->sub_category->file_field = json_decode($category->sub_category->file_field,true);
				array_push($return,$category);
				//$return[$category->id] = $category;
				//$return[$category->id]->subs = $this->get_sub_categories($category->id); // Get the categories sub categories
			}

			$result =  $return;
					//var_dump( $result); die;
					return array('status' => 200,'message' => 'Success','data' => $result);
		}


	public function get_sub_categories($category_id)
		{
       $sub_category=array();
			$this->db->where('category_id', $category_id);
			$query = $this->db->get('sub_category');
      if(!empty($query->result())){
        $results = $query->result();
       // print_r($results);die;
        foreach($results as $result){
           $sub_cat['id'] = $result->id;
                $sub_cat['category_id'] = $result->category_id;
                $sub_cat['name'] = $result->name;
                $sub_cat['slider_image'] =json_decode($result->sub_cat_image,true);
                $sub_cat['form_field'] =json_decode($result->form_field,true);
                $sub_cat['created_at'] = $result->created_at;
                $sub_cat['updated_at'] = $result->updated_at;
                array_push($sub_category, $sub_cat);
        }
      }
			return $sub_category;
		}

      public function subcategory_by_category($category_id)
    {
        $this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $data = array();
        $cat_result = $this->db->select('*')->from('sub_category')->where('category_id',$category_id)->order_by('id','asc')->get()->result_array();
        
        $sub_category=array();

        if(!empty($cat_result)){
           foreach ($cat_result as $result) {

                $sub_cat['id'] = $result['id'];
                $sub_cat['category_id'] = $result['category_id'];
                $sub_cat['name'] = $result['name'];
                $slider_image=array();
                $sub_cat['slider_image'] =json_decode($result['sub_cat_image'],true);
                $sub_cat['subcategory_icon'] =$result['sub_cat_icon'];
                $sub_cat['form_field'] =json_decode($result['form_field'],true);
		           $sub_cat['created_at'] = $result['created_at'];
                $sub_cat['updated_at'] = $result['updated_at'];
                array_push($sub_category, $sub_cat);
         }
        }
        else{
          //$sub_category = "";
        }
        $data['sub_category'] = $sub_category;

        $pro_results = $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','asc')->get()->result();

         $pro_result =array();
        foreach ($pro_results as $pro_results) {
        $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$pro_results->id)->get()->result();
        if(empty($like_result)){
          $pro_results->is_like=0;
          }else{
            $pro_results->is_like=$like_result[0]->status;
        }

        
        array_push($pro_result, $pro_results);
      }
          $data['products'] = $pro_result;
		  
// Get Slider images of Category

        $cat_images_results = $this->db->select('*')->from('category')->where('id',$category_id)->order_by('id','asc')->get()->result();

		
          $data['slider_image'] =  json_decode($cat_images_results[0]->category_image, true);		  
		  
         return $data;
    }

      public function getSingleRow($table, $condition)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            $query = $this->db->get();
            return $query->row();       
        }

      public function updateSingleRow($table, $where, $data)
        {                 
            $this->db->where($where);
            $this->db->update($table, $data);
           //= echo $sql = $this->db->last_query();

                  if ($this->db->affected_rows() > 0)
            {
              return TRUE;
            }
            else
            {
              return FALSE;
            }
        }


        public function addPaySubscription($data){
          $this->db->insert('pay_subscription_log',$data);
           $insert_id = $this->db->insert_id();
           return $insert_id;
        }

        public function addComplaint($data){
          $data['created_at'] = time();
          $this->db->insert('user_complaint',$data);
           $insert_id = $this->db->insert_id();
           return $insert_id;

        }
        public function getUserComplaint($id){
          echo $id;
          $this->db->select('*');
          $this->db->where('user_id',$id);
          $this->db->from('user_complaint');
          $query = $this->db->get();
          return $query->result_array();  
        }

        //push notification sent to user using user id
        public function pushNotification($id,$title,$message){
          $success = '';
          $api_key= '';
         // $setting = $this->getAllSettingData();
         /* if(!empty($setting)){
            $api_key = $setting[0]->firebase_api_key;
          }*/
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
            $userTokens = $this->getUserData('users',$where);
            //print_r($userTokens);die;
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

                'notification' => $dataa,
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

      public function getAllSettingData(){
          $this->db->select("*");
          $this->db->from('setting');
          $query = $this->db->get();          
          return $query->result();
      }

      /*Get All data with limit*/
      public function getUserData($table, $where){
          $this->db->select("*");
          $this->db->where($where);
          $this->db->from($table);
          $query = $this->db->get();          
          return $query->result();
      }

      public function checkEmailAddress($email){
          $this->db->select("*");
          $this->db->where('email',$email);
          $this->db->from('users');
          $query = $this->db->get();          
          return $query->result();
      }

      public function getSettingRow(){
        
        $this->db->select("*");
         // $this->db->where('email',$email);
          $this->db->from('setting');
          $query = $this->db->get(); 
         // echo $this->db->last_query();         
          return $query->row();
      }


      public function sub_cat_product_by_cat($category_id)
    {
        $this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $data = array();
        $cat_result = $this->db->select('*')->from('sub_category')->where('category_id',$category_id)->order_by('id','asc')->get()->result_array();
        
        $sub_category=array();

        if(!empty($cat_result)){
           foreach ($cat_result as $result) {
                $sub_cat['id'] = $result['id'];
                $sub_cat['category_id'] = $result['category_id'];
                $sub_cat['name'] = $result['name'];
                $slider_image=array();
                $sub_cat['slider_image'] =json_decode($result['sub_cat_image'],true);
                $sub_cat['subcategory_icon'] =$result['sub_cat_icon'];
                $sub_cat['form_field'] =json_decode($result['form_field'],true);
                $sub_cat['created_at'] = $result['created_at'];
                $sub_cat['updated_at'] = $result['updated_at'];
                array_push($sub_category, $sub_cat);
         }
        }
        else{
          //$sub_category = "";
        }
        $data['sub_category'] = $sub_category;

        $pro_results = $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','asc')->get()->result();

        $pro_result =array();
        foreach ($pro_results as $pro_results) {
          $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$pro_results->id)->get()->result();
          if(empty($like_result)){
             $pro_results->is_like=0;
          }else{
             $pro_results->is_like=$like_result[0]->status;
          }

          array_push($pro_result, $pro_results);
        }


        $obj_sub_category = array();
        $product_result_temp = array();
        $sub_cat_result=  $this->db->select('*')->from('sub_category')->where('category_id',$category_id)->order_by('id','asc')->get()->result();
        //print_r($sub_cat_result);die;
        
        foreach ($sub_cat_result as $sub_category){
            $obj_sub_category_temp = array();
            $obj_sub_category_temp['sub_category_name'] = $sub_category->name;
            $pro_results = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category->id)->order_by('id','asc')->get()->result();

            $pro_result_temp =array();
            foreach ($pro_results as $pro_results) {
              $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$pro_results->id)->get()->result();
              if(empty($like_result)){
                 $pro_results->is_like=0;
              }else{
                 $pro_results->is_like=$like_result[0]->status;
              }
               array_push($pro_result_temp, $pro_results);
            }
              
                
            $obj_sub_category_temp['subcategory_products']= $pro_result_temp;
            
             if(!empty($pro_result_temp)){
              array_push($product_result_temp,$obj_sub_category_temp);
            }
            
            
          }
          $data['products'] = $product_result_temp;
      
        // Get Slider images of Category

        $cat_images_results = $this->db->select('*')->from('category')->where('id',$category_id)->order_by('id','asc')->get()->result();

    
          $data['slider_image'] =  json_decode($cat_images_results[0]->category_image, true);     
      
         return $data;
    }


    public function loginNewSocialWithMobile($paramArr)
    {
      $this->db->insert('users',array('email'=>'','name'=>$paramArr['first_name'].' '.$paramArr['last_name'],'device_token'=>$paramArr['device_token']));
      $insert_id = $this->db->insert_id();
      //echo $insert_id;die;
      
      $t=time();
      $this->db->insert('user_profile',array('mobile'=>'','country_code'=>'','user_id' => $insert_id, 'type' =>$paramArr['type'], 'social_id' =>$paramArr['social_id'],'name' =>$paramArr['first_name'],'last_name' => $paramArr['last_name'],'profile_pic' => 'NA','created_at' => $t,'updated_at' => $t));
      $insert_user_profile_id = $this->db->insert_id();
      
      $q = $this->db->select('social_id,user_id,name')->from('user_profile')->where('id',$insert_user_profile_id)->get()->result();
          
      if($q == ""){
          return array('status' => 401,'message' => 'User not found.');
      } else {
        $hashed_password = @$q[0]->social_id;  
        $id              = @$q[0]->user_id;
        $name            = @$q[0]->name;
        if (crypt($paramArr['social_id'], $hashed_password) != $hashed_password) {
          $last_login = date('Y-m-d H:i:s');
          $salt = uniqid('', true);
          $algo = '6'; // CRYPT_SHA512
          $rounds = '5042';
          $cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
          $token = crypt(substr( md5(rand()), 0, 7), $cryptSalt);
          $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
          $this->db->trans_start();
          $this->db->where('id',$id)->update('users',array('last_login' => $last_login));
          $this->db->insert('users_authentication',array('users_id' => $id,'token' => $token,'expired_at' => $expired_at));
          if ($this->db->trans_status() === FALSE){
            $this->db->trans_rollback();
            return array('status' => 500,'message' => 'Internal server error.');
          } else {
            $this->db->trans_commit();
            return array('id' => $id, 'token' => $token, 'mobile' =>'', 'country_code'=>'', 'name' =>$name, 'social_id' =>$paramArr['social_id'], 'type' =>$paramArr['type']);
          }
        } else {
            return array('status' => 401,'message' => 'Wrong password.');
        }
      }
    }


    public function loginExistSocialWithMobile($paramArr)
    {
      $q  = $this->db->select('social_id,user_id,name')->from('user_profile')->where(array('type' => $paramArr['type'], 'social_id'=>$paramArr['social_id']))->get()->row();
      if($q == ""){
        return array('status' => 401,'message' => 'User not found.');
      } else {
        $hashed_password = $q->social_id;  
        $id              = $q->user_id;
        $name            = $q->name;
      
        if (crypt($paramArr['social_id'], $hashed_password) != $hashed_password) {
          $last_login = date('Y-m-d H:i:s');
          $salt = uniqid('', true);
          $algo = '6'; // CRYPT_SHA512
          $rounds = '5042';
          $cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;

          $token = crypt(substr( md5(rand()), 0, 7), $cryptSalt);
          $expired_at = date("Y-m-d H:i:s", strtotime('+12 hours'));
          $this->db->trans_start();
          $check_device_token = $this->db->select('device_token')->from('users')->where('id',$id)->get()->row();

          if(!empty($check_device_token->device_token)){
            $exist_token = explode(',',$check_device_token->device_token);
            $checkToken = false;
            foreach($exist_token as $etoken){
              if($etoken == $paramArr['device_token']){
                $checkToken = true;
              }
            }
            if($checkToken == false){
              $device_token = $check_device_token->device_token. ','.$paramArr['device_token'];  
              $this->db->where('id',$id)->update('users',array('device_token' => $device_token));
            }
          }

          $this->db->where('id',$id)->update('users',array('last_login' => $last_login));
          $this->db->insert('users_authentication',array('users_id' => $id,'token' => $token,'expired_at' => $expired_at));
          if ($this->db->trans_status() === FALSE){
            $this->db->trans_rollback();
            return array('status' => 500,'message' => 'Internal server error.');
          } else {
            $this->db->trans_commit();
            return array('id' => $id, 'token' => $token, 'mobile' =>'', 'country_code'=>'', 'name' =>$name, 'social_id' =>$paramArr['social_id'], 'type' =>$paramArr['type']);
          }
        } else {
          return array('status' => 401,'message' => 'Wrong password.');
        }
      }
    }







      //  public function responseFailed($status, $message){
      //       $arr = array('status' => $status,'message' => $message); 
      //       header('Content-Type: application/json');      
      //        echo json_encode($arr);
      //   }
}
