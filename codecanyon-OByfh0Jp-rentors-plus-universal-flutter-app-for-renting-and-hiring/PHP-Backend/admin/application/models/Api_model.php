<?php
   
    class Api_model extends CI_Model
    {
        
        function __construct()
        {
            parent:: __construct();
        }

        /*Get single row data*/
        public function getSingleRow($table, $condition)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($condition);
            //$this->db->order_by('id','desc');
            $query = $this->db->get();
            return $query->row();       
        }
         /* err responce */
        public function errResponse($status, $message){
            $arr = array('status' => $status,'message' => $message); 
            header('Content-Type: application/json');      
             echo json_encode($arr);
        }

        public function getAllDataWhereConcat($where, $table)
      {
          $this->db->where($where);
          $this->db->select("id AS media_id, CONCAT('".$this->config->base_url()."', media) AS media");
          $this->db->from($table);
          $query = $this->db->get();
          return $query->result();
          //return $this->db->get()->result_array();
      }

         function getMontlyUserCount()
        {
             $sql = "set session sql_mode=''";
 $query = $this->db->query($sql);
           $sql="SELECT  DATE_FORMAT(FROM_UNIXTIME(last_login), '%b') as month, Count(*) as count FROM users WHERE FROM_UNIXTIME(last_login) >= CURDATE() - INTERVAL 1 YEAR GROUP BY Month(FROM_UNIXTIME(last_login))";  
            $query = $this->db->query($sql);
            return $query->result_array();
        }  
   
        public function getLogout($mobile,$country_code)
        {
            $sql="UPDATE user set device_token='' where mobile ='".$mobile."' and country_code='".$country_code."'";
            $query = $this->db->query($sql);
            return 1;
        }

         /*Get single row data*/
        public function getSingleRowCloumn($columnName,$table, $condition)
        {
            $this->db->select($columnName);
            $this->db->from($table);
            $this->db->where($condition);
            $query = $this->db->get();
            return $query->row();       
        }

        /*Insert and get last Id*/
        public function insertGetId($table,$data)
        {
            $this->db->insert($table, $data);
            //echo $this->db->last_query();die;
            return $this->db->insert_id();
        }
        /*Check existing record*/
        function checkData($table, $condition, $columnName)
        {
            $this->db->select($columnName);
            $this->db->from($table);
            $this->db->like($condition);
            return $this->db->count_all_results();
        }   

         /*Get All data with where clause*/
        public function getAllDataDistinct($table)
        {   
            $this->db->distinct('user_id');
            $this->db->select('user_id');
            $this->db->from($table);
            $query = $this->db->get();          
            return $query->result();
        }
        
          /*Get no of records*/
        function getCountWhere($table, $condition)
        {
            $this->db->select("*");
            $this->db->from($table);
            $this->db->where($condition);
          //  $this->db->order_by('id', 'desc');
            return $this->db->count_all_results();
        }   

         /*Get All data with limit*/
        public function getAllDataWhereLimit($table, $where)
        {
          /*  if($page==1)
            {
                $limit1=0;
                $limit2= $page*10;
            }
            else
            {
                $limit2= ($page*10);
                $limit1= $limit2-10;
            }*/

            $this->db->select("*");
            $this->db->where($where);
           // $this->db->order_by('id', 'desc');
          //  $this->db->limit($limit2, $limit1);
            $this->db->from($table);
            $this->db->order_by('id', 'asc');
            $query = $this->db->get();          
            return $query->result();
        }

        /*Check existing record*/
        function getCount($table, $condition)
        {
            $this->db->select("*");
            $this->db->from($table);
            if($table == 'user_subscription'){
                $this->db->where('DATE(start_date)',date('Y-m-d'));
            }else{
                $this->db->where($condition);
            }
            
            $this->db->count_all_results();
        }   

         /*Get no of records*/
        function getCountAll($table)
        {
            $this->db->select("*");
            $this->db->from($table);
            return $this->db->count_all_results();
        }

         /*Get All data with Limit*/
        public function getAllDataLimit($table, $limit)
        {
            $this->db->select("*");
            $this->db->from($table);
            $this->db->order_by('id', 'desc');
            $this->db->limit($limit);
            $query = $this->db->get();          
            return $query->result();
        }

         /*Get All data with Limit*/
        public function getAllDataLimitWhere($table, $where, $limit)
        {
            $this->db->select("*");//
            $this->db->from($table);
            $this->db->where($where);
            $this->db->order_by('id', 'desc');
            $this->db->limit($limit);
            $query = $this->db->get();          
            return $query->result();
        }

        /*Update any data*/
         public function updateSingleRow($table, $where, $data)
        {                 
            $this->db->where($where);
            $this->db->update($table, $data);
            //echo $this->db->last_query();die;
            if ($this->db->affected_rows() > 0)
            {
              return TRUE;
            }
            else
            {
              return FALSE;
            }
        }

        /*Add new data*/
        function insert($table,$data)
         {
            if($this->db->insert($table, $data))
            {
                if($table == 'sub_category'){
                    return $this->db->insert_id();
                }else{
                    return TRUE;    
                }
                
            }
            else
            {
                return FALSE;
            }

         }

        /*Get All data*/
        public function getAllData($table)
        {
            $this->db->select("*");
            $this->db->from($table);
            /*if($table == 'subscription_period'){

            $this->db->order_by("id", "asc");
            }else{

            $this->db->order_by("id", "desc");
            }*/
//$this->db->limit(5);
            $this->db->order_by("id", "asc");
            $query = $this->db->get();          
            // echo $this->db->last_query();die;
            return $query->result();
        }

         /*Get All data with where clause*/
        public function getAllDataWhereAndOr($where, $whereOr, $table)
        {
            $this->db->where($where);
            $this->db->or_where($whereOr);
            $this->db->select("*");
            $this->db->from($table);
            $this->db->order_by("id", "desc");
            $query = $this->db->get();          
            return $query->result();
        }

        /*Get All data with where clause*/
        public function getAllDataWhere($where, $table)
        {
            $this->db->where($where);
            $this->db->select("*");
            $this->db->from($table);
             //$this->db->order_by("id", "desc");
            $query = $this->db->get();          
            return $query->result();
        }
  
         /*Get All data with where clause*/
        public function getAllDataWhereNot($where, $table)
        {
            $this->db->where($where);
            $this->db->where('post_type !=', 0);
            $this->db->select("*");
            $this->db->from($table);
            $query = $this->db->get();          
            return $query->result();
        }

         // Count avarage 
        public function getAvgWhere($columnName, $table,$where)
        {
            $this->db->select_avg($columnName);
            $this->db->from($table);
            $this->db->where($where);
            $query =$this->db->get(); 
            return $query->result(); 
        }

         // Count avarage 
        public function getTotalWhere($table,$where)
        {
            $this->db->from($table);
            $this->db->where($where);
            $query =$this->db->get(); 
            return $query->num_rows(); 
        }

         // get sum 
        public function getSum($columnName, $table)
        {
            $this->db->select_sum($columnName);
            $this->db->from($table);
            $query =$this->db->get(); 
            return $query->result(); 
        }

        // get sum 
        public function getSumWhere($columnName, $table, $where)
        {
            $this->db->select_sum($columnName);
            $this->db->from($table);
            $this->db->where($where);
            $query =$this->db->get(); 
            return $query->row(); 
        }

         public function deleteRecord($where, $table)
        {
            $this->db-> where($where);
            $query = $this->db->delete($table);  
        } 
        
        public function getNearestData($lat,$lng,$table)
        {
            $this->db->select("*, ( 3959 * acos( cos( radians($lat) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( latitude ) ) ) ) AS distance");
            $this->db->from($table); 
            $this->db->having('distance <= ', '1');                    
            $this->db->order_by('distance');                    
            $this->db->limit(1, 0);
            $query =$this->db->get(); 
            return $query->row(); 
        }

        public function getNearestDataWhere($lat,$lng,$table,$where,$user_id,$distance)
        {
            $this->db->select("*, ( 3959 * acos( cos( radians($lat) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( latitude ) ) ) ) AS distance");
            $this->db->from($table); 
            $this->db->where($where);
            $this->db->where('user_id !=', $user_id);
            $this->db->having('distance <= ', $distance);                    
            $this->db->order_by('distance');                    
            $this->db->limit(1, 0);
            $query =$this->db->get(); 
            return $query->result(); 
        }

        public function getWhereInStatus($table,$where,$columnName, $where_in)
        {
            $this->db->select('*');
            $this->db->from($table);
            $this->db->where($where);
            $this->db->where_in($columnName, $where_in);
            $this->db->order_by('id', 'desc');
            $query =$this->db->get(); 
            return $query->row();
        }

        public function get_subcription($where){
            $this->db->select('subscription.id,subscription.title,subscription.no_of_products,subscription.description,subscription.type,subscription.price,subscription.period,subscription.currency_type,subscription.status,subscription_period.period_title');
            $this->db->from('subscription');
            $this->db->join('subscription_period', 'subscription_period.id = subscription.period');
            $wheree = array('subscription.status'=>'1','subscription.deleted'=>'0');
           // $this->db->where($wheree);
             if(!empty($where)){
                 $this->db->where($where);
                
            }
            $query =$this->db->get();
           // echo  $this->db->last_query();die;

            //return $query->row();
            return $query->result();
        }

        public function getAllUserData($table,$status){
            $this->db->select('users.id, users.name,users.email,user_profile.mobile,users.status,user_profile.country_code,user_profile.address,user_profile.city,user_profile.state,user_profile.national_id_proof,user_profile.pincode,user_profile.address_proof,user_profile.is_verified');
            $this->db->from('users');
            $this->db->join('user_profile', 'user_profile.user_id = users.id');
            if($status != ''){
                $wheree = array('users.status'=>$status);
                $this->db->where($wheree);
            }
            $query =$this->db->get();
            $this->db->order_by('users.id','ASC');
            //echo $this->db->last_query();die;
            return $query->result();
        }

        public function getAllPaySubsriptionData(){
            $this->db->select('users.name,users.email,user_profile.mobile,users.status,user_profile.country_code, subscription.title,pay_subscription_log.amount,pay_subscription_log.currency,pay_subscription_log.client_secret');
            $this->db->from('pay_subscription_log');
            $this->db->join('users', 'users.id = pay_subscription_log.user_id');
            $this->db->join('user_profile', 'user_profile.user_id = pay_subscription_log.user_id');
            $this->db->join('subscription', 'subscription.id = pay_subscription_log.package_id');
            $this->db->order_by('pay_subscription_log.id','ASC');
            $query =$this->db->get();
           // echo $this->db->last_query();die;

            return $query->result();
        }
        public function getUserSubscription($type){
             $this->db->select('user_subscription.id,user_subscription.start_date,user_subscription.expiry_date, user_subscription.user_id,user_subscription.plan_id,user_subscription.details,subscription.title,users.name,users.email, user_profile.mobile,user_profile.country_code,subscription.type');
            $this->db->from('user_subscription');
            $this->db->join('subscription','subscription.id = user_subscription.plan_id');
            $this->db->join('users','users.id = user_subscription.user_id');
            $this->db->join('user_profile','user_profile.user_id = user_subscription.user_id');
            $this->db->where('user_subscription.status',1);
            $this->db->where('subscription.type',$type);
            $this->db->order_by('user_subscription.id','ASC');
            $query =  $this->db->get();
           // echo $this->db->last_query();die;
            return $query->result();
        }

        public function get_pending_products(){
            $this->db->select('products.name,products.details,users.name as user_name,users.email');
            $this->db->from('products');
            $this->db->join('users','users.id = products.user_id');
            $this->db->where('products.status',0);
            $query =  $this->db->get();
            //echo $this->db->last_query();die;
            return $query->result();
        }

        public function get_products_count($statuss = ''){
            $this->db->select('*');
            $this->db->from('products');
            if(!empty($statuss) && ($statuss == 'confirm')){
                $this->db->where('status',1);
            }else if(!empty($statuss) && ($statuss == 'pending')){
                $this->db->where('status',0);
            }else{

            }
            $this->db->where('is_delete','0');
            $query =  $this->db->get();   
            return $query->num_rows();
        }

        public function get_user_subscription($type){
            $this->db->select('user_subscription.id,user_subscription.start_date,user_subscription.expiry_date, user_subscription.user_id,user_subscription.plan_id,user_subscription.details,subscription.title,users.name,users.email, user_profile.mobile,user_profile.country_code');
            $this->db->from('user_subscription');
            $this->db->join('subscription','subscription.id = user_subscription.plan_id');
            $this->db->join('users','users.id = user_subscription.user_id');
            $this->db->join('user_profile','user_profile.user_id = user_subscription.user_id');
            $this->db->where('user_subscription.status',1);
            if($type =='active'){
                //$this->db->limit(2);
            }
            if($type == 'all'){
                $this->db->where('DATE(start_date)',date('Y-m-d'));
            }
            $this->db->order_by('user.subscription','DESC');
            $query =  $this->db->get();
            echo $this->db->last_query();
            if($type =='active'){
                return $query->result();
            }else{
                return $query->num_rows();
            }
            
        }

        public function booking_requested_user($status){
            $this->db->select('products.id as product_id,products.name as product_name,users.id as user_id,users.name as user_name,user_profile.last_name as user_last_name, user_profile.mobile,user_profile.country_code, users.email as user_email,booking_product.price_unit,booking_product.period,booking_product.status,booking_product.payable_amount');
            $this->db->from('booking_product');
            $this->db->join('products', 'products.id = booking_product.product_id ', 'left'); 
            $this->db->join('users', 'users.id = booking_product.user_id ', 'left'); 
            $this->db->join('user_profile', 'user_profile.user_id = booking_product.user_id ', 'left'); 
            if($status!= ''){
               $this->db->where('booking_product.status',$status);
            }
                $this->db->where('booking_product.status !=',2);
            $this->db->order_by('booking_product.id','ASC');
            $query = $this->db->get();

            //echo $this->db->last_query();die;
            return $query->result_array();
        }

        public function getProductOwnerInfo($user_id){
            $this->db->select('users.name,users.email,user_profile.mobile,user_profile.country_code');
            $this->db->from('users');
            $this->db->join('user_profile', 'user_profile.user_id = user_profile.user_id ', 'left'); 
            $this->db->where('users.id',$user_id);
            //$this->db->where('booking_product.product_id',$product_id);
            $query = $this->db->get();
           // echo $this->db->last_query();die;
            return $query->row();
        }

        public function get_today_subscription_count(){

        }

        public function getAllcmplaints($type){
            $this->db->select('user_complaint.id as c_id,user_complaint.title as title,user_complaint.complaint,users.id as user_id,users.name as user_name,user_profile.last_name as user_last_name, user_profile.mobile,user_profile.country_code, users.email as user_email');
            $this->db->from('user_complaint');
            $this->db->join('users', 'users.id = user_complaint.user_id ', 'left'); 
            $this->db->join('user_profile', 'user_profile.user_id = user_complaint.user_id ', 'left'); 
            if($type == 4){
                $this->db->limit(4);
            }
            if($type == 'new'){
                $this->db->where('Date(user_complaint.created_at)',date('Y-m-d'));
            }
            $this->db->order_by('user_complaint.id','ASC');
            $query = $this->db->get();
            //echo $this->db->last_query();die;
            return $query->result_array();
        }

        public function getCountPendingProducts($type){
            $this->db->select('id');
            $this->db->from('products');
            if($type == 'pending'){
                $this->db->where('status','0');
                $this->db->where('Date(created_at)',date('Y-m-d'));
            }else if($type == 'today_feature'){
                $this->db->where('is_featured','1');
                $this->db->where('Date(featured_at)',date('Y-m-d'));
            }else if($type == 'today_product_new'){
                $this->db->where('Date(created_at)',date('Y-m-d'));
            }else{
                $this->db->where('is_featured','1');
            }
            $query = $this->db->get();
            return $query->num_rows();
        }

        public function getSubscribedUser($type){
            $this->db->select('ifnull(users.name,"") as user_name,Date(user_subscription.start_date) as start_date,Date(user_subscription.expiry_date) as expiry_date,user_profile.last_name as user_last_name, user_profile.mobile,user_profile.country_code');
            $this->db->from('user_subscription');
            $this->db->join('users', 'users.id = user_subscription.user_id ', 'left'); 
            $this->db->join('user_profile', 'user_profile.user_id = user_subscription.user_id ', 'left'); 
            if($type == 'user'){
                $this->db->limit(2);
                $this->db->order_by('user_subscription.id','DESC');
            }else if($type == 'user_count'){
                $this->db->group_by('user_subscription.user_id');
            }
            $query = $this->db->get();
            return $query->result_array();
        }

        public function getExpiredSubscribedUsers(){
            $sql = 'SELECT ifnull(users.name,"") as user_name,Date(user_subscription.start_date) as start_date,Date(user_subscription.expiry_date) as expiry_date,user_profile.last_name as user_last_name, user_profile.mobile,user_profile.country_code FROM user_subscription LEFT JOIN `users` ON `users`.`id` = `user_subscription`.`user_id` LEFT JOIN `user_profile` ON `user_profile`.`user_id` = `user_subscription`.`user_id`  WHERE user_subscription.expiry_date >= DATE(now()) AND user_subscription.expiry_date <= DATE_ADD(DATE(now()), INTERVAL 7 DAY) LIMIT 2';
              $query = $this->db->query($sql);
            return $query->result_array();
        }


        public function getBookedProductExpiry(){
             $sql = 'SELECT booking_product.product_id,DATE(booking_product.start_date) as start_date, DATE(booking_product.end_date) as expiry_date,products.name as product_name,products.is_featured FROM booking_product LEFT JOIN `products` ON `products`.`id` = `booking_product`.`product_id`  WHERE products.is_featured = 1 AND  booking_product.end_date >= DATE(now()) AND booking_product.end_date <= DATE_ADD(DATE(now()), INTERVAL 7 DAY) LIMIT 2';
             //echo $sql;die;
              $query = $this->db->query($sql);
            return $query->result_array();
        }


        public function getBookedProduct($type){
            $this->db->select('booking_product.product_id,DATE(booking_product.start_date) as start_date, DATE(booking_product.end_date) as expiry_date,products.name as product_name,products.is_featured');
            $this->db->from('booking_product');
             $this->db->join('products', 'products.id = booking_product.product_id ', 'left'); 
            if($type == 'booking'){
                $this->db->limit(2);
                $this->db->order_by('booking_product.id','DESC');
                $this->db->where('products.is_featured','1');
            }else if($type == 'product_booking_count'){
                $this->db->group_by('booking_product.user_id');
            }
            $query = $this->db->get();
            return $query->result_array();
            //echo $this->db->last_query();die;
        }

        public function get_revenue_data($type){

            $this->db->select('user_subscription.id as usub_id,user_subscription.start_date,subscription.id, IFNULL(SUM(subscription.price), "0") as total,subscription.currency_type');
            $this->db->from('user_subscription');
            $this->db->join('subscription', 'subscription.id = user_subscription.plan_id ', 'left'); 
            if($type == 'month'){
                $this->db->where('user_subscription.start_date BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()');
                $this->db->where('DATE(user_subscription.start_date) BETWEEN DATE_SUB(NOW(), INTERVAL 1 MONTH) AND NOW()');
            }else if($type == 'week'){
                //$this->db->where('user_subscription.start_date BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()');
               // $this->db->where('DATE(user_subscription.start_date) <=', 'DATE_SUB(CURDATE(), INTERVAL 7 DAY)');
                $this->db->where('DATE(user_subscription.start_date) BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()');
            }
            else if($type == 'year'){
                //$this->db->where('user_subscription.start_date BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()');
               // $this->db->where('DATE(user_subscription.start_date) <=', 'DATE_SUB(CURDATE(), INTERVAL 7 DAY)');
                $this->db->where('DATE(user_subscription.start_date) BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW()');
            }else if($type == 'total'){
                
            }
            
            //$this->db->group_by('subscription.currency_type');
            $query = $this->db->get();
            //echo $this->db->last_query();die;
            if ($query->num_rows() > 0) {
                return $query->result();
            } else {
                return 0;
            }
        }

        public function getTodaysUser(){
            $this->db->select('id');
            $this->db->from('users');
            $this->db->where('Date(created_at)',date('Y-m-d'));
            $query = $this->db->get();
            return $query->num_rows();
        }

        public function getAllDataProduct(){
            $this->db->select('products.*,category.name as category_name,category.id as cat_id,sub_category.name as sub_cat_name,sub_category.id as sub_cat_id');
            $this->db->from('products');
            $this->db->join('category', 'category.id = products.category_id ', 'left'); 
            $this->db->join('sub_category', 'sub_category.id = products.sub_category_id ', 'left'); 
            $this->db->order_by('products.id','asc');
            
            $query = $this->db->get();
            return $query->result_array();
        }

        public function getRenterRenteeDetails($id){
            $this->db->select('id');
            $this->db->from('products');
            $this->db->where('user_id',$id);
            $query = $this->db->get();
            return $query->result_array();
        }

        //adegame code
         public function getUserSubscriptionForRequest(){
            $this->db->select('user_subscription.id,user_subscription.start_date,user_subscription.expiry_date, user_subscription.user_id,user_subscription.plan_id,user_subscription.details,subscription.title,users.name,users.email, user_profile.mobile,user_profile.country_code,subscription.type');
            $this->db->from('user_subscription');
            $this->db->join('subscription','subscription.id = user_subscription.plan_id');
            $this->db->join('users','users.id = user_subscription.user_id');
            $this->db->join('user_profile','user_profile.user_id = user_subscription.user_id');
            $this->db->where('user_subscription.status',2);
            $this->db->order_by('user_subscription.id','DESC');
            $query =  $this->db->get();
           // echo $this->db->last_query();die;
            return $query->result();
        }

         public function getAllDataProductRequestsFeature(){
            $this->db->select('products.*,category.name as category_name,category.id as cat_id,sub_category.name as sub_cat_name,sub_category.id as sub_cat_id');
            $this->db->from('products');
            $this->db->join('category', 'category.id = products.category_id ', 'left'); 
            $this->db->join('sub_category', 'sub_category.id = products.sub_category_id ', 'left'); 
            $this->db->where('products.is_featured', '2');
            $this->db->where('products.is_delete', '0');
            $this->db->order_by('products.id','asc');
            
            $query = $this->db->get();
            return $query->result_array();
        }

        public function getUserAllDetails($id){
            $this->db->select('users.id, user_profile.name,user_profile.profile_pic, user_profile.last_name ,users.email,user_profile.mobile,users.status,user_profile.country_code, user_profile.address,user_profile.city,user_profile.state,user_profile.national_id_proof,user_profile.pincode,user_profile.address_proof,user_profile.is_verified');
            $this->db->from('users');
            $this->db->join('user_profile', 'user_profile.user_id = users.id');
            $this->db->where('users.id',$id);
            $query =$this->db->get();
            return $query->row();
        }
    }           