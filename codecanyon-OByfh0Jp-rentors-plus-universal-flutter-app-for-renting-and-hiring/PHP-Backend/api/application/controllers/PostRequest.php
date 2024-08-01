<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class PostRequest extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('PostRequestModel');
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
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>'Post Request can\'t empty');
							$resp = $this->PostRequestModel->post_request_create_data($params);
							$response['message']='Success';	
					$response['data']=$resp;							
					json_output($response['status'],$response);
		        	}
			}
		}
	}
}
