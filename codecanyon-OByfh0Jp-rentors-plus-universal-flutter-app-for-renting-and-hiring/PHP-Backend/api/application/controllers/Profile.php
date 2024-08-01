<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Profile extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('ProfileModel');
    }

	public function index()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
					$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProfileModel->profile_all_data();
		        		if (!empty($resp)) {
		        		json_output($response['status'],$resp);
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
		        		$resp = $this->ProfileModel->profile_detail_data($id);
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
					if ($params['title'] == "" || $params['author'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Title & Author can\'t empty');
					} else {
		        			$resp = $this->MyModel->book_create_data($params);
					}
					json_output($respStatus,$resp);
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
				if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);


					

					$params['updated_at'] = time();
					$checkEmailAddress = array();
					if(!empty($params['email'])){
						$checkEmailAddress = $this->ProfileModel->checkEmailAddress($params['email'],$id);
					}
					//print_r($checkEmailAddress);die;
					if(empty($checkEmailAddress)){
						$resp = $this->ProfileModel->profile_update_data($id,$params);		
						if (!empty($resp)){
						$response['data']=$resp;
						$response['message']='Success';						
						json_output($response['status'],$response);	
						}else{
							json_output(201,array('status' => 201,'message' => 'unsuccessful'));
						}			
						
			       		}
			       		else{
						json_output(201,array('status' => 201,'message' => 'Email Already Exist'));
					}
					}



					
			}
		}
	}

}
