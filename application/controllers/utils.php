<?php

if (!defined('BASEPATH'))    exit('No direct script access allowed');

class Utils extends MY_Controller {
    function __construct() {
        parent::__construct();
    }
     // Get all available states from application.
    public function get_all_states() {
        $this->is_logged_in();
        $json = $this->api_model->getAllStates( array('authToken'=>_get_user_hash()) );
        echo $json;
        
    }
     //  Get all available stations for a state.
    public function get_stations() {
       $this->is_logged_in();
       $state_code = $this->input->post('state_code');
       if($state_code !="" ){
            $json = $this->api_model->getStationsByState( array('authtoken'=>_get_user_hash(), 'statecode'=>$state_code) );
       }                
       echo $json;
    }
//    public function get_namespace_station_point() {
//         $this->is_logged_in();
//         $json = $this->api_model->getAllNamespaceStation( array('authtoken'=>_get_user_hash()));   
//         echo $json;
//    }

}

?>