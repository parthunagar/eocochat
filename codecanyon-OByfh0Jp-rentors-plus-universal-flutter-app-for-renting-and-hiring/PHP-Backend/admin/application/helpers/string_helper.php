<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('strpos_all'))
{
    function strpos_all($haystack, $needle) {
    $offset = 0;
    $allpos = array();
    while (($pos = strpos($haystack, $needle, $offset)) !== FALSE) {
        $offset   = $pos + 1;
        $allpos[] = $pos;
    }
    return $allpos;
}
}