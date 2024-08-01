<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class LikeProductModel extends CI_Model {
 
    public function like_product($data)
    {
    $status =  $this->db->insert('like_product',$data);

    if($status){
	   $insert_id = $this->db->insert_id();  
	   return $this->db->select('*')->from('like_product')->where('id',$insert_id)->order_by('id','desc')->get()->row();
	  }
       else{
		   return array('status' => 500,'message' => 'Database Error.');
	   }
    }

public function unlike_product($id)
    {
        $this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $data = array(
            'status' => '0'
        );
       /* $this->db->where('user_id', $users_id);
        $this->db->wheres('product_id',$product_id);
        $this->db->update('like_product', $data);
         return true;*/
       
        $que="UPDATE like_product set status='0' where user_id='".$users_id."' AND product_id='".$id."' ";
           $query = $this->db->query($que);
            return true;

    }
}
