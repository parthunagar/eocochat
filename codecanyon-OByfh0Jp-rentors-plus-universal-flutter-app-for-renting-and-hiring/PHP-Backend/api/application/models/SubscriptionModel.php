<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class SubscriptionModel extends CI_Model {

   public function Subscription($type)
    {
        /*return $this->db->select('id, title, description, price, status, currency_type, DateDiff(end_date,start_date) as plan_duration')->from('subscription')->order_by('id','desc')->get()->result();*/
        $this->db->select('subscription.id, subscription.title, subscription.description, subscription.price, subscription.status, subscription.currency_type,subscription.created_at,subscription.updated_at,subscription_period.period_title as period,subscription.type');
        $this->db->from('subscription');
        $this->db->join('subscription_period', 'subscription_period.id = subscription.period');
        $wheree = array('subscription.status'=>'1','subscription.deleted'=>'0');
        if($type != 'all'){
             $this->db->where('type',$type);
        }
       
        $query =$this->db->get();
        return $query->result();

    }

    public function add($data){


         $updatedata['is_featured'] = 1;
        $updatedata['featured_at'] = date('Y-m-d h:i:s');
        //print_r($updatedata);die;
        $this->db->where('id',$data['product_id'])->update('products',$updatedata);

     /* $status =  $this->db->insert('featured_product',$data);
  	  if($status){
  	     $insert_id = $this->db->insert_id();
  	     return $this->db->select('*')->from('featured_product')->where('id',$insert_id)->order_by('id','desc')->get()->row();
  	  }else{
		     return array('status' => 500,'message' => 'Database Error.');
	    }*/
    }

    public function user_current_Subscription($userid){
        $todayDate = date('Y-m-d');
        $this->db->select('user_subscription.id,user_subscription.start_date,user_subscription.expiry_date, user_subscription.status,subscription.title as plan,subscription.description as plan_description,subscription.price as plan_price ,subscription.type as plan_type,subscription.currency_type, subscription_period.period_title as period');
        $this->db->from('user_subscription');
        $this->db->join('subscription','subscription.id = user_subscription.plan_id');
        $this->db->join('subscription_period','subscription_period.id = subscription.period');
        $this->db->where('DATE(user_subscription.start_date) <= ',$todayDate);
        $this->db->where('DATE(user_subscription.expiry_date) >= ',$todayDate);
        $this->db->where('user_subscription.user_id ',$userid);
        $this->db->where('user_subscription.status',1);
        $this->db->order_by('user_subscription.id','asc');
       $query =  $this->db->get();
       //echo $this->db->last_query();die;
       return $query->result();
    }

    public function total_user_subcription($userid){
        $this->db->select('*');
        $this->db->from('user_subscription');
        $this->db->where('user_id ',$userid);
        $this->db->where('status',1);
        $query =  $this->db->get();
        // $this->db->last_query();die;
         return $query->num_rows();

    }

    public function add_user_subscription($param){
        $this->db->select('subscription.id,subscription.period,subscription_period.period_title as period');
        $this->db->from('subscription');
        $this->db->join('subscription_period', 'subscription_period.id = subscription.period');
        $this->db->where('subscription.id',$param['package_id']);
        $query =$this->db->get();
        $periodData = $query->row();
        if(!empty($periodData)){
            $start_date = date('Y-m-d H:i:s', time());

            switch ($periodData->period) {
                case 'Week':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+1 weeks'));
                    break;
                case 'Fortnight':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+2 weeks'));
                    break;
                case 'Month':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+1 month'));
                    break;

                case '3 Months':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+3 month'));
                    break;
                case '6 Months':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+6 month'));
                    break;
                case '1 Year':
                    $end_date = date('Y-m-d H:i:s', strtotime($start_date .'+1 years'));
                    break;
            }
            $data['user_id'] = $param['user_id'];
            $data['plan_id'] = $param['package_id'];
            $data['details'] = $param['details'];
            $data['start_date'] = $start_date;
            $data['expiry_date'] = $end_date;
            $this->db->insert('user_subscription',$data);

           

            return array('status' => 200,'message' => 'User Subscription Added');

        }else{
           return array('status' => 200,'message' => 'No Package Found');
        }

    }
}
