<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Subscription extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('SubscriptionModel');
    }

	public function get_feature_subscription()
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	//$response = $this->MyModel->auth($this->input->get_request_header('User-ID', TRUE),$this->input->get_request_header('Token', TRUE));
					$response = $this->MyModel->auth();
					if($response['status'] == 200){
		        		$resp = $this->SubscriptionModel->Subscription('feature');
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
			if($check_auth_client == 1){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
		        	if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					$resp = $this->SubscriptionModel->add($params);
					$response['message']='Success';	
					//$response['data']=$resp;										
					json_output($response['status'],$response);
					
		        }
			}
		}
	}


	public function get_subscription_list() {
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){

		        	//$response = $this->MyModel->auth($this->input->get_request_header('User-ID', TRUE),$this->input->get_request_header('Token', TRUE));
				$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->SubscriptionModel->Subscription('normal');
	        		if (!empty($resp)) {
	        			$response['Subscription_data']=$resp;
						$response['message']='Success';						
	   				   json_output($response['status'],$response);
	        		}else{
	        			json_output(201,array('status' => 201,'message' => 'No data found.'));
	        		}
					
	        	}
			}
		}
	}


	public function get_current_subscription($id) {
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->SubscriptionModel->user_current_Subscription($id);
	        		if (!empty($resp)) {
	        			$response['data']=$resp[0];
						$response['message']='Success';						
	   				   json_output($response['status'],$response);
	        		}else{
	        			json_output(201,array('status' => 201,'message' => 'No data found.'));
	        		}
					
	        	}
			}
		}
	}

	public function check_user_subscription($id) {
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->SubscriptionModel->user_current_Subscription($id);
	        		$totalSub = $this->SubscriptionModel->total_user_subcription($id);
	        		if (!empty($resp)) {

						//response['data']=$resp;
						$response['is_added_product_count'] = $totalSub;
						$response['is_subscribed']=true;						
	   				   json_output($response['status'],$response);
	        		}else{
	        			$resp = $this->SubscriptionModel->Subscription('all');
	        			$response['is_added_product_count'] = 0;
	        			$response['is_subscribed'] = false;
	        			$response['data']=$resp;
	        			
	        					
	   				   json_output($response['status'],$response);
	        		}
					
	        	}
			}
		}
	}

	

	public function add_user_subscription(){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
		 $check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == 1){
		        	 $response = $this->MyModel->auth();
		        	$respStatus = $response['status'];
		        	if($response['status'] == 200){
					$params = json_decode(file_get_contents('php://input'), TRUE);
					$resp = $this->SubscriptionModel->add_user_subscription($params);
					/*$push_msg = "Type : Nofification \n";
               		$push_msg .= "Message : Congratulations. You have been subscribed succesfully. Add more products and increase your earnings";*/

               		$myObj['Body'] = 'Congratulations. You have been subscribed succesfully. Add more products and increase your earnings';
               		$myObj['Type'] = 'Nofification';

              		$push_msg = json_encode($myObj);

               		//echo $push_msg;die;
					$this->MyModel->pushNotification($params['user_id'],'add user Subscription',$push_msg);
					json_output($response['status'],$resp);
					
		        }
			}
		}
	}



}
