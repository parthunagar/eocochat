<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class WishListModel extends CI_Model {

    public function wish_list($data)
    {
      $status =  $this->db->insert('wish_list',$data);
	  if($status){
	   $insert_id = $this->db->insert_id();
	   return $this->db->select('*')->from('wish_list')->where('id',$insert_id)->order_by('id','desc')->get()->row();
	  }
       else{
		   return array('status' => 500,'message' => 'Database Error.');
	   }
    }

     public function wish_list_data($user_id)
    {
        /*$this->db->select('*');
        $this->db->from('wish_list');
        $this->db->where('wish_list.user_id',$user_id);
        $this->db->join('products', 'products.id = wish_list.product_id','left');
        $query = $this->db->get();*/
         
         /*$que  = "select w.user_id as wish_user_id,w.product_id as wish_product_id,l.status as is_like,p.* from wish_list w join products p on w.product_id=p.id join like_product l on l.product_id=p.id where w.user_id=".$user_id." order by w.id desc";*/
		 
		   $que  = "select w.user_id as wish_user_id,w.product_id as wish_product_id,p.* from wish_list w join products p on w.product_id=p.id where w.user_id=".$user_id." order by w.id desc";
        //return $this->db->$que->get()->result_array();
         $query = $this->db->query($que);
        return $query->result_array();
    }
    
    public function delete_wishlist($param)
    {
      
        $que  = "delete FROM wish_list WHERE user_id = ".$param['user_id']." AND product_id = ".$param['product_id']."";
        $query = $this->db->query($que);
        return $query;
    }
}
