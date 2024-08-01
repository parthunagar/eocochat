<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ProductModel extends CI_Model {

   public function product_all_data()
    {
        return $this->db->select('*')->from('products')->order_by('id','asc')->get()->result();
    }
    public function product_detail_data($id,$lat,$lon)
    {
        $this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        /* return $this->db->select('*')->from('products')->where('id',$id)->order_by('id','desc')->get()->row();*/
        $this->db->select('products.*,IFNULL(wish_list.status , "0") as is_like,user_profile.name as user_name,user_profile.profile_pic as user_image,IFNULL(FLOOR(avg(review.star)), "0")  as avg_ratting,sub_category.verification_required');
        $this->db->from('products');
        $this->db->join('wish_list', 'wish_list.product_id = products.id','left');
        $this->db->join('sub_category', 'sub_category.id = products.sub_category_id','left');
        $this->db->join('review', 'review.product_id = products.id','left');
        $this->db->join('user_profile', 'user_profile.user_id = products.user_id','left');
        $this->db->where('products.id',$id);
        $query = $this->db->get();
         $results = $query;
    $radius = 500;

     $filteredss = [];
      $resultt = [];
      foreach( $results->result() as $resultt ) {

            $distance = $this->getDistanceBetweenPointsNew( $lat, $lon, $resultt->lat, $resultt->lng, 'Mi' );
            if(!empty($distance)){
                $resultt->distance = json_encode($distance);
                $filteredss = $resultt;

            }else{
                $resultt->distance = '0';
                $filteredss = $resultt;
            }
        
      }

    return $filteredss;
    }

    public function review_detail_data($id)
    {
        $this->db->select('review.user_id,review.star as ratting, review.comment as review,review.created_at, 
            IFNULL(users.name,"") as name,IFNULL(users.email,"") as email,IFNULL(user_profile.profile_pic,"") as profile_pic');   
        $this->db->from('review');   
        $this->db->join('users', 'users.id = review.user_id','left');
        $this->db->join('user_profile', 'user_profile.user_id = review.user_id','left');
        $this->db->where('product_id',$id);   
        $query = $this->db->get();
        //echo $this->db->last_query();die;
        return $query->result_array ();
    }
    public function product_by_category($category_id)
    {
        return $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','asc')->get()->result_array();
    }


     public function product_by_subcategory($sub_category_id,$page)
    {
    	$this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $data =array();
        $recommended_product_results = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category_id)->order_by('id','asc')->limit(5)->get()->result();

          $recommended_product_result =array();
        foreach ($recommended_product_results as $recommended_product_results) {
        $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$recommended_product_results->id)->get()->result();
			if(empty($like_result)){
				$recommended_product_results->is_like=0;
				}else{
					$recommended_product_results->is_like=$like_result[0]->status;
			}
     
			array_push($recommended_product_result, $recommended_product_results);
		}
        $data['recommended_product']= $recommended_product_result;

        $near_product_results = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category_id)->order_by('id','asc')->limit(5)->get()->result();

        $near_product_result =array();
        foreach ($near_product_results as $near_product_results) {
        $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$near_product_results->id)->get()->result();
			if(empty($like_result)){
				$near_product_results->is_like=0;
				}else{
					$near_product_results->is_like=$like_result[0]->status;
			}
			array_push($near_product_result, $near_product_results);
		}
        $data['near_product']= $near_product_result;
        
        $product_results = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category_id)->order_by('id','asc')->offset($page)->limit(10)->get()->result();
        //echo $this->db->last_query();die;

          $product_result =array();
        foreach ($product_results as $product_results) {
        $like_result=$this->db->select('*')->from('wish_list')->where('user_id',$users_id)->where('product_id',$product_results->id)->get()->result();
			if(empty($like_result)){
				$product_results->is_like=0;
				}else{
					$product_results->is_like=$like_result[0]->status;
			}
			array_push($product_result, $product_results);
		}
        $data['product']= $product_result;
       
        return $data;
    }

       public function product_by_user($user_id)
    {
        return $this->db->select('*')->from('products')->where('user_id',$user_id)->where('is_delete','0')->order_by('id','asc')->get()->result_array();
       /* $this->db->select('products.*,like_product.status as is_like');

        $this->db->from('products');
        $this->db->join('like_product', 'like_product.product_id = products.id','left');
        $this->db->where('products.user_id',$user_id);
        $query = $this->db->get();
         return $query->result_array();*/
    }

    public function product_by_productId($product_id){
        return $this->db->select('product_id')->from('products')->where('product_id',$product_id)->get()->result_array();
    }

    public function product_create_data($data)
    {
        $pId = 'R'.rand(0,9).rand(0,9).rand(0,9).rand(0,9).rand(0,9);
        $pdata = $this->product_by_productId($pId);
        if(empty($pdata)){
            $product_id = $pId;
        }else{
            $product_id = 'R'.rand(0,9).rand(0,9).rand(0,9).rand(0,9).rand(0,9);
        }
        $data["product_id"] = $product_id;


        //print_r($data);die;
         $status =  $this->db->insert('products',$data);
	  if($status){
	   $insert_id = $this->db->insert_id();
	   return $this->db->select('*')->from('products')->where('id',$insert_id)->order_by('id','desc')->get()->row();
	  }
       else{
		   return array('status' => 500,'message' => 'Database Error.');
	   }
    }

    public function product_update_data($id,$data)
    {
    	$this->input->request_headers();
        $users_id  = $this->input->get_request_header('User-ID', TRUE);

       	$this->db->where('id',$id)->update('products',$data);

        $this->db->select('products.*,like_product.status as is_like');
        $this->db->from('products');
        $this->db->join('like_product', 'like_product.product_id = products.id','left');
        $this->db->where('products.id',$id);
        $query = $this->db->get();
        return $query->row ();

	  /* return $this->db->select('*')->from('products')->where('id',$id)->order_by('id','desc')->get()->row();*/
        //return array('status' => 200,'message' => 'Data has been updated.');
    }
    public function product_delete_data($id)
    {
       return $this->db->where('id',$id)->delete('products');
        //return array('status' => 200,'message' => 'Data has been deleted.');
    }

   /* public function search_product($param){
      $value = $param['value'];
      $user_id = $param['user_id'];
        return $this->db->select('*')->from('products')->where('user_id!=',$user_id)->where("name LIKE '%$value%'")->order_by('id','desc')->get()->result_array();

     // return $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','desc')->get()->result_array();
    }*/

    public function change_status($param){
        $data['status'] = $param['status'];
        $id = $param['product_id'];
        $where = array('id'=>$id,'user_id'=>$param['user_id']);
        $this->db->where($where)->update('products',$data);
        
    }
    public function check_product_availability($param){
        $start_date = $param['date_from'];
        $end_date = $param['date_to'];
        $this->db->select("*");
        $this->db->from('booking_product');
        $this->db->where('Date(start_date) >=',date("Y-m-d", strtotime($start_date)));
        $this->db->where('Date(end_date) <=',date("Y-m-d", strtotime($end_date)));
        $this->db->where('status',1);
        $query = $this->db->get();
        //echo $this->db->last_query();die;
        return $query->result_array();
    }
    public function add_booking_data($param){
        $insert_id = '';
        $data = array(
            'product_id' => $param['product_id'],
            'user_id' => $param['user_id'],
            'start_date' => date("Y-m-d", strtotime($param['date_from'])),
            'end_date' => date("Y-m-d", strtotime($param['date_to'])),
            'address' => $param['address'],
            'city' => $param['city'],
            'state' => $param['state'],
            'pincode' => $param['pincode'],
            'start_time' => $param['time_from'],
            'end_time' => $param['time_to'],
            'doc_dl' =>$param['doc_dl'],
            'doc_id' =>$param['doc_id'],
            'price_unit' =>$param['price_unit'],
            'period' =>$param['period'],
            'booking_user_name' =>$param['name'],
            'payable_amount' =>$param['payable_amount'],
            'booking_date' => date('Y-m-d'),
        );

        $this->db->insert('booking_product',$data);
        $insert_id = $this->db->insert_id();
        return $insert_id;
    }


    public function confirm_reject_booking($param){
        $data['status'] = $param['status'];
        $id = $param['product_id'];
        $where = array('product_id'=>$id,'user_id'=>$param['buyer_id']);
        $this->db->where($where)->update('booking_product',$data);
    }

    public function booking_requested_user($product_id){
        $this->db->select('products.id as product_id,products.name as product_name,products.details,users.id as user_id,users.name as user_name,user_profile.last_name as user_last_name,user_profile.profile_pic as user_image,user_profile.mobile,user_profile.country_code,users.email as user_email,booking_product.address,booking_product.city,booking_product.state,booking_product.pincode,booking_product.doc_dl,booking_product.doc_id,booking_product.price_unit,booking_product.period,booking_product.status,booking_product.start_date,booking_product.end_date,booking_product.start_time,booking_product.end_time,booking_product.payable_amount,booking_product.booking_user_name');
        $this->db->from('booking_product');
        $this->db->join('products', 'products.id = booking_product.product_id ', 'left'); 
        $this->db->join('users', 'users.id = booking_product.user_id ', 'left'); 
        $this->db->join('user_profile', 'user_profile.user_id = booking_product.user_id ', 'left'); 
        $this->db->where('booking_product.product_id',$product_id);
        $this->db->order_by('booking_product.id','asc');
        $query = $this->db->get();
        return $query->result_array();

    }

    public function pending_booking_requested_user($user_id){

         $this->db->select('products.id as product_id,products.name as product_name,products.details,users.id as user_id,users.name as user_name,user_profile.last_name as user_last_name,user_profile.profile_pic as user_image,user_profile.mobile,user_profile.country_code,users.email as user_email,booking_product.address,booking_product.city,booking_product.state,booking_product.pincode,booking_product.doc_dl,booking_product.doc_id,booking_product.price_unit,booking_product.period,booking_product.status,booking_product.start_date,booking_product.end_date,booking_product.start_time,booking_product.end_time,booking_product.status,booking_product.payable_amount,booking_product.booking_user_name');
        $this->db->from('booking_product');
        $this->db->join('products', 'products.id = booking_product.product_id ', 'left'); 
        $this->db->join('users', 'users.id = booking_product.user_id ', 'left'); 
        $this->db->join('user_profile', 'user_profile.user_id = booking_product.user_id ', 'left'); 
        $this->db->where('booking_product.user_id',$user_id);
        $this->db->where('booking_product.status !=','2');
        $this->db->order_by('booking_product.id','asc');
        $query = $this->db->get();
       // echo $this->db->last_query();die;
        return $query->result_array();
    }

    public function deleteProduct($id){
        $data['is_delete'] = '1';
        $where = array('id'=>$id);
        $this->db->where($where)->update('products',$data);
    }

    public function getmyproductbooking($user_id){
        $this->db->select('products.id as product_id,products.name as product_name,products.details,users.id as user_id,users.name as user_name,user_profile.last_name as user_last_name,user_profile.profile_pic as user_image,user_profile.mobile,user_profile.country_code,users.email as user_email,booking_product.address,booking_product.city,booking_product.state,booking_product.pincode,booking_product.doc_dl,booking_product.doc_id,booking_product.booking_user_name,booking_product.price_unit,booking_product.period,booking_product.status,booking_product.start_date,booking_product.end_date,booking_product.start_time,booking_product.end_time,booking_product.status');
        $this->db->from('booking_product');
        $this->db->join('products', 'products.id = booking_product.product_id ', 'left'); 
        $this->db->join('users', 'users.id = booking_product.user_id ', 'left'); 
        $this->db->join('user_profile', 'user_profile.user_id = booking_product.user_id ', 'left'); 
        $this->db->where('products.user_id',$user_id);
       // $this->db->where('booking_product.status','0');
        $this->db->order_by('booking_product.id','ASC');
        $this->db->group_by('products.name');
        $query = $this->db->get();
//echo $this->db->last_query();die;
        return $query->result_array();
    }

    public function search_nearby_product($param){
    $lat = $param['lat'];
    $lng = $param['lng'];
    $user_id = $param['user_id'];
    $lat    = $param['lat'];
    $lon    = $param['lng'];
    $radius = 100; // Km
    $angle_radius = $radius / ( 111 * cos( $lat ) );

    $min_lat = $lat - $angle_radius;
    $max_lat = $lat + $angle_radius;
    $min_lon = $lon - $angle_radius;
    $max_lon = $lon + $angle_radius;

    if($min_lat > $max_lat){
        $results = $this->db->query("select * from products WHERE lat BETWEEN $max_lat AND $min_lat AND lng BETWEEN $max_lon AND $min_lon"); 
    }else{
        $results = $this->db->query("select * from products WHERE lat BETWEEN $min_lat AND $max_lat AND lng BETWEEN $min_lon AND $max_lon"); 
    }
         // your own function that return your results (please sanitize your variables)
        //$results = $this->db->query("select * from products WHERE lat BETWEEN $max_lat AND $min_lat AND lng BETWEEN $max_lon AND $min_lon"); // your own function that return your results (please sanitize your variables)
        //echo $this->db->last_query();die;
        $filtereds = [];
        $result = [];
    //echo $this->db->last_query();die;
        foreach( $results->result() as $result ) {
            $distance = $this->getDistanceBetweenPointsNew( $lat, $lon, $result->lat, $result->lng, 'Km' );
            if( $distance <= $radius ) {
                // This is in "perfect" circle radius. Strip it out.
                $result->distance = $distance;
                $filtereds[] = $result;

            }
        }

       // print_r($filtereds);die;
        // Now do something with your result set
        return( $filtereds );
     
      
        return $this->db->select('*')->from('products')->where('user_id!=',$user_id)->where("name LIKE '%$value%'")->order_by('id','desc')->get()->result_array();
		

     // return $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','desc')->get()->result_array();
    }

    public function getDistanceBetweenPointsNew($latitude1, $longitude1, $latitude2, $longitude2, $unit = 'Mi') {
       $theta = $longitude1 - $longitude2;
       $distance = (sin(deg2rad($latitude1)) * sin(deg2rad($latitude2))+ (cos(deg2rad($latitude1)) * cos(deg2rad($latitude2)) * cos(deg2rad($theta))));
       $distance = acos($distance); 
       $distance = rad2deg($distance); 
       $distance = $distance * 60 * 1.1515;

       switch($unit) 
       { 
         /*case 'Mi': break;*/
         case 'Km' : $distance = $distance * 1.609344; 
         //case 'Km': break;
         //case 'Km' : $distance = $distance * 1.609344; 
         //case 'Mi' : $distance = $distance * 0.8684; 
         case 'Mi' : $distance; 


       } 

       return (round($distance,2)); 
    }

    public function search_product($param){

      $value = $param['value'];
      $category = $param['category'];
      $sub_category = $param['sub_category'];
      $city_name = $param['city_name'];
      $price_start = $param['price_start'];
      $price_end = $param['price_end'];
      $distance_start = $param['distance_start'];
      $distance_end = $param['distance_end'];
      $user_id = $param['user_id'];
      $lat = $param['lat'];
      $lon = $param['lng'];

      $this->db->select('*');
      $this->db->from('products');
      $this->db->where('user_id!=',$user_id);
      $this->db->where('is_delete',0);
      $this->db->where('is_approved',1);
      

      $this->db->group_start();
      if(!empty($value)){
        $this->db->where("name LIKE '%$value%'");
        $this->db->or_where("address LIKE '%$value%'");
      }
      if(!empty($category)){
        $this->db->where("category_name LIKE '%$category%'");
      }
      if(!empty($sub_category)){
        $this->db->where("sub_category_name LIKE '%$sub_category%'");
      }
      if(!empty($brand)){
        $this->db->where("city_name LIKE '%$city_name%'");
      }
      if(!empty($price_start) && !empty($price_end)){
        $this->db->group_start();
        $this->db->where('price >=', $price_start);
            $this->db->where('price <=',$price_end);
         $this->db->group_end();
      }
      if(!empty($distance_end) && !empty($lat)){
            $radius = $distance_end; // Km

             // Every lat|lon degree° is ~ 111Km
            $angle_radius = $radius / ( 111 * cos( $lat ) );
            $min_lat = $lat - $angle_radius;
            $max_lat = $lat + $angle_radius;
            $min_lon = $lon - $angle_radius;
            $max_lon = $lon + $angle_radius;
            $this->db->group_start();

            if($min_lat <= $max_lat){
                $this->db->where('lat >=', $min_lat);
                $this->db->where('lat <=',$max_lat);
                $this->db->where('lng >=', $min_lon);
                $this->db->where('lng <=',$max_lon);
            }else{
                $this->db->where('lat >=', $max_lat);
                $this->db->where('lat <=',$min_lat);
                $this->db->where('lng >=', $max_lon);
                $this->db->where('lng <=',$min_lon);
            }
            
            $this->db->group_end();

      }
      $this->db->where('status',1);
      $this->db->group_end();
      
      $query = $this->db->get();
      //echo $this->db->last_query();
      $results = $query;


       $filtereds = [];
        $result = [];
        if(!empty($distance_end) && !empty($lat)){
          foreach( $results->result() as $result ) {
              $distance = $this->getDistanceBetweenPointsNew( $lat, $lon, $result->lat, $result->lng, 'Mi' );
              if( $distance <= $radius ) {
                  // This is in "perfect" circle radius. Strip it out.
                  $result->distance = $distance;
                  $filtereds[] = $result;

              }
          }
        }else{
          $filtereds = $results->result();
        }


      return $filtereds;
      
      






       /* return $this->db->select('*')->from('products')->where('user_id!=',$user_id)->where('status',1)->where('is_approved',1)->where('is_delete',0)->where("name LIKE '%$value%'")->or_where("brand_name LIKE '%value'")->order_by('id','desc')->get()->result_array();*/

     // return $this->db->select('*')->from('products')->where('category_id',$category_id)->order_by('id','desc')->get()->result_array();
    }


}
