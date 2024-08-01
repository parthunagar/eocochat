<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ReviewModel extends CI_Model {

    public function addReview($data)
    {
      $status =  $this->db->insert('review',$data);
	  
      if($status){
	      $insert_id = $this->db->insert_id();
	      return $this->db->select('*')->from('review')->where('id',$insert_id)->order_by('id','desc')->get()->row();
	    }
       else{
		   return array('status' => 500,'message' => 'Database Error.');
	   }
    }
    	
  public function review_data($product_id)
    {
    	/*return $this->db->select('*')->from('review')->where('product_id',$product_id)->order_by('id','desc')->get()->result_array();
*/
         /*$que  = "select r.*,u.name as user_name ,p.name as product_name from review r join products p on r.product_id=p.id join users u on u.id=r.user_id where r.product_id=".$product_id." order by r.id desc";
         $query = $this->db->query($que);
        return $query->result_array();*/

        $this->db->select('review.user_id,review.star as ratting, review.comment as review,review.created_at,users.name,users.email,user_profile.profile_pic');   
        $this->db->from('review');   
        $this->db->join('users', 'users.id = review.user_id','left');
        $this->db->join('user_profile', 'user_profile.user_id = review.user_id','left');
        $this->db->where('product_id',$product_id);  
        $this->db->order_by('review.id','asc'); 
        $query = $this->db->get();
        //echo $this->db->last_query();die;
        return $query->result_array ();
    }


    public function addRequestReview($param){
        $data['receiver_user_id'] = $param['receiver_user_id'];
        $data['product_id'] = $param['product_id'];
        $data['created_at'] = date('Y-m-d h:i:s');
        $status =  $this->db->insert('request_review',$data);
        return $status;
    }
}
