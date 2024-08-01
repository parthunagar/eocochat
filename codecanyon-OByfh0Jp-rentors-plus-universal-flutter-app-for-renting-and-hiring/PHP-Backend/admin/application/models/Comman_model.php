<?php
    /**
    * 
    */
    class Comman_model extends CI_Model
    {
        
        function __construct()
        {
            parent:: __construct();
        }

        /*Get single row data*/
        public function getSingleRow()
        {
            echo 'hello';
            die();
           /* $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            $query = $this->db->get();
            return $query->row();       */
        }

        /*Update any data*/
         public function updateSingleRow($table, $where, $data)
        {
            $this->db->where($where);
            $this->db->update($table,$data);
        }
    }       