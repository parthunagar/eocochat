<?php

class Api
{

	var $CI;
	function __construct()
	{
		 
		$this->CI = & get_instance();

	}
	public function api_message_data($status, $message, $datatag, $data)
	 {
	     $arr = array('status' => $status, 'message' => $message, $datatag=> $data); 
	        header('Content-Type: application/json');      
	        echo json_encode($arr);
	 }

     public function api_message_data_four($status, $datatag1, $data1, $message, $datatag, $data)
     {
         $arr = array('status' => $status,  $datatag1=> $data1, 'message' => $message, $datatag=> $data); 
            header('Content-Type: application/json');      
            echo json_encode($arr);
     }

	public function api_message($status, $message)
     {
         $arr = array('status' => $status, 'message' => $message); 
            header('Content-Type: application/json');      
            echo json_encode($arr);
     }

     public function random_num($size) 
     {
        $alpha_key = '';
        $keys = range('A', 'Z');

        for ($i = 0; $i < 3; $i++) {
            $alpha_key .= $keys[array_rand($keys)];
        }

        $length = $size - 3;

        $key = '';
        $keys = range(0, 9);

        for ($i = 0; $i < $length; $i++) {
            $key .= $keys[array_rand($keys)];
        }

        return $alpha_key . $key;
    }

    public function strongToken($length = 12, $add_dashes = false, $available_sets = 'luds')
    {
        $sets = array();
        if(strpos($available_sets, 'l') !== false)
            $sets[] = 'abcdefghjkmnpqrstuvwxyz';
        if(strpos($available_sets, 'u') !== false)
            $sets[] = 'ABCDEFGHJKMNPQRSTUVWXYZ';
        if(strpos($available_sets, 'd') !== false)
            $sets[] = '23456789';
        /*if(strpos($available_sets, 's') !== false)
            $sets[] = '!@#$%&*?';*/
        $all = '';
        $password = '';
        foreach($sets as $set)
        {
            $password .= $set[array_rand(str_split($set))];
            $all .= $set;
        }
        $all = str_split($all);
        for($i = 0; $i < $length - count($sets); $i++)
            $password .= $all[array_rand($all)];
        $password = str_shuffle($password);
        if(!$add_dashes)
            return $password;
        $dash_len = floor(sqrt($length));
        $dash_str = '';
        while(strlen($password) > $dash_len)
        {
            $dash_str .= substr($password, 0, $dash_len) . '-';
            $password = substr($password, $dash_len);
        }
        $dash_str .= $password;
        return $dash_str;
	    }
	}
?>