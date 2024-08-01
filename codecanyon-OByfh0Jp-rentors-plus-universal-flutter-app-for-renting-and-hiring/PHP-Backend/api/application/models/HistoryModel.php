<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HistoryModel extends CI_Model {

    public function rent_history($id)
    {
        /*return $this->db->select('*')->from('rent_hire_history')->where('user_id',$id)->order_by('id','desc')->get()->result_array();*/
         $que  = "select r.*,u.name as user_name ,p.name as product_name,p.details,p.category_id,p.sub_category_id,p.category_name,p.sub_category_name,l.status as is_like from rent_hire_history r join products p on r.product_id=p.id join users u on u.id=r.user_id join like_product l on l.product_id=p.id where r.user_id=".$id." order by r.id desc";
         $query = $this->db->query($que);
        return $query->result_array();
    }

     public function item_hired($id)
    {
        $productData = $this->db->select('*')->from('products')->where('user_id',$id)->get()->result();
        $data=array();
        foreach ($productData as $productData) {

        $this->db->select('h.*,p.name as product_name,p.details,p.category_id,p.sub_category_id,p.category_name,p.sub_category_name,bu.name as customer_name,su.name as owner_name');
        $this->db->from('products as p');
        $this->db->join('history as h', 'h.product_id = p.id','left');
        $this->db->join('users as bu', 'bu.id = h.user_id','left');
        $this->db->join('users as su', 'su.id = h.user_id','left');
        $this->db->where('p.id',$productData->id);
       
        $query = $this->db->get();
         return $query->result();
        }
        array_push($data, $productData);
    }

     public function active_products($id)
    {
        $productData = $this->db->select('*')->from('products')->order_by('id','asc')->where('user_id',$id)->get()->result();

         //$sql="SELECT * from history where end_timestamp >= CURRENT_TIMESTAMP();";  
        $data=array();
        foreach ($productData as $productData) {
           /*$sql= "SELECT h.*,p.name as product_name,p.details,p.category_id,p.sub_category_id,p.category_name,p.sub_category_name,bu.name as customer_name,su.name as owner_name FROM products as p join history as h on h.product_id = p.id join users as bu on bu.id = h.user_id join users as su on su.id = h.user_id where p.id ='.$productData->id.' or h.end_timestamp >= CURRENT_TIMESTAMP()";
            $query = $this->db->query($sql);
            return $query->result_array();*/
   
        $this->db->select('h.*,p.name as product_name,p.details,p.category_id,p.sub_category_id,p.category_name,p.sub_category_name,bu.name as customer_name,su.name as owner_name');
        $this->db->from('products as p');
        $this->db->join('history as h', 'h.product_id = p.id','left');
        $this->db->join('users as bu', 'bu.id = h.user_id','left');
        $this->db->join('users as su', 'su.id = h.user_id','left');
        $this->db->where('p.id',$productData->id);
        $this->db->or_where("(h.end_timestamp >= CURRENT_TIMESTAMP())");
        $query = $this->db->get();
        return $query->result();
        }
        array_push($data, $productData);
    }
}
