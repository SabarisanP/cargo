<?php

class Menuhook extends MY_Controller {

    function setAppMenu() { // Assign app menu in to view
        $ci = &get_instance();       
        $ci->load->model("api_model");
        $menus = $ci->api_model->getAppMenu();
        $ci->config->set_item('rights', $menus['action_rights']);
        $ci->load->vars($menus);
        if( $ci->input->is_ajax_request() ) {
            return;
        }
        
        if($menus['action_rights']['SHOW-NSCE-LIST']==1) {
            $ns_list = json_decode($ci->api_model->getWhitelistedNamespace());
            foreach ($ns_list->data AS $key => $list) {
                $ns_a_list[] = array(
                    'code' => $list->code,
                    'name' => $list->name
                );
            }
            $ns_sorted = _array_orderby($ns_a_list, 'name', SORT_ASC);
            $ci->load->vars(array('namespace_list' => $ns_sorted));
            //$ci->load->vars(array('chat_list' => json_decode($ci->api_model->getCollaborationList(array()))));
        }    
    }
    
//    function post_controller_constructor(){        
//        $ci = &get_instance();
//        if( $ci->session->userdata('user_id')!="") {    
//            $token = $ci->session->userdata('user_hash');
//            $menu_key = $token.'_MENU';
//            if( !$menus = $ci->cache->file->get($menu_key) ) {                        
//                $menus = $ci->api_model->getAppMenu();
//                $ci->cache->file->save($menu_key, $menus, 3600);
//            }
//            
//            $ci->config->set_item('rights', $menus['action_rights']);
//            $ci->load->vars($menus);
//        }
//    }

}

?>