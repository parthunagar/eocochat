<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this -> load -> library('session');
        $this -> load -> helper('form');
        $this -> load -> helper('url');
        $this -> load -> database();
        $this -> load -> library('form_validation');
        $this -> load -> model('Comman_model');

    }

    public function index()
    {
        $this -> load ->view('login.php');
    }
    public function signup()
    {
        $this -> load -> view('common/head.php');
        $this -> load ->view('signup.php');
        $this -> load -> view('common/footer.php');
    }

    public function forgotpassword()
    {
        $this->load ->view('forgotpassword.php');
    }
}