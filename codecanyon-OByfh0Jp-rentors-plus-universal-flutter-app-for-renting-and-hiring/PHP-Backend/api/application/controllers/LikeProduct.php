<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class LikeProduct extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('LikeProductModel');
    }

	public function like()
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
						$resp = array('status' => 400,'message' =>'Like Product can\'t empty');
							$resp = $this->LikeProductModel->like_product($params);
							if (!empty($resp)) {
							$response['message']='Success';	
							json_output($response['status'],$response);
							}else{
								json_output(201,array('status' => 201,'message' => 'Unsuccessful'));
							}
							
		        	}
			}
		}
	}

	public function unlike($id)
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
					// $params = json_decode(file_get_contents('php://input'), TRUE);
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>'Post Request can\'t empty');
							$resp = $this->LikeProductModel->unlike_product($id);
							if (!empty($resp)) {
							$response['message']='unlike product Successfully.';	
							json_output($response['status'],$response);
							}else{
								json_output(201,array('status' => 201,'message' => 'Unsuccessful'));
							}
							
		        	}
			}
		}
	}
}
