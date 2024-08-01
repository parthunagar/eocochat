<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class NotificationModel extends CI_Model {

   public function notification_all_data()
    {
        return $this->db->select('*')->from('notifications')->order_by('id','desc')->get()->result();
    }
    
    public function notification_detail_data($id)
    {
        return $this->db->select('*')->from('notifications')->where('user_id',$id)->order_by('id','asc')->get()->result_array();
    }
}
