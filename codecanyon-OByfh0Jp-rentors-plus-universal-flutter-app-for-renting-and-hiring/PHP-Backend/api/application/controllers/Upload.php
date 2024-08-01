<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Upload extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        //$this->load->Model('HomeModel');
        
    }

    public function index()
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if ($method != 'POST')
        {
            json_output(400, array(
                'status' => 400,
                'message' => 'Bad request.'
            ));
        }
        else
        {
            $response = array();
            $upload_dir = 'uploads/';
            //$server_url = 'localhost/api/simple-codeigniter-rest-api-master/rah_api';
            $server_url = $this->config->item('base_url');
            if ($_FILES['avatar'])
            {
                $avatar_name = $_FILES["avatar"]["name"];
                $avatar_tmp_name = $_FILES["avatar"]["tmp_name"];
                $error = $_FILES["avatar"]["error"];

                if ($error > 0)
                {
                    $response = array(
                        "status" => "error",
                        "error" => true,
                        "message" => "Error uploading the file!"
                    );
                }
                else
                {
                    $t=time();
                    $random_name = rand(1000, 1000000). "-" . $t;
                    $upload_name = $upload_dir . strtolower($random_name). '.png';
                    $upload_name = preg_replace('/\s+/', '-', $upload_name);

                    if (move_uploaded_file($avatar_tmp_name, $upload_name))
                    {
                        $response = array(
                            "status" => "success",
                            "error" => false,
                            "message" => "File uploaded successfully",
                            "url" => $server_url . "" . $upload_name
                        );
                    }
                    else
                    {
                        $response = array(
                            "status" => "error",
                            "error" => true,
                            "message" => "Error uploading the file Final!"
                        );
                    }
                }

            }
            else
            {
                $response = array(
                    "status" => "error",
                    "error" => true,
                    "message" => "No file was sent!"
                );
            }

            //echo json_encode($response);
            json_output(201, $response);
        }
    }

     public function indexV2()
    {
          if (isset($_FILES['media'])) {
                $filesCount = count($_FILES['media']['name']);
                for ($i = 0; $i < $filesCount; $i++) {
                    $_FILES['file']['name']     = $_FILES['media']['name'][$i];
                    $_FILES['file']['type']     = $_FILES['media']['type'][$i];
                    $_FILES['file']['tmp_name'] = $_FILES['media']['tmp_name'][$i];
                    $_FILES['file']['error']    = $_FILES['media']['error'][$i];
                    $_FILES['file']['size']     = $_FILES['media']['size'][$i];
                
                   // $server_url = base_url();
                    $server_url = $this->config->item('base_url');
                    $uploadPath                 = 'uploads/';
                    $config['upload_path']      = $uploadPath;
                    $config['allowed_types']    = '*';
                    $config['encrypt_name']     = TRUE;
                    // Load and initialize upload library
                    $this->load->library('upload', $config);
                    $this->upload->initialize($config);
                    if ($this->upload->do_upload('media')) {
                        // Uploaded file data
                        $fileData = $this->upload->data();
                        $fileData['file_name'];
                        $uploadData[$i] = $server_url . 'uploads/' . $fileData['file_name'];
                    } 
                } 
                $response = array();
                array_push($response, $uploadData);
            } 
            $response1 = array(
                            "status" => 200,
                            "message" => "File uploaded successfully",
                            "url" =>  $response[0]
                        );
            json_output(201, $response1);
    }

    public function detail($id)
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if ($method != 'GET' || $this
            ->uri
            ->segment(3) == '' || is_numeric($this
            ->uri
            ->segment(3)) == false)
        {
            json_output(400, array(
                'status' => 400,
                'message' => 'Bad request.'
            ));
        }
        else
        {
            $check_auth_client = $this
                ->MyModel
                ->check_auth_client();
            if ($check_auth_client == true)
            {
                $response = $this
                    ->MyModel
                    ->auth();
                if ($response['status'] == 200)
                {
                    $resp = $this
                        ->ProductModel
                        ->product_detail_data($id);
                    $response['data'] = $resp;
                    $response['message'] = 'Success';
                    json_output($response['status'], $response);
                }
            }
        }
    }

    public function create()
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if ($method != 'POST')
        {
            json_output(400, array(
                'status' => 400,
                'message' => 'Bad request.'
            ));
        }
        else
        {
            $check_auth_client = $this
                ->MyModel
                ->check_auth_client();
            if ($check_auth_client == true)
            {
                $response = $this
                    ->MyModel
                    ->auth();
                $respStatus = $response['status'];

                if ($response['status'] == 200)
                {
                    $params = json_decode(file_get_contents('php://input') , true);
                    if ($params['details'] == "")
                    {
                        $respStatus = 400;
                        $resp = array(
                            'status' => 400,
                            'message' => 'Product Detail can\'t empty'
                        );
                    }
                    else
                    {
                        $resp = $this
                            ->ProductModel
                            ->product_create_data($params);
                        $response['message'] = 'Success';
                    }
                    $response['data'] = $resp;
                    json_output($response['status'], $response);
                }
            }
        }
    }

    public function update($id)
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if ($method != 'PUT' || $this
            ->uri
            ->segment(3) == '' || is_numeric($this
            ->uri
            ->segment(3)) == false)
        {
            json_output(400, array(
                'status' => 400,
                'message' => 'Bad request.'
            ));
        }
        else
        {
            $check_auth_client = $this
                ->MyModel
                ->check_auth_client();
            if ($check_auth_client == true)
            {
                $response = $this
                    ->MyModel
                    ->auth();
                $respStatus = $response['status'];
                if ($response['status'] == 200)
                {
                    $params = json_decode(file_get_contents('php://input') , true);
                    $params['updated_at'] = time();
                    if ($params['details'] == "")
                    {
                        $respStatus = 400;
                        $resp = array(
                            'status' => 400,
                            'message' => 'Product Detail can\'t empty'
                        );
                    }
                    else
                    {
                        $resp = $this
                            ->ProductModel
                            ->product_update_data($id, $params);
                        $response['message'] = 'Success';
                    }
                    $response['data'] = $resp;
                    json_output($response['status'], $response);
                }
            }
        }
    }

    public function delete($id)
    {
        $method = $_SERVER['REQUEST_METHOD'];
        if ($method != 'DELETE' || $this
            ->uri
            ->segment(3) == '' || is_numeric($this
            ->uri
            ->segment(3)) == false)
        {
            json_output(400, array(
                'status' => 400,
                'message' => 'Bad request.'
            ));
        }
        else
        {
            $check_auth_client = $this
                ->MyModel
                ->check_auth_client();
            if ($check_auth_client == true)
            {
                $response = $this
                    ->MyModel
                    ->auth();
                if ($response['status'] == 200)
                {
                    $resp = $this
                        ->ProductModel
                        ->product_delete_data($id);
                    json_output($response['status'], $resp);
                }
            }
        }
    }

}

