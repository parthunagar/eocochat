<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class PostRequestModel extends CI_Model {

    public function post_request_create_data($data)
    {
      $status =  $this->db->insert('post_request',$data);
	  
    if($status){
	   $insert_id = $this->db->insert_id();
	   return $this->db->select('*')->from('post_request')->where('id',$insert_id)->order_by('id','desc')->get()->row();
	  }
       else{
		   return array('status' => 500,'message' => 'Database Error.');
	   }
    }
    
}
