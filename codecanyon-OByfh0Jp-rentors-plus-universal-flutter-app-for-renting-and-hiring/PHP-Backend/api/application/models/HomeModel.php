<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HomeModel extends CI_Model {

		public function home_all_data($user_id,$lat,$lon)
    {
		$data = array();
		
		$upload_url = $this->config->item('upload_url');
		$urlc = $this->config->item('home_url');
        $dir = $upload_url.'home/';
	    $sliderImage = array();
	    if (is_dir($dir)) {
	        if ($dh = opendir($dir)) {
	            while (($file = readdir($dh)) !== false) {
	              if($file == '.' || $file == '..'){
	              }else{
	              	$file = $urlc.'uploads/home/'.$file;
	                $image_result['image'] = $file;
	                array_push($sliderImage,$image_result);
	              }
	            }
	        }
	        closedir($dh);
	    }

 		$data['home_slider_image'] = $sliderImage;

        $cat_result=  $this->db->select('id, name,category_icon,category_color')->from('category')->order_by('id','asc')->get()->result();
        $subcat_result = array();
        $cat_subcat_result  = array();

        if(!empty($cat_result)){
        	foreach($cat_result as $cat){
        		$subcat_result =  $this->db->select('id, name,sub_cat_icon')->from('sub_category')->where('category_id',$cat->id)->get()->result();
        		$cat_data['id'] = $cat->id;
        		$cat_data['name'] = $cat->name;
        		$cat_data['category_icon'] = $cat->category_icon;
        		$cat_data['category_color'] = $cat->category_color;
        		$cat_data['sub_category'] = $subcat_result;
				
        		array_push($cat_subcat_result,$cat_data);
        	}
        }
		$data['category'] = $cat_subcat_result;//catergory obj in data response
		
		
		//TopSelling obj in data response
			$this->db->select('s.subscription_id,p.*');
			$this->db->from('products p');
			$this->db->join('featured_product s', ' s.product_id = p.id ', 'left'); 
			//$this->db->where('p.status !=','2');
			$this->db->where('p.is_delete','0');
			$this->db->order_by('p.id','asc');
			$this->db->where('p.is_featured','1');
			$query = $this->db->get();
			$topselling_product_result =  $query->result();
		/*$topselling_product_result = $this->db->select('*')->from('products')->order_by('id','desc')->limit(5)->get()->result();*/
		$topselling_product_result_temp=array();
		foreach($topselling_product_result as $topselling_product_result){
			$like_result=$this->db->select('*')->from('like_product')->where('user_id',$user_id)->where('product_id',$topselling_product_result->id)->get()->result();
			if(empty($like_result)){
				$topselling_product_result->is_like=0;
				}else{
					$topselling_product_result->is_like=$like_result[0]->status;
			}
			array_push($topselling_product_result_temp,$topselling_product_result);
		}
		$data['featured_products']= $topselling_product_result_temp;
		
		
		
		
		//Products obj in data response
		$products = array();
		foreach ($cat_result as $category)
			{
				$obj = array();
				$obj['category'] = $category->name;

				$sub_cat_result=  $this->db->select('*')->from('sub_category')->where('category_id',$category->id)->order_by('id','asc')->get()->result();
				$obj_sub_category = array();
				foreach ($sub_cat_result as $sub_category)
					{
						
						$obj_sub_category_temp = array();
						$obj_sub_category_temp['sub_category_name'] = $sub_category->name;
							/*$product_result = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category->id)->order_by('id','desc')->get()->result();*/


							$product_result = $this->db->select('*')->from('products')->where('sub_category_id',$sub_category->id,'is_approved','1')->order_by('id','asc')->get()->result();
								$this->db->select('*');
					            $this->db->from('products');
					            $this->db->where('sub_category_id',$sub_category->id);
					            $this->db->where('is_approved','1');
					            $this->db->where('user_id !=',$user_id);
					            $this->db->where('status !=','2');
					            $this->db->where('is_delete','0');
					            $this->db->order_by('id','desc');
					            $query = $this->db->get();
					            $product_result = $query->result();




							$product_result_temp=array();
							foreach($product_result as $product_result){
								// $query="select * from like_product where user_id='".$user_id."' and product_id='".$product_result->id."'";
								$like_result=$this->db->select('*')->from('like_product')->where('user_id',$user_id)->where('product_id',$product_result->id)->get()->result();
								//print_r($like_result);
								if(empty($like_result)){
									$product_result->is_like=0;

									}else{

										$product_result->is_like=$like_result[0]->status;

								}
								if(!empty($product_result)) {
									array_push($product_result_temp,$product_result);
								}
								
							}	
							// $obj_sub_category_temp['products'] ="true";

							$obj_sub_category_temp['products']= $product_result_temp;
							// $obj_sub_category_temp['products']= $product_result	;
						if(!empty($obj_sub_category_temp['products'])) {
						    array_push($obj_sub_category,$obj_sub_category_temp);
					    }
						
					}
					$obj['sub_category'] = $obj_sub_category;
						//return $obj;
					if(!empty($obj['sub_category'])) {
						array_push($products,$obj);
					}
				
			}		
		 $data['products'] = $products;
		 
		 $slider_image=  $this->db->select('id, image')->from('slider_image')->order_by('id','asc')->get()->result_array();
		 
		 if(isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') 
		 		$url_parts = "https"; 
	 		else
		 		$url_parts = "http"; 

		$url_parts .= "://";
		$url_parts .= $_SERVER["HTTP_HOST"];
		$url_parts .= '/rah/api/RentAndHire';

		//$prefixed_array = preg_filter('/^/', 'okoko---', $slider_image);
		$new_slider = array();
		foreach($slider_image as $value) {
				$value['image'] = $url_parts.$value['image'];
				array_push($new_slider,$value);
		}
		$data['slider_image'] = $new_slider;

		/* near by data start-----*/

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
	    $filtereds = [];
		$result = [];
		foreach( $results->result() as $result ) {
            $distance = $this->getDistanceBetweenPointsNew( $lat, $lon, $result->lat, $result->lng, 'Mi' );
            if( $distance <= $radius ) {
				$result->distance = $distance;
				$filtereds[] = $result;

			}
		}
		$data['near_by_search'] = $filtereds;
	
		
		
		return $data;
		
		//return array('status' => 200,'message' => 'Success','data' => $obj);
    }


	public function getDistanceBetweenPointsNew($latitude1, $longitude1, $latitude2, $longitude2, $unit = 'Mi') 
	{
		$theta = $longitude1 - $longitude2;
		$distance = sin(deg2rad($latitude1)) * sin(deg2rad($latitude2))+ cos(deg2rad($latitude1)) * cos(deg2rad($latitude2)) * cos(deg2rad($theta));






		$distance = acos($distance); 
		$distance = rad2deg($distance); 

		$distance = $distance * 60 * 1.1515;

		switch($unit) 
		{ 
		case 'Km': break;
		//case 'Km' : $distance = $distance * 1.609344; 
		//case 'Km' : $distance = $distance * 1.609344; 
		//case 'Mi' : $distance = $distance * 0.8684; 
		 case 'Mi' : $distance; 
		} 
		return (round($distance,2)); 
	}


    public function profile_detail_data($id)
    {
        return $this->db->select('*')->from('user_profile')->where('user_id',$id)->order_by('id','desc')->get()->row();
    }

    public function profile_update_data($id,$data)
    {
        $this->db->where('user_id',$id)->update('user_profile',$data);
	 return	$this->db->select('*')->from('user_profile')->where('user_id',$id)->order_by('id','desc')->get()->row();
        //return array('status' => 200,'message' => 'Data has been updated.');
    }


}
