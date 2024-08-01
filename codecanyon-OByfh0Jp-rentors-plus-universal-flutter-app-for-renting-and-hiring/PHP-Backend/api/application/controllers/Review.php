<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Review extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('ReviewModel');
    }

	public function review()
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
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>'Review can\'t empty');
						$resp = $this->ReviewModel->addReview($params);
						if (!empty($resp)) {
						$response['message']='Success';	
						$response['data']=$resp;							
						json_output($response['status'],$response);
						}else{
							json_output(201,array('status' => 201,'message' => 'No data added.'));
		        	}
				}
			}
		}
	}

	public function getReview($product_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ReviewModel->review_data($product_id);
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

	public function request_review(){
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
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>'Review can\'t empty');
						$resp = $this->ReviewModel->addRequestReview($params);
						if (!empty($resp)) {
							json_output(201,array('status' => 200,'message' => 'Request Sent'));
						}else{
							json_output(201,array('status' => 201,'message' => 'No data added.'));
		        	}
				}
			}
		}
	}
}
