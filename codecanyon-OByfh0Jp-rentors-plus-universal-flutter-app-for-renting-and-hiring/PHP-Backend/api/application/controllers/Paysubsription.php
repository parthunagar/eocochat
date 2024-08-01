<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH.'/stripe-php-7.33.1/init.php');
// This is a sample test API key. Sign in to see examples pre-filled with your key.

\Stripe\Stripe::setApiKey('');

class paysubsription extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        
    }

	public function index()
	{
		header('Content-Type: application/json');
		$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		} else {
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
				$params = json_decode(file_get_contents('php://input'), TRUE);
		        	$user_id = $params['user_id'];
				    $package_id = $params['package_id'];
				    $note = @$params['note'];
				    if(!empty($user_id) && !empty($package_id)){
				    	$subscriptionData = $this->MyModel->getSingleRow('subscription',array('id'=>$package_id));
				    	if(!empty($subscriptionData)){
				    		//print_r($subscriptionData);die;
				    		$amount = $subscriptionData->price;
				    		$amount = $amount*100;
				    		$currency_type = $subscriptionData->currency_type;
				    		$paymentIntent = \Stripe\PaymentIntent::create([
								'amount' => $amount,
								'currency' => $currency_type,
								'payment_method_options' => [
					            		"card" => [
					              		"request_three_d_secure" => "any"
				            		]
			        	    	],

							  ]);
				    		//print_r($paymentIntent);die;

							  $output = [

								'clientSecret' => $paymentIntent->client_secret,

							  ];

							  $payData['user_id'] = $user_id;
							  $payData['package_id'] = $package_id;
							  $payData['amount'] = $amount;
							  $payData['currency'] = $currency_type;
							  $payData['note'] = $note;
							  $payData['client_secret'] = $paymentIntent->client_secret	;
							  $payData['created_at'] = time();
							  $this->MyModel->addPaySubscription($payData);

							 // echo json_encode($output);
							  json_output(200,array('message'=>'Success','data'=>$output));
				    	}else{
				    		json_output(200,array('status' => 200,'message' => 'Package not found'));
				    	}
				    }else{
				    	json_output(200,array('status' => 200,'message' => 'Required User id and Package Id'));
				    }



			}
		}
	}
	
    function calculateOrderAmount(array $items): int {

	  // Replace this constant with a calculation of the order's amount

	  // Calculate the order total on the server to prevent

	  // customers from directly manipulating the amount on the client

	  return 1400;

}

	

}
