<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Redis
 *
 * @author Kathir
 */
class Rediscache {
    public $redis = NULL;    
    function __construct() {
        $this->redis = new Redis();
        $this->redis->connect(config_item('redis_host'), config_item('redis_port'));
    }    
    
    function set($key, $value, $ttl = 10800) {       
        $s = $this->redis->set($key, $value, $ttl);
        //$this->redis->setTimeout($key, $ttl);   //  10800 - 3 hours    
        return $s;
    }
    
    function get($key) {
        return $this->redis->get($key);
    }
    
    function exists($key) {
        return $this->redis->exists($key);
    }
    
    function delete($key) {
        return $this->redis->del($key);
    }

    function keys($pattern) {
        return $this->redis->keys($pattern);
    }
    
}
