<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Category extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
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
		        		$resp = $this->MyModel->get_categories();
		        		if (!empty($resp)) {
		        			json_output($response['status'],$resp);
		        		}else{
		        			json_output(201,array('status' => 201,'message' => 'No data found.'));
		        		}
	    				
		        	}
			}
		}
	}

	public function getSubCategoryByCategory($category_id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->MyModel->subcategory_by_category($category_id);
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


	public function getSubCategoryByCategoryv2($category_id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->MyModel->sub_cat_product_by_cat($category_id);
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
