<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Chat extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->Model('ChatModel');
    }

	public function sendmsg()
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
					$this->form_validation->set_rules('chat_type', 'chat_type', 'required');
			        if ($this->form_validation->run() == false) {
			            $this->ChatModel->responseFailed(0, "Chat type not available");
			            exit();
			        }
			        $user_id    = $this->input->post('sender_id', TRUE);
			        $media      = $this->input->post('media', TRUE);
                    $chat_type  = $this->input->post('chat_type', TRUE);
			        $thread_id  = $this->input->post('thread_id', TRUE);
			        $userStatus = $this->ChatModel->getSingleRow('users', array(
			            'id' => $user_id
			        ));
                    if (!$userStatus) {
                        $this->ChatModel->responseFailed(0, "User not Found");
                        exit();
                    }
                if (isset($chat_type)) {
                    $data['chat_type'] = $this->input->post('chat_type', TRUE);
                } else {
                    $data['chat_type'] = '1';
                }
                $data['user_id']          = $this->input->post('sender_id', TRUE);
                $data['user_id_receiver'] = $this->input->post('receiver_id', TRUE);
                $data['message']          = $this->input->post('message', TRUE);
              //  $data['sender_name']      = $this->input->post('sender_name', TRUE);
                $data['date']             = time();

                
                $reciverStatus = $this->ChatModel->getSingleRow('users', array(
                        'id' =>  $data['user_id_receiver']
                    ));
                if (!$reciverStatus) {
                        $this->ChatModel->responseFailed(0, "User not Found");
                        exit();
                    }
                $senderStatus = $this->ChatModel->getSingleRows('users', array(
                        'id' =>  $data['user_id']
                    ));
                if ($senderStatus->name) {
                 $data['sender_name']  = $senderStatus->name;
                }else{
                 $data['sender_name']  = "";
                }
               
                $this->load->library('upload');
                $config['image_library']  = 'gd2';
                $config['upload_path']    = 'assets/chat/';
                $config['allowed_types']  = 'gif|jpg|jpeg|png';
                $config['max_size']       = 10000;
                $config['file_name']      = time();
                $config['create_thumb']   = TRUE;
                $config['maintain_ratio'] = TRUE;
                $config['width']          = 250;
                $config['height']         = 250;
                $this->upload->initialize($config);
                $updateduserimage = "";
                if ($this->upload->do_upload('media') && $this->load->library('image_lib', $config)) {
                    $updateduserimage = 'assets/chat/' . $this->upload->data('file_name');
                } else {
                    //  echo $this->upload->display_errors();
                }
                if ($updateduserimage) {
                    $data['media'] = $updateduserimage;
                }

                /*$getTreadId = $this->ChatModel->getThread($data['user_id'],$data['user_id_receiver']);*/
                $data['thread_id'] = $thread_id;

              
                $chatId = $this->ChatModel->insertGetId('chat', $data);
                
               /* $push_msg[0] = "Message : ".$data['message'];
                $push_msg[1] = "Type : chat";*/

                $myObj['Body'] = $data['message'];
                $myObj['Type'] = 'Chat';
				$myObj['Thread_id'] = $thread_id;

                $push_msg = json_encode($myObj);


                $this->MyModel->pushNotification($data['user_id_receiver'],'send msg',$push_msg);

                if ($chatId) {
                    $checkUser = $this->ChatModel->getSingleRow('users', array(
                        'id' => $data['user_id']
                    ));
                    $sender    = $this->ChatModel->getSingleRow('users', array(
                        'id' => $data['user_id_receiver']
                    ));
                   // $msg = $checkUser->name . ':' . $data['message'];
                    $get_chat  = $this->ChatModel->getAllDataWhereOrWhere(array(
                        'user_id' => $data['user_id'],
                        'user_id_receiver' => $data['user_id_receiver']
                    ), array(
                        'user_id' => $data['user_id_receiver'],
                        'user_id_receiver' => $data['user_id']
                    ), 'chat', 1);
                    $get_chats = array();
                    foreach ($get_chat as $get_chat) {
                        if ($get_chat->chat_type == 2) {
                            $get_chat->media = $this->config->base_url() . $get_chat->media;
                        }
                        array_push($get_chats, $get_chat);
                    }
                    $this->ChatModel->responseSuccess(200, "Message Sent Sucessfully", $get_chats);
                } else {

                    $this->ChatModel->responseFailed(0, 'Try Again');
                }
		       }
			}
		}
	}
	

/*	public function getChat()
    {
    	$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		}else{
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];	
		        	if($response['status'] == 200){

		        	$this->form_validation->set_rules('sender_id', 'sender_id', 'required');
			        $this->form_validation->set_rules('receiver_id', 'receiver_id', 'required');
			        if ($this->form_validation->run() == false) {
			            $this->ChatModel->responseFailed(0, 'All Fields Are Mandatory');
			            exit();
			        }
			        $user_pub_id          = $this->input->post('sender_id', TRUE);
			        $page                 = $this->input->post('page', TRUE);
			        $user_pub_id_receiver = $this->input->post('receiver_id', TRUE);
			        $userStatus           = $this->ChatModel->getSingleRow('users', array(
			            'id' => $user_pub_id
			        ));
			       
			        if ($userStatus) {
			                $page     = isset($page) ? $page : 1;
			                $get_chat = $this->ChatModel->getChatData($user_pub_id, $user_pub_id_receiver);
	                if ($get_chat) {
	                    $get_chats = array();
	                    foreach ($get_chat as $get_chat) {
                        if ($get_chat->chat_type == 2) {
                            if($get_chat->media){
                                 $get_chat->media = $this->config->base_url() . $get_chat->media;
                            }else{
                            $get_chat->media = "";
                        }
                        }
                        array_push($get_chats, $get_chat);
                    }
                    $this->ChatModel->responseSuccess(200, 'Get Chat History', $get_chats);
                } else {
                    $this->ChatModel->responseFailed(0, 'No Chat History Found');
                }
            } else {
                $this->ChatModel->responseFailed(2, 'Inactivate');
            }
          }
        }
    }
  }
*/


    public function getChat($thread_id){
        $method = $_SERVER['REQUEST_METHOD'];
        if($method != 'GET'){
            json_output(400,array('status' => 400,'message' => 'Bad request.'));
        }else{
            $check_auth_client = $this->MyModel->check_auth_client();
            if($check_auth_client == true){
                $response = $this->MyModel->auth();
                $respStatus = $response['status'];  
                if($response['status'] == 200)
                {

                    /*$this->form_validation->set_rules('thread_id', 'thread_id', 'required');
                    if ($this->form_validation->run() == false) {
                        $this->ChatModel->responseFailed(0,'All Fields Are Mandatory');
                        exit();
                    }*/
                    //$thread_id = $this->input->post('thread_id', TRUE);
                    $chatData = $this->ChatModel->getChatData($thread_id);
                    if (empty($chatData)) {
                        $this->ChatModel->responseFailed(0, 'No Chat History Found');
                    } else {
                       
                        $this->ChatModel->responseSuccess(200, 'Get Chat History', $chatData);
                    }
               }
           }

        }
    }




public function getChatHistory()
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if($method != 'POST'){
            json_output(400,array('status' => 400,'message' => 'Bad request.'));
        }else{
            $check_auth_client = $this->MyModel->check_auth_client();
            $chatDataArray = array();
            if($check_auth_client == true){
                $response = $this->MyModel->auth();
                $respStatus = $response['status'];  
                if($response['status'] == 200){
                    $this->form_validation->set_rules('user_id', 'user_id', 'required');
                    if ($this->form_validation->run() == false) {
                        $this->ChatModel->responseFailed(0,'All Fields Are Mandatory');
                        exit();
                    }
                    $user_id = $this->input->post('user_id', TRUE);
                    $chatData = $this->ChatModel->getChatHistoryById($user_id);
                    if (empty($chatData)) {
                        $this->ChatModel->responseFailed(0, 'No Chat History Found');
                    } else {
                        foreach ($chatData as $value) {
                            if($value['sender_id'] == $user_id){
                                $rcv_id = $value['receiver_id'];
                            }else if($value['receiver_id'] == $user_id){
                                $rcv_id = $value['sender_id'];
                            }
                            $chat['id'] = $value['id'];
                            $chat['sender_id'] = $value['sender_id'];
                            $chat['receiver_id'] = $value['receiver_id'];
                           // echo $rcv_id. ' -------- ' ;
                            $usersData = $this->ChatModel->getSingleRow('user_profile', array(
                                    'user_id' => $rcv_id
                                ));
                                $chat['image'] = @$usersData[0]->profile_pic;
                                $chat['first_name'] = @$usersData[0]->name;
                                $chat['last_name'] = @$usersData[0]->last_name;
                                $chat['last_msg'] = "";
                                $chat['sender_name'] = "";
                                $chat['date'] = "";
                                $getLast_msg = $this->ChatModel->getChatLastMsg($value['sender_id'],$value['receiver_id']);
                                //print_r($getLast_msg);die;
                                if(!empty($getLast_msg)){
                                    $chat['last_msg'] = $getLast_msg->message;
                                    $chat['sender_name'] = $getLast_msg->sender_name;
                                    $chat['date'] = $getLast_msg->date;
                                }
                                array_push($chatDataArray, $chat);
                        }
                       
                        $this->ChatModel->responseSuccess(200, 'My Chat History', $chatDataArray);
                    }
               }
           }

        }

}



    public function getThread(){
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

                    if ($params['sender_id'] == "" && $params['receiver_id'] == "") {
                        $respStatus = 400;
                        $resp = array('status' => 400,'message' =>  'Sender id and receiver id should not be empty');
                    } else {
                        $response['message'] = "chat data";
                        $resp = $this->ChatModel->getThreadData($params['sender_id'],$params['receiver_id']); 
                        //print_r($resp);die;
                    }
                    $response['data']=$resp;                                        
                    json_output($response['status'],$response);
                    }
            }
        }
    }


  	public function getChatHistoryy()
    {
    	$method = $_SERVER['REQUEST_METHOD'];
		if($method != 'POST'){
			json_output(400,array('status' => 400,'message' => 'Bad request.'));
		}else{
			$check_auth_client = $this->MyModel->check_auth_client();
			if($check_auth_client == true){
		        	$response = $this->MyModel->auth();
		        	$respStatus = $response['status'];	
		        	if($response['status'] == 200){

        $this->form_validation->set_rules('user_id', 'user_id', 'required');
        if ($this->form_validation->run() == false) {
            $this->ChatModel->responseFailed(0,'All Fields Are Mandatory');
            exit();
        }
        $user_id = $this->input->post('user_id', TRUE);
        $chkUser = $this->ChatModel->getSingleRow('users', array(
            'id' => $user_id
        ));
        if (!$chkUser) {
            $this->ChatModel->responseFailed(0, 'User Not Found');
            exit();
        }
        $chats      = array();
        $chatsn     = array();
        $chats2     = array();
        $where      = array(
            'id' => $user_id
        );
        $userStatus = $this->ChatModel->getSingleRow('users', array(
            'id' => $user_id
        ));
        // if ($userStatus) {
                $get_users = $this->ChatModel->getAllDataWhere($where, 'chat');
                if ($get_users) {
                    foreach ($get_users as $get_users) {
                        $chat = $this->ChatModel->getSingleRowOrderBy('chat', array(
                            'user_id' => $user_id,
                            'user_id_receiver' => $get_users->user_id_receiver
                        ));
                        if ($chat) {
                            if ($user_id == $chat->user_id_receiver) {
                                $user = $this->ChatModel->getSingleRow('users', array(
                                    'id' => $chat->user_id
                                ));
                            } else {
                                $user = $this->ChatModel->getSingleRow('users', array(
                                    'id' => $chat->user_id_receiver
                                ));
                            }
                            if ($chat->chat_type == 2) {
                                $chat->media = $this->config->base_url() . $chat->media;
                            }
                          /*  if ($user->name) {
                               $chat->userName         = $user->name;
                            }else{
                               $chat->userName         = $user->email;
                            }
                         
                            $chat->user_id_receiver = $user->user_id;*/
                            array_push($chats, $chat);
                        }
                    }
                    $chatsn = array_unique($chats, SORT_REGULAR);
                }
                $chats1s   = array();
                $where     = array(
                    'user_id_receiver' => $user_id
                );
                $get_users = $this->ChatModel->getAllDataWhere($where, 'chat');
                if ($get_users) {
                    foreach ($get_users as $get_users) {
                        $chat1 = $this->ChatModel->getSingleRowOrderBy('chat', array(
                            'user_id_receiver' => $user_id,
                            'user_id' => $get_users->user_id
                        ));
                        if ($chat1) {
                            if ($user_id == $chat1->user_id_receiver) {
                                $user = $this->ChatModel->getSingleRow('users', array(
                                    'id' => $chat1->user_id
                                ));
                            } else {
                                $user = $this->ChatModel->getSingleRow('users', array(
                                    'id' => $chat1->user_id_receiver
                                ));
                            }
                            if ($chat1->chat_type == 2) {
                                $chat1->media =  $chat1->media;
                            }
                         /*   if ($user->name) {
                            	 $chat1->userName         = $user->name;
                            }else{
                            	 $chat1->userName         = "";
                            }
                           
                            $chat1->user_id_receiver = $user->id;*/
                            array_push($chats1s, $chat1);
                        }
                    }
                    $chats2 = array_unique($chats1s, SORT_REGULAR);
                }
                $chatT = array_merge($chatsn, $chats2);
                if (empty($chatT)) {
                    $this->ChatModel->responseFailed(0, 'No Chat History Found');
                } else {
                    $chatT = array_reverse($chatT);
                    array_multisort(array_column($chatT, 'id'), SORT_DESC, $chatT);
                    function super_unique($array, $key)
                    {
                      $temp_array = [];
                        foreach ($array as &$v) {
                            if (!isset($temp_array[$v->$key]))
                                $temp_array[$v->$key] =& $v;
                        }
                        $array = array_values($temp_array);
                        return $array;
                    }
                    $chatT = super_unique($chatT, 'user_id_receiver');
                    $this->ChatModel->responseSuccess(200, 'My Chat History', $chatT);
                }
         	}  
		}
	}
 }

}
