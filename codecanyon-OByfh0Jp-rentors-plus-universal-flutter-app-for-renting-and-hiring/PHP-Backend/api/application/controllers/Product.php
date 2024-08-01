<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Product extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('ProductModel');
    }

	public function index()
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
		        		$resp = $this->ProductModel->product_all_data();
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

	public function detail($id,$lat,$long)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProductModel->product_detail_data($id,$lat,$long);
		        		//$review = $this->ProductModel->review_detail_data($id);
		        		if (!empty($resp)) {
							//$resp->is_like = "0";
							$resp->reviewdata = $this->ProductModel->review_detail_data($id);
							$response['data']=$resp;
							//$response['review_data'] = $review;
							$response['message']='Success';						
							json_output($response['status'],$response);
						}else{
							json_output(201,array('status' => 201,'message' => 'No data found.'));
						}
						
		        	}
			}
		}
	}

	public function getProductByCategory($category_id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProductModel->product_by_category($category_id);
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

	public function getProductBySubCategory($sub_category_id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$page = '';
		        		if(isset($_GET['page'])){
		        			$page = ($_GET['page'] * 10) - 10;;
		        		}
		        		$resp = $this->ProductModel->product_by_subcategory($sub_category_id,$page);
						if(!empty($resp)){
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

	public function myAddedProduct($user_id)
	{
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	if($response['status'] == 200){
		        		$resp = $this->ProductModel->product_by_user($user_id);
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
							$params_details = json_decode(	$params['details'], TRUE);
				    		$params['category_name'] = $params_details['category'];
							$params['sub_category_name'] = $params_details['subcategory'];
							$params['price'] = $params_details['price'];
							$params['address'] = $params_details['address'];
							$params['city_id'] = $params_details['city_id'];
							$params['city_name'] = $params_details['city'];
							$params['lat'] = $params_details['lat'];
							$params['lng'] = $params_details['lng'];
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
					$params['status'] = 0;
					$params['is_approved'] = 0;
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
	//delete product by id
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

//search product
	public function search()
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

					$resp = $this->ProductModel->search_product($params);
							$response['status'] = 404;
		        			$response['message']='No Product Found';
		        			if(!empty($resp)){
								$response['status'] = 200;
		        				$response['message']='Success';
		        			}
					$response['data']=$resp;										
					json_output($response['status'],$response);
		        	}
			}
		}
	}

	public function changeProductStatus()
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
					if($params['product_id'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Product value can\'t empty');
					}else {
	        			$resp = $this->ProductModel->change_status($params);
						if($params['status'] == 1){
							$response['message']='Product Published';
							$msg = 'Your Product is Published now';
	        			}else{
	        				$response['message']='Product Unpublished';
	        				$msg = 'Your Product Unpublished now.';
	        			}
	        			/*$push_msg = "Type : Nofification \n";
               		    $push_msg .= "Message : ".$msg;*/

               		    $myObj['Body'] = $msg;
                $myObj['Type'] = 'Nofification';

                $push_msg = json_encode($myObj);


	        			$this->MyModel->pushNotification($params['user_id'],'product status change',$push_msg);
					}
					json_output($response['status'],$response);
	        	}
			}
		}
	}

	public function productBooking(){
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
					if($params['product_id'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Product value can\'t empty');
					}else {
						$productAvail = $this->ProductModel->check_product_availability($params);
	        			if(!empty($productAvail)){
	        				$response['status'] = 201;
	        				$response['message']='Please select another time slot';
	        			}else{
	        				$id = $this->ProductModel->add_booking_data($params);
	        				if(!empty($id)){
	        					
 	        					$response['message']='Product Booked';
	        					$msg = 'Your Product has been booked succesfully';
	        					/*$push_msg = "Type : Nofification \n";
               		 		  	$push_msg .= "Message : ".$msg;*/
               		 		  	$myObj['Body'] = 'Your Product has been booked succesfully';
				                $myObj['Type'] = 'Nofification';

				                $push_msg = json_encode($myObj);


	        					$user_id = $params['user_id'];
	        					$this->MyModel->pushNotification($user_id,'product booked',$push_msg);
	        				}else{
	        					$response['message']='Error in db';
	        				}
	        			}

					}
					json_output($response['status'],$response);
	        	}
			}
		}
	}

	public function confirmRejectBooking(){
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
					if($params['product_id'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Product value can\'t empty');
					}else {
	        			$resp = $this->ProductModel->confirm_reject_booking($params);
						if($params['status'] == 1){
							$response['message']='Booding Confirmed';
							$msg = 'Your booking has been Confirmed';
							$booking_title = 'booking Confirmed';
	        			}else{
	        				$response['message']='Booking Rejected';
	        				$msg = 'Your booking  has been Rejected';
	        				$booking_title = 'booking Rejected';
	        			}

	        			$myObj['Body'] = 'Your booking  has been Rejected';
                $myObj['Type'] = 'Nofification';

                $push_msg = json_encode($myObj);


	        			$user_id = $params['buyer_id'];
	        			$this->MyModel->pushNotification($user_id,$booking_title,$push_msg);
					}
					json_output($response['status'],$response);
	        	}
			}
		}
	}

	public function bookingRequestedUsers($product_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$bookingProduct = array();
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
	        	$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->ProductModel->booking_requested_user($product_id);
					if(!empty($resp)){
						foreach($resp as $rep){
							$product['product_id'] = $rep['product_id'];
							$product['product_name'] = $rep['product_name'];
							$details = json_decode($rep['details'],true);
							$product['product_address'] = $details['address'];
							$productImage = array();
							if(!empty($details['images'])){
		                        $images = explode(',',$details['images']);
		                        foreach($images as $img){
		                            $img = str_replace(array('[',']'),'',$img);
		                            $productimg['image'] = $img;
									array_push($productImage,$productimg);
		                            
		                        }
		                    }
							$product['product_image'] = $productImage;
							$product['product_owner_name'] = $details['name'];
							$product['product_owner_number'] = $details['mobile_no'];
							$product['product_details'] = $rep['details'];

							$product['user_id'] = $rep['user_id'];
							$product['user_name'] = $rep['user_name'];
							$product['user_last_name'] = $rep['user_last_name'];
							$mobile= '';
							if(!empty($rep['mobile']) && !empty($rep['country_code']) && ($rep['mobile'] != 'NA')){
								$mobile = $rep['country_code']. ' '.$rep['mobile'];
							}
							$product['user_mobile'] = $mobile;
							$product['user_email'] = $rep['user_email'];

							$userimg = '';
							if(!empty($rep['user_image']) && ($rep['user_image'] != 'NA')){
								$userimg= $rep['user_image'];
								
							}
							$product['user_profile_image'] = $rep['user_image'];
							$product['booking_address'] = $rep['address'];
							$product['booking_city'] = $rep['city'];
							$product['booking_state'] = $rep['state'];
							$product['booking_pincode'] = $rep['pincode'];
							$product['booking_doc_dl'] = $rep['doc_dl'];
							$product['booking_doc_id'] = $rep['doc_id'];
							$product['booking_user_name'] = $rep['booking_user_name'];
							$product['period'] = $rep['period'];
							$product['price_unit'] = $rep['price_unit'];
							$product['booking_status'] = $rep['status'];
							$product['payable_amount'] = $rep['payable_amount'];
							$product['booking_start_date'] = $rep['start_date'];
							$product['booking_start_time'] = $rep['start_time'];
							$product['booking_end_date'] = $rep['end_date'];
							$product['booking_end_time'] = $rep['end_time'];
							array_push($bookingProduct, $product);
						}
						$response['data']=$bookingProduct;
						$response['message']='Success';						
						json_output($response['status'],$response);	
					}else{
						json_output(201,array('status' => 201,'message' => 'No data found.'));
		        	}
				}
			}
		}
	}

	public function requestedBookingForProduct($user_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$bookingProduct = array();
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
	        	$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		 $todayDate = date('Y-m-d');
	        		$resp = $this->ProductModel->pending_booking_requested_user($user_id);
					if(!empty($resp)){
						$showRows = 'false';
						foreach($resp as $rep){
							if(($rep['status'] == '1') && ($rep['start_date'] <=$todayDate) && ($rep['end_date'] >= $todayDate)){
								$showRows = 'true';
							}else if($rep['status'] == '0'){
								$showRows = 'true';
							}
							if($showRows == 'true'){
								$product['product_id'] = $rep['product_id'];
								$product['product_name'] = $rep['product_name'];
								$details = json_decode($rep['details'],true);
								$product['product_address'] = $details['address'];
								$productImage = array();
								if(!empty($details['images'])){
			                        $images = explode(',',$details['images']);
			                        foreach($images as $img){
			                            $img = str_replace(array('[',']'),'',$img);
			                            $productimg['image'] = $img;
										array_push($productImage,$productimg);
			                            
			                        }
			                    }
								$product['product_image'] = $productImage;
								$product['product_owner_name'] = $details['name'];
								$product['product_owner_number'] = $details['mobile_no'];
								$product['product_details'] = $rep['details'];

								$product['user_id'] = $rep['user_id'];
								$product['user_name'] = $rep['user_name'];
								$product['user_last_name'] = $rep['user_last_name'];
								$mobile= '';
								if(!empty($rep['mobile']) && !empty($rep['country_code']) && ($rep['mobile'] != 'NA')){
									$mobile = $rep['country_code']. ' '.$rep['mobile'];
								}
								$product['user_mobile'] = $mobile;
								$product['user_email'] = $rep['user_email'];

								$userimg = '';
								if(!empty($rep['user_image']) && ($rep['user_image'] != 'NA')){
									$userimg= $rep['user_image'];
									
								}
								$product['user_profile_image'] = $rep['user_image'];
								$product['booking_address'] = $rep['address'];
								$product['booking_city'] = $rep['city'];
								$product['booking_state'] = $rep['state'];
								$product['booking_pincode'] = $rep['pincode'];
								$product['booking_doc_dl'] = $rep['doc_dl'];
								$product['booking_doc_id'] = $rep['doc_id'];
								$product['booking_user_name'] = $rep['booking_user_name'];
								$product['period'] = $rep['period'];
								$product['price_unit'] = $rep['price_unit'];
								$product['payable_amount'] = $rep['payable_amount'];
								$product['booking_status'] = $rep['status'];
								$product['booking_start_date'] = $rep['start_date'];
								$product['booking_start_time'] = $rep['start_time'];
								$product['booking_end_date'] = $rep['end_date'];
								$product['booking_end_time'] = $rep['end_time'];
								array_push($bookingProduct, $product);
							}
						}
						$response['data']=$bookingProduct;
						$response['message']='Success';						
						json_output($response['status'],$response);	
					}else{
						json_output(201,array('status' => 201,'message' => 'No data found.'));
		        	}
				}
			}
		}
	}

	public function deleteProduct($product_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$bookingProduct = array();
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
	        	$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->ProductModel->deleteProduct($product_id);
					json_output(200,array('status' => 201,'message' => 'Product Deleted.'));
		        	
				}
			}
		}
	}

	public function getmyproductbooking($user_id){
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'GET' || $this->uri->segment(3) == '' || is_numeric($this->uri->segment(3)) == FALSE){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$bookingProduct = array();
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
	        	$response = $this->MyModel->auth();
	        	if($response['status'] == 200){
	        		$resp = $this->ProductModel->getmyproductbooking($user_id);
	        		if(!empty($resp)){
	        			$response['data']=$resp;
						$response['message']='Success';						
						json_output($response['status'],$response);
	        		}else{
	        			json_output(201,array('status' => 201,'message' => 'No data found.'));
	        		}
										
					//json_output($response['status'],$response);	
		        	
				}
			}
		}
	}
	public function nearbysearch()
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
					if ($params['lat'] == "" || $params['lng'] == "") {
						$respStatus = 400;
						$resp = array('status' => 400,'message' =>  'Lat Long can\'t empty');
					} else {
					/*$my_file_path = "/home3/SERVERNAME/public_html/api/application/logs/nearsearch-DATA_".time().".txt";
					$myfile = fopen($my_file_path, "w") or die("Unable to open file!");
					if (file_exists($my_file)) {
							chmod($my_file, 0777);
							//echo "The file $my_file exists";
						} else {
							echo "The file $my_file does not exist";
						}
					$json_data = json_encode($params);
					fwrite($myfile, $json_data);*/
		        			$resp = $this->ProductModel->search_nearby_product($params);
							$response['status'] = 404;
		        			$response['message']='No Product Found';
		        			if(!empty($resp)){
								$response['status'] = 200;
		        				$response['message']='Success';
		        			}
								
					}
					$response['data']=$resp;										
					json_output($response['status'],$response);
		        	}
			}
		}
	}


}
