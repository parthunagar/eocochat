<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class History extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('HistoryModel');
    }

		public function rentHistory($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->HistoryModel->rent_history($id);
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

		public function itemHired($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->HistoryModel->item_hired($id);
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

		public function activeProducts($id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->HistoryModel->active_products($id);
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
}
