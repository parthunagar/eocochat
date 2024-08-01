<?php

class Common
{

	var $CI;
	function __construct()
	{
		 
		$this->CI = & get_instance();

	}
	public function api_message_msg($status, $message, $datatag, $data)
	 {
	     $arr = array('status' => $status, 'message' => $message, $datatag=> $data); 
	        header('Content-Type: application/json');      
	        echo json_encode($arr);
	 }
	public function api_message_false($status, $message)
     {
         $arr = array('status' => $status, 'message' => $message); 
            header('Content-Type: application/json');      
            echo json_encode($arr);
     }

    public function strongToken($length = 9, $add_dashes = false, $available_sets = 'luds')
    {
        $sets = array();
        if(strpos($available_sets, 'l') !== false)
            $sets[] = 'abcdefghjkmnpqrstuvwxyz';
        if(strpos($available_sets, 'u') !== false)
            $sets[] = 'ABCDEFGHJKMNPQRSTUVWXYZ';
        if(strpos($available_sets, 'd') !== false)
            $sets[] = '23456789';
        if(strpos($available_sets, 's') !== false)
            $sets[] = '!@#$%&*?';
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