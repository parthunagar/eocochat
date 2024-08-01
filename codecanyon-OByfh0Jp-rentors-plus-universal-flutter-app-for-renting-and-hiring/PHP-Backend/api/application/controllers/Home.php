<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('HomeModel');
    }

	public function index($id,$lat,$long)
	{
		
		//$id = 6;
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	//$response = $this->MyModel->auth($this->input->get_request_header('User-ID', TRUE),$this->input->get_request_header('Token', TRUE));
					$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->HomeModel->home_all_data($id,$lat,$long);
		        		if (!empty($resp)) {
		        			$response['data']=$resp;
							$response['message']='Success';						
							json_output($response['status'],$response);
			
		        		}else{
		        			json_output(201,array('status' => 201,'message' => 'No data found.'));
		        		}
						
		        	}
			}
		}
	}

	public function detail($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProductModel->product_detail_data($id);
		        		if (!empty($resp)) {
		        			$response['data']=$resp;
							$response['message']='Success';						
							json_output($response['status'],$response);
		        		}else{
		        			json_output(201,array('status' => 201,'message' => 'No data found.'));
		        		}
						
		        	}
			}
		}
	}

	public function create()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
					
		        	if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					if ($params['details'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Product Detail can\'t empty');
					} else {
		        			$resp = $this->ProductModel->product_create_data($params);
							$response['message']='Success';	
					}
					$response['data']=$resp;										
					json_output($response['status'],$response);
		        	}
			}
		}
	}

	public function update($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'PUT' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
				if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					$params['updated_at'] = time();
					if ($params['details'] == "" ) {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Product Detail can\'t empty');
					} else {
		        			$resp = $this->ProductModel->product_update_data($id,$params);
							$response['message']='Success';	
					}
					$response['data']=$resp;										
					json_output($response['status'],$response);
		       		}
			}
		}
	}

	public function delete($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'DELETE' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProductModel->product_delete_data($id);
					json_output($response['status'],$resp);
		        	}
			}
		}
	}

	public function getCity(){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->MyModel->list_all_data('city');
		        		if (!empty($resp)) {
		        			$response['data']=$resp;
							$response['message']='Success';						
							json_output(200,$resp);
		        		}else{
		        			json_output(201,array('status' => 201,'message' => 'No data found.'));
		        		}
						
		        	}
			}
		}

	}

	public function changePassword(){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
					
		        	if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					if (@$params['user_id'] == "" || @$params['new_pass'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Required User ID and Password');
						$response['data']=$resp;	
					} else {
						$salt = uniqid('', true);
						$algo = '6'; // CRYPT_SHA512
						$rounds = '5042';
						$cryptSalt = '$'.$algo.'$rounds='.$rounds.'$'.$salt;
						$password = $params['new_pass'];
						$hashedPassword = crypt($password, $cryptSalt);
						$where = array('id'=>$params['user_id']);
						$data['password'] = $hashedPassword;
						$resp = $this->MyModel->updateSingleRow('users',$where,$data);

						$response['message']='Password Changed successfully';	
					}
					//$response['data']=$resp;										
					json_output($response['status'],$response);
		        	}
			}
		}
	}
	public function user_complaint(){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
					
		        	if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					//print_r($params);die;
					if (@$params['user_id'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Required User ID');
						$response['data']=$resp;	
					} else {
						$resp = $this->MyModel->addComplaint($params);
						$response['message']='Added successfully';	
						/*$push_msg = "Type : Nofification \n";
               		    $push_msg .= "Message : Thanks. You have registered a Complaint Successfully";*/


               		    $myObj['Body'] = "Thanks. You have registered a Complaint Successfully";
		                $myObj['Type'] = 'Nofification';

		                $push_msg = json_encode($myObj);

               		    
               		    //echo $push_msg;die;
						$this->MyModel->pushNotification($params['user_id'],'user complaint',$push_msg);
					}
					//$response['data']=$resp;										
					json_output($response['status'],$response);
		        	}
			}
		}
	}

	public function getUserComplaint($user_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->MyModel->getUserComplaint($user_id);
		        		if (!empty($resp)) {
		        			$response['data']=$resp;
							$response['message']='Success';						
							json_output(200,$resp);
		        		}else{
		        			json_output(201,array('status' => 201,'message' => 'No data found.'));
		        		}
						
		        	}
			}
		}

	}

}
