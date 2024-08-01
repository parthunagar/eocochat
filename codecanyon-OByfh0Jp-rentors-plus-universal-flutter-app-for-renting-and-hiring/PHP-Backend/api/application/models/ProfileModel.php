<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ProfileModel extends CI_Model {

    public function profile_all_data()
    {
		//echo $this->input->get('param2');die;
        $result=  $this->db->select('*')->from('user_profile')->order_by('id','desc')->get()->result();
		return array('status' => 200,'message' => 'Success','data' => $result);
    }

    public function profile_detail_data($id)
    {
       // return $this->db->select('*')->from('user_profile')->where('user_id',$id)->order_by('id','desc')->get()->row();
        $this->db->select('user_profile.*,users.email');
        $this->db->from('user_profile');
        $this->db->join('users', 'users.id = user_profile.user_id ', 'left'); 
        $this->db->where('user_profile.user_id',$id);
        $query = $this->db->get();
       // echo $this->db->last_query();die;
        return $query->row();



    }

    public function profile_update_data($id,$data)
    {

        $uProfile['name'] = $data['name'];
        $uProfile['last_name'] = $data['last_name'];
        $uProfile['profile_pic'] = $data['profile_pic'];
        $uProfile['country_code'] = $data['country_code'];
        $uProfile['mobile'] = $data['mobile'];
        $uProfile['address'] = $data['address'];
        $uProfile['city'] = $data['city'];
        $uProfile['state'] = $data['state'];
        $uProfile['pincode'] = $data['pincode'];
        $uProfile['national_id_proof'] = $data['national_id_proof'];
        $uProfile['is_verified'] = 0;
        $this->db->where('user_id',$id)->update('user_profile',$uProfile);

        $userData['email'] = $data['email'];
        $userData['name'] = $data['name'];
        $this->db->where('id',$id)->update('users',$userData);
	    //return	$this->db->select('*')->from('user_profile')->where('user_id',$id)->order_by('id','desc')->get()->row();
        //return array('status' => 200,'message' => 'Data has been updated.');
        $this->db->select('user_profile.*,users.email');
            $this->db->from('user_profile');
            $this->db->join('users', ' users.id = user_profile.user_id ', 'left outer'); 
            $this->db->where('users.id',$id);
            $query = $this->db->get();
           //echo $this->db->last_query();die;
            $result =  $query->row();
            return $result;
    }

     public function checkEmailAddress($email,$id){
          $this->db->select("*");
          $this->db->where('email',$email);
          $this->db->where('id !=',$id);
          $this->db->from('users');
          $query = $this->db->get();          
          return $query->result();
      }


}
