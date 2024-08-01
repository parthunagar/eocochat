<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller {

	public function login()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
		        	$username = $params['email'];
		        	$password = $params['password'];
		        	$device_token = $params['device_token'];
		        	$response = $this->MyModel->login($username,$password,$device_token);
		        	//print_r($response);die;
		        	//return responseSuccesss(200,'Login Successfull', $response);
					if($response['token'] != 'null'){
						return responseSuccesss(200,'Login Successfull', $response);
					}
					else if($response['status'] != 200){
						return responseFailed($response);
					}
					exit();
				//json_output($response['status'],$response);
			}
		}
	}

	public function loginMobile()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
	        	$mobile = $params['mobile'];
	        	$country_code = $params['country_code'];
	        	$device_token = $params['device_token'];
	        	$getdata = $this->MyModel->getSingleRow('user_profile', array(
       			 'mobile' => $mobile,'country_code'=>$country_code
   			    ));
	        	if (empty($getdata)) {
        			$response = $this->MyModel->loginwithmobile($mobile,$country_code,$device_token);
					return responseSuccesss(200, 'Successfully Login', $response);
        			exit();
	        	}else{
	        		$response = $this->MyModel->loginwithmobiless($mobile,$country_code,$device_token);
	        		return responseSuccesss(200, 'Successfully Login', $response);
	        		exit();
	        		/*$response['status']=201;
	        		json_output($response['status'],$response);*/
			    }
			}
		}
	}

	public function logout()
	{	
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->logout();
				json_output($response['status'],$response);
			}
		}
	}
	
	public function signup()
	{	
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
				$email_address = @$params['email']; 
				$check_email = $this->MyModel->checkEmailAddress($email_address);
				if(empty($check_email)){
					$subject = 'Registration Successfully';
					

					if (@$params['type']== 3) {
						$response = $this->MyModel->signup($params);
						$user_id = $response['insert_id'];
						$msg =  "Hi, \n welcome to Rentors \n <a href='".base_url()."auto/verify_email/".$user_id."'> Click here</a> to verify your email. \n Thankyou";
						$this->send_email_sendgrid($params['email'], $subject, $msg);
						//$this->send_email_register($params['email'],$user_id);
						json_output($response['status'],$response);
					}elseif(@$params['type']== 2){
						$response = $this->MyModel->signup($params);
						$user_id = $response['insert_id'];
						$msg =  "Hi, \n welcome to Rentors \n <a href='".base_url()."auto/verify_email/".$user_id."'> Click here</a> to verify your email. \n Thankyou";
						//$this->send_email_register($params['email'],$user_id);
						$this->send_email_sendgrid($params['email'], $subject, $msg);
						json_output($response['status'],$response);
					}else{
						$salt = uniqid('', true);
						$algo = '6'; // CRYPT_SHA512
						$rounds = '5042';
						$cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
						$password = $params['password'];
						$hashedPassword = crypt($password, $cryptSalt);
						// Store complete $hashedPassword in DB
						$params['password'] = $hashedPassword;
						$response = $this->MyModel->signup($params);
						$user_id = $response['insert_id'];
						$msg =  "Hi, \n welcome to Rentors \n <a href='".base_url()."auto/verify_email/".$user_id."'> Click here</a> to verify your email. \n Thankyou";
						//$this->send_email_register($params['email'],$user_id);
						$this->send_email_sendgrid($params['email'], $subject, $msg);
						json_output($response['status'],$response);
					}
				}else{
					 json_output(201,array('status' => 201,'message' => 'Email address already exist'));
				}

			}
		}
	}

	public function send_email_register($email,$user_id){
		$this->load->library('email');
        $config = array(
            'protocol' => 'smtp',
            'smtp_host' => 'ssl://smtp.googlemail.com',
            'smtp_port' => 465,
            'smtp_user' => 'info@gmail.com',
            'smtp_pass' => '',
            'mailtype' => 'html',
            'charset' => 'iso-8859-1'
        );
        $user_id = base64_encode($user_id);
        $this->email->initialize($config);
        $this->email->set_mailtype("html");
        $this->email->set_newline("\r\n");
        $this->email->to($email);
        $this->email->from('info@gmail.com', 'info');
        $this->email->subject('Registration Successfully');
        $datas['email'] = $email;
        $body = "Hi, \n welcome to Rentors \n <a href='".base_url()."auto/verify_email/".$user_id."'> Click here</a> to verify your email. \n Thankyou";
       // echo $body;die;
		$this->email->message($body);
        $this->email->send();
	}



	public function check_email(){
		$this->load->library('email');

		$config['protocol']    = 'smtp';
		$config['smtp_host']    = 'ssl://smtp.gmail.com';
		$config['smtp_port']    = '465';
		$config['smtp_timeout'] = '7';
		$config['smtp_user']    = 'applatu@gmail.com';
		$config['smtp_pass']    = 'appla@123';
		$config['charset']    = 'utf-8';
		$config['newline']    = "\r\n";
		$config['mailtype'] = 'text'; // or html
		$config['validation'] = TRUE; // bool whether to validate email or not      

		$this->email->initialize($config);

		$this->email->from('applat@gmail.com', 'sender_name');
		$this->email->to('sg@gmail.com'); 
		$this->email->subject('Email Test');
		$this->email->message('Testing the email class.');  

		$this->email->send();

		echo $this->email->print_debugger();

	}




	public function verify_email($id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$id = base64_decode($id);
				$getdata = $this->MyModel->getSingleRow('users', array(
            	'id' => $id
        		));
        		//echo $getdata->email_verified;dien;
        		if(!empty($getdata)){
        			if($getdata->email_verified == 0){
        				$this->MyModel->updateSingleRow('users', array('id' => $id), array('email_verified' => '1'));
        				$response['message']="Email address verified";
        				$response['status']	= '1';							
						
        			}else{
        				$response['message']="Email address already verified";
        				$response['status']	= '0';
        			}
        		}else{
        			$response['message']="Email address not found";
        			$response['status']	= '0';
        		}
			}
			json_output(201,$response);
		}
	}

 	public function forgotUserPassword()
    {
    	$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
				$email = $params['email'];
				//email   = $this->input->post('email', TRUE);
        $getdata = $this->MyModel->getSingleRow('users', array(
            'email' => $email
        ));
        //echo $this->db->last_query();die;
       // print_r($getdata);die;
        if ($getdata) {
            $getId     = $getdata->id;
            $password = $this->strongToken(6);
            $salt = uniqid('', true);
				$algo = '6'; // CRYPT_SHA512
				$rounds = '5042';
				$cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
				$hashedPassword = crypt($password, $cryptSalt);
				$password2 = $hashedPassword;
           // $password1 = $this->strongToken(6);
            //$password2 = strtoupper($password1);
            //$password  = md5($password2);
            $update    = $this->MyModel->updateSingleRow('users', array(
                'email' => $email
            ), array(
                'password' => $password2
            ));

            //echo $password;die;



            $subject   = 'RentAndHire Forgot Password';
            $msg       = "Your updated Password is:   <strong>" . $password . "  .</strong></b>Please do not share this password with anyone else for the security reason.<br> Please login with updated Password.<br><b> - Thanks (RentAndHire).";
            
            $this->send_email_sendgrid($email, $subject, $msg);
            $resp =  array('status' => 200,'message' =>  'Your password updated successfully. Please check your email address.', $password);

            json_output(200,array('status' => 201,'message' => 'Your password updated successfully. Please check your email address.'));
            //return responseSuccess(200, 'Your password updated successfully. Please check your email address.', $password);
            //exit();
        } else {
	        //$resp =  array('status' => 201,'message' =>  'Please enter valid email address');
	        json_output(201,array('status' => 201,'message' => 'Please enter valid email address'));	          	}
        }
    }
}
     public function strongToken($length = 12, $add_dashes = false, $available_sets = 'luds')
    {
        $sets = array();
        if (strpos($available_sets, 'l') !== false)
            $sets[] = 'abcdefghjkmnpqrstuvwxyz';
        if (strpos($available_sets, 'u') !== false)
            $sets[] = 'ABCDEFGHJKMNPQRSTUVWXYZ';
        if (strpos($available_sets, 'd') !== false)
            $sets[] = '23456789';
        $all      = '';
        $password = '';
        foreach ($sets as $set) {
            $password .= $set[array_rand(str_split($set))];
            $all .= $set;
        }
        $all = str_split($all);
        for ($i = 0; $i < $length - count($sets); $i++)
            $password .= $all[array_rand($all)];
        $password = str_shuffle($password);
        if (!$add_dashes)
            return $password;
        $dash_len = floor(sqrt($length));
        $dash_str = '';
        while (strlen($password) > $dash_len) {
            $dash_str .= substr($password, 0, $dash_len) . '-';
            $password = substr($password, $dash_len);
        }
        $dash_str .= $password;
        return $dash_str;
    }

	public function send_email_to_user(){
    	$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
				$email_address = @$params['emailto']; 
				$msg = @$params['text']; 
				$subject = @$params['subject']; 
				if(!empty($email_address) && !empty($msg) && !empty($subject)){
					$this->send_email_sendgrid($email_address, $subject, $msg);
					json_output(200,array('status' => 200,'message' => 'Email send successfully'));
				}else{
					 json_output(201,array('status' => 201,'message' => 'Please enter required fields'));	
				}

			}
		}
    }



    public function send_email_sendgrid($emailfrom,$subject, $msg)
    {
    	require 'vendor/autoload.php';

		// Uncomment the next line if you're not using a dependency loader (such as Composer), replacing <PATH TO> with the path to the sendgrid-php.php file
		// require_once '<PATH TO>/sendgrid-php.php';
		/*$setting = $this->MyModel->getSettingRow();
		$from_user = $setting->sendgrid_email;
		$sendgrid_key = $setting->sendgrid_key;*/

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
		    /*print $response->statusCode() . "\n";
		    print_r($response->headers());
		    print $response->body() . "\n";*/
		} catch (Exception $e) {
			echo 'Caught exception: '. $e->getMessage() ."\n";
		}
    }

    public function socialMobileLogin()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			return json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
				if($params['social_type'] != 'fb' && $params['social_type'] != 'gplus'){
					return json_output(400,array('status' => 401,'message' => 'Invalid social type!'));
				}
						
	        	$device_token = $params['device_token'];
	        	$social_type = $params['social_type'];
	        	$social_id = $params['social_id'];
	        	$first_name = $params['first_name'];
	        	$last_name = $params['last_name'];
	        	$params['type'] = '';
				if($params['social_type'] == 'gplus') {
					$params['type'] = 3;
				} else if($params['social_type'] == 'fb') {
					$params['type'] = 2;
				}

	        	$getdata = $this->MyModel->getSingleRow('user_profile', array(
       			 'type' => $params['type'],'social_id'=>$social_id
   			    ));
	        	if (empty($getdata)) {
	        		$response = $this->MyModel->loginNewSocialWithMobile($params);
					return responseSuccesss(200, 'Successfully Login', $response);
        			exit();
	        	}else{
	        		$response = $this->MyModel->loginExistSocialWithMobile($params);
	        		return responseSuccesss(200, 'Successfully Login', $response);
	        		exit();
			    }
			}
		}
	}
	
}
