<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ChatModel extends CI_Model {

   		public function responseFailed($status, $message){
            $arr = array('status' => $status,'message' => $message); 
            header('Content-Type: application/json');      
             echo json_encode($arr);
        }

        public function response($status, $message){
            $arr = array('status' => $status,'message' => $message); 
            header('Content-Type: application/json');      
             echo json_encode($arr);
        }
         public function responseSuccess($status, $message, $data){
            $arr = array('status' => $status,'message' => $message, 'data'=> $data); 
            header('Content-Type: application/json');      
             echo json_encode($arr); 
        }

         public function insertGetId($table,$data)
        {
            $this->db->insert($table, $data);
            return $this->db->insert_id();
        }

        public function insert($table,$data)
        {
            if($this->db->insert($table, $data))
            {
                return TRUE;
            }
            else
            {
                return FALSE;
            }
        }

          public function getSingleRow($table, $condition)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            $query = $this->db->get();
            return $query->result();       
        }

         public function getSingleRows($table, $condition)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            $query = $this->db->get();
            return $query->row();       
        }

         public function getChatData($thread_id)
      {
         /*$sql= "SELECT *
          FROM `chat`
          WHERE (`user_id` = '".$sender_id."'
          AND `user_id_receiver` = '".$receiver_id."' and  chat_state='0')
          or( `user_id` = '".$receiver_id."'
          and `user_id_receiver` = '".$sender_id."' and  chat_state='0')";*/
          $sql= "SELECT *
          FROM `chat`
          WHERE `thread_id` = '".$thread_id."'
          AND chat_state= 0";
           $query = $this->db->query($sql);          
          return $query->result();
      }
    	 public function getAllDataWhere($where, $table)
        {
            $this->db->where($where);
            $this->db->select("*");
            $this->db->from($table);
            $query = $this->db->get();          
            return $query->result();
        }

           public function getSingleRowOrderBy($table, $condition)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            $this->db->order_by('id', 'desc'); 
            $query = $this->db->get();
            return $query->row();       
        }

         public function getAllDataWhereOrWhere($where,$OrWhere, $table,$page)
        {
            $this->db->where($where);
            $this->db->or_where($OrWhere);
            $this->db->select("*");
            $this->db->from($table);
             if($page==1)
            {
               $this->db->limit(100, 0); 
            }
            else
            {
                $limit= 100*$page;
                $start= ($limit-100);
                $this->db->limit(100, $start);
            }
            $query = $this->db->get();          
            return $query->result();
        }
        public function getChatHistoryById($user_id){
          /*$que  = "select id, message, user_id,user_id_receiver, date, otherUser FROM (
          SELECT id, message,user_id, user_id_receiver, date, @row_number:=CASE WHEN @other=otherUser THEN @row_number+1 
          ELSE 1 END AS row_number,
           @other:=otherUser AS otherUser             
          FROM (
          SELECT id, message,user_id, user_id_receiver, date,
                 IF(1 = user_id, user_id_receiver, user_id) as otherUser             
          FROM chat AS m
          WHERE ".$user_id." IN (user_id,user_id_receiver) 
          ORDER BY otherUser, date DESC) t ) s
          WHERE s.row_number = 1";*/
 $sql = "Select * from chat_thread where (sender_id  =" .$user_id.") OR  (receiver_id =".$user_id. ")";



           $query = $this->db->query($sql);
        return $query->result_array();
        }

        public function getThread($sender_id,$reciever_id){
            $sql = "Select id,created_at from chat_thread where (sender_id  =" .$sender_id." AND receiver_id =".$reciever_id. ") OR  (sender_id  =" .$reciever_id." AND receiver_id =".$sender_id. ")";
            $query = $this->db->query($sql);
            if(!empty($query->row())){
              $threadData = $query->row();
              $thread_id = $threadData->id;
            }else{
              $data['sender_id'] = $sender_id;
              $data['receiver_id'] = $reciever_id;
              $data['created_at'] = date('Y-m-d h:i:s');
              $this->db->insert('chat_thread', $data);
              $thread_id = $this->db->insert_id();
            }
            return $thread_id;
        }

        public function getThreadData($sender_id,$reciever_id){
           $sql = "Select * from chat_thread where (sender_id  =" .$sender_id." AND receiver_id =".$reciever_id. ") OR  (sender_id  =" .$reciever_id." AND receiver_id =".$sender_id. ")";
            $query = $this->db->query($sql);
            if(!empty($query->row())){
              $row = $query->row();
            }else{
              $data['sender_id'] = $sender_id;
              $data['receiver_id'] = $reciever_id;
              $data['created_at'] = date('Y-m-d h:i:s');
              $this->db->insert('chat_thread', $data);
              $thread_id = $this->db->insert_id();
              $sql = "Select * from chat_thread where id =".$thread_id;;
              $query = $this->db->query($sql);
              $row = $query->row();
            }
            return $row;
        }

        public function getChatLastMsg($sender_id,$reciever_id){
             $sql = "Select * from chat where (user_id  =" .$sender_id." AND user_id_receiver=".$reciever_id. ") OR  (user_id  =" .$reciever_id." AND user_id_receiver =".$sender_id. ") ORDER BY id DESC LIMIT 1";
            $query = $this->db->query($sql);
          //  $query = $this->db->query($sql);
              $row = $query->row();
              return $row;
        }
}
