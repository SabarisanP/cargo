<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class menu extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        $this->menu();
    }

    public function menu() {
        $this->is_logged_in();
        _include_js('assets/js/pages/menus.js');
        
        $products = $this->api_model->getProducts();
        $products = json_decode($products);
        
        $menu = $this->api_model->getMenu(array('authtoken' => $this->_user_hash));
        $menu = json_decode($menu);

        if (is_array($menu->data) && $menu->status == 1) {
            foreach ($menu->data AS $mn) {

                if ($mn->lookup->code != '') {
                    $sub_temp[$mn->lookup->code][] = array(
                        'code' => $mn->code,
                        'name' => $mn->name,
                        'link' => $mn->link,
                        'activeFlag' => $mn->activeFlag,
                        'severity' => $mn->severity,
                        'lookup' => $mn->lookup
                    );
                } else {
                    $mn_temp[$mn->code] = array(
                        'code' => $mn->code,
                        'name' => $mn->name,
                        'link' => $mn->link,
                        'activeFlag' => $mn->activeFlag,
                        'severity' => $mn->severity,
                        'lookup' => $mn->lookup
                    );
                }

                if (is_array($mn->eventList) && $mn->eventList != '') {
                    foreach ($mn->eventList as $event) {
                        if (empty($event->operationCode))
                            continue;
                        if ($event->permissionType == 'IDL')
                            $events[strtoupper($event->operationCode)] = 2;
                        else
                            $events[strtoupper($event->operationCode)] = 1;
                    }
                }
            }
        }

        $data['f_menus'] = $menu->data;
        $data['f_parent'] = $mn_temp;
        $data['f_sub_menu'] = $sub_temp;
        $data['products'] = $products->data;

        $data['groupusers'] = get_active_group_and_users();
        $data['perrmission_severity'] = config_item('perrmission_severity');
        $this->load->view('site/menu/menu', $data);
    }

    public function update_menu() {
        $parentCode = $this->input->post('parentCode');
        $evntFlag = $this->input->post('eventactiveFlag');
        $eventCode = $this->input->post('eventCode');
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'link' => $this->input->post('link'),
            'code' => $this->input->post('code'),
            'productType' => array(
                                'code'=>$this->input->post('productCode')
                            ),
            'actionCode' => $this->input->post('actionCode'),
            'tagList' => $this->input->post('tagList') ?: [],
            'severity' =>  array('code'=>$this->input->post('severity')),
        );
        if (isset($parentCode) && $parentCode != '') {
            $data['lookup'] = array(
                'activeFlag' => 1,
                'defaultFlag' => 1,
                'code' => $parentCode
            );
        }
        $eventName = $this->input->post('eventName');
        $eventPermission = $this->input->post('eventPermission');
        $eventKeywords = $this->input->post('eventKeywords');
        $eventAttr = $this->input->post('eventAttribute');
        $eventSeverity = $this->input->post('eventSeverity');
        if (is_array($eventName) && !empty($eventName)) {
            foreach ($eventName AS $key => $vl) {
                $tmp[] = array(
                    'name' => $eventName[$key]['value'],
                    'permissionType' => $eventPermission[$key]['value'],
                    'operationCode' => $eventKeywords[$key]['value'],
                    'attr1Value' => $eventAttr[$key]['value'],
                    'code' => $eventCode[$key]['value'],
                    'activeFlag' => $evntFlag[$key],
                    'severity' => array('code'=>$eventSeverity[$key]['value']),
                );
            }
            $data['eventList'] = $tmp;
        }
        echo $this->api_model->updateMenu($data);
    }

    public function delete_menu() {
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateMenu($data);
    }

    public function edit_status_menu() {
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateMenu($data);
    }

    public function privilege() {
        $this->is_logged_in();
        _include_js('assets/js/pages/menus.js');
        $menu = $this->api_model->getMenu(array('authtoken' => $this->_user_hash));
        $menu = json_decode($menu);

        foreach ($menu->data AS $mn) {
            if ($mn->lookup->code != '') {
                $sub_temp[$mn->lookup->code][] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'level' => 2
                );
            } else {
                $mn_temp[$mn->code] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'level' => 1
                );
            }
        }


        // for group


        $Grp = $this->api_model->getGrpMenu(array('authtoken' => $this->_user_hash));
        $Grp = json_decode($Grp);

        foreach ($Grp->data AS $mn) {
            if ($mn->lookup->code != '') {
                $Grp_sub_temp[$mn->lookup->code][] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'level' => 2
                );
            } else {
                $Grp_mn_temp[$mn->code] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'level' => 1
                );
            }
        }

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;

        $data['p_menus'] = $menu->data;
        $data['p_parent'] = $mn_temp;
        $data['p_sub_menu'] = $sub_temp;

        $data['grp_menus'] = $Grp->data;
        $data['grp_parent'] = $Grp_mn_temp;
        $data['grp_sub_menu'] = $Grp_sub_temp;


        $this->load->view('site/menu/privilege', $data);
    }

    function update_privilege() {

        $eve = $this->input->post('event');
        $menu = $this->input->post('menucode');

        foreach ($menu as $index => $value) {
            $tmp[] = array(
                'menu' => $menu[$index],
                'eve' => $eve[$index]
            );
        }

        $result = array();
        foreach ($tmp as $value) {
            $mnuid = $value['menu'];
            if (isset($result[$mnuid]))
                $index = ((count($result[$mnuid]) - 0) / 2) + 1;
            else
                $index = 1;

            $result[$mnuid]['menu'] = $mnuid;
            $te[] = array(
                'menu' => $value['menu'],
                'codes' => $value['eve']);
        }


        $result = array_values($result);
        $role = $this->input->post('role');
        $data['rolename'] = $role;
        if ($role == 'NS') {


            foreach ($result as $event) {

                $code_menu = array();

                $code = $event['menu'];

                foreach ($te as $menu) {


                    if ($menu['menu'] == $event['menu']) {

                        $code_menu[] = array(
                            'code' => $menu['codes']
                        );
                    }
                }

                $tmpa = $code_menu;

                $data['privilege'] = array(
                    "activeFlag" => $this->input->post('activeFlag'),
                    "exceptionFlag" => $this->input->post('exceptionFlag'),
                    "eventList" => $tmpa,
                    "code" => $code
                );

                $this->api_model->updatePrivilege($data);
            }
            echo json_encode(array('status' => 1));
        } else if ($role == 'GR') {

            foreach ($result as $event) {

                $code_menu = array();

                $code = $event['menu'];

                foreach ($te as $menu) {


                    if ($menu['menu'] == $event['menu']) {

                        $code_menu[] = array(
                            'code' => $menu['codes']
                        );
                    }
                }

                $tmpa = $code_menu;

                $tmps = array_filter($tmpa);


                $data['privilege'] = array(
                    "activeFlag" => $this->input->post('activeFlag'),
                    "exceptionFlag" => $this->input->post('exceptionFlag'),
                    "eventList" => $tmps,
                    "code" => $code,
                    "group" => array('code' => $this->input->post('groupcode'))
                );

                $this->api_model->updatePrivilege($data);
            }

            echo json_encode(array('status' => 1));
        } else if ($role == 'UR') {
            foreach ($result as $event) {

                $code_menu = array();

                $code = $event['menu'];

                foreach ($te as $menu) {


                    if ($menu['menu'] == $event['menu']) {

                        $code_menu[] = array(
                            'code' => $menu['codes']
                        );
                    }
                }

                $tmpa = $code_menu;

                $data['privilege'] = array(
                    "activeFlag" => $this->input->post('activeFlag'),
                    "exceptionFlag" => $this->input->post('exceptionFlag'),
                    "eventList" => $tmpa,
                    "code" => $code,
                    "user" => array('code' => $this->input->post('usercode'))
                );
                $this->api_model->updatePrivilege($data);
            }
            echo json_encode(array('status' => 1));
        }
    }
    
    function restore_user_privilege() {
        $this->is_logged_in();
        $param = array(
            'userCode' => $this->input->post('user')
        );
        echo $this->api_model->restoreUserPrivilege($param);        
    }

    function get_privilege() {
        $role = $this->input->post('role');
        echo $this->api_model->getRole(array('authtoken' => $this->_user_hash, 'rolename' => $role));
    }

    function get_namespace_privilege() {
        $role = $this->input->post('role');
        $nsp = $this->api_model->getRole(array('authtoken' => $this->_user_hash, 'rolename' => "NS"));
        $nsp = json_decode($nsp);

        foreach ($nsp->data AS $mnsp) {

            foreach ($mnsp AS $ns) {

                if ($mn->lookup->code != '') {
                    $sub_temp[$ns->lookup->code][] = array(
                        'code' => $ns->code,
                        'name' => $ns->name,
                        'link' => $ns->link,
                        'activeFlag' => $ns->activeFlag,
                        'defaultFlag' => $ns->defaultFlag,
                        'eventList' => $ns->eventList,
                        'lookup' => $ns->lookup,
                        'level' => 2
                    );
                } else {
                    if ($ns->code != '') {
                        $mn_temp[$ns->code] = array(
                            'code' => $ns->code,
                            'name' => $ns->name,
                            'link' => $ns->link,
                            'activeFlag' => $ns->activeFlag,
                            'defaultFlag' => $ns->defaultFlag,
                            'eventList' => $ns->eventList,
                            'lookup' => $ns->lookup,
                            'level' => 1
                        );
                    }
                }
            }
        }

        $data = array('status' => 1, 'parent' => $mn_temp, 'sub_menu' => $sub_temp);
        $data = array('status' => 1);
        if ($role == 'GR') {
            $role = $this->input->post('role'); //
            $groupcode = $this->input->post('code');
            $group = $this->api_model->getRole(array('authtoken' => $this->_user_hash, 'rolename' => $role));
            $group = json_decode($group);

            foreach ($group->data AS $mnsp) {
                foreach ($mnsp AS $ns) {
                    if ($ns->code != '' && $ns->group->code == $groupcode) {
                        $group[$ns->code] = array(
                            'code' => $ns->code,
                            'name' => $ns->name,
                            'link' => $ns->link,
                            'activeFlag' => $ns->activeFlag,
                            'defaultFlag' => $ns->defaultFlag,
                            'eventList' => $ns->eventList,
                            'lookup' => $ns->lookup,
                            'level' => 1
                        );
                    }
                }
            }
            $data['groups'] = $group;
        } else if ($role == 'UR') {

            $role = $this->input->post('role');
            $usercode = $this->input->post('code');
            $groupcode = $this->input->post('group');
            $group = $this->api_model->getRole(array('authtoken' => $this->_user_hash, 'rolename' => 'GR'));
            $users = $this->api_model->getRole(array('authtoken' => $this->_user_hash, 'rolename' => 'UR'));
            if (is_array($group)) {
                foreach ($group->data AS $mnsp) {
                    foreach ($mnsp AS $ns) {
                        if ($ns->code != '' && $ns->group->code == $groupcode) {
                            $group[$ns->code] = array(
                                'code' => $ns->menu->code,
                                'name' => $ns->name,
                                'link' => $ns->link,
                                'activeFlag' => $ns->activeFlag,
                                'defaultFlag' => $ns->defaultFlag,
                                'eventList' => $ns->eventList,
                                'lookup' => $ns->lookup,
                                'level' => 1
                            );
                        }
                    }
                }
                foreach ($group->data AS $mnsp) {
                    foreach ($mnsp AS $ns) {
                        if ($ns->code != '' && $ns->user->code == $usercode) {
                            $group[$ns->code] = array(
                                'code' => $ns->menu->code,
                                'name' => $ns->name,
                                'link' => $ns->link,
                                'activeFlag' => $ns->activeFlag,
                                'defaultFlag' => $ns->defaultFlag,
                                'eventList' => $ns->eventList,
                                'lookup' => $ns->lookup,
                                'level' => 1
                            );
                        }
                    }
                }
                $data['groups'] = $group;
                $data['users'] = $users;
            }
        }
        echo json_encode($data);
    }

    public function permissions() {
        $this->is_logged_in();
        
        $is_super_ns = _is_super_namespace( $this->session->userdata('namespace_id'));
        $super_users = config_item('super_users');
        
        // if( $is_super_ns==1 && !in_array($this->session->userdata('user_id'), $super_users ) ) {
        //     $this->load->view('site/denied', $data);
        //     return;
        // }
        
        _include_js('assets/js/pages/menu-permission.js');

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash)); // Get groups
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;
        
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        
        $users = array();
        foreach ($userDetail->data as $user) {
            $t = (!empty($user->group->name)) ? $user->group->name : 'Others'; 
            $users[$t][] = $user; 
        }        
        ksort($users);
        $data['users'] = $users;
        
        $this->load->view('site/permission/permissions', $data);
    }

    public function get_menu_permissions() {
        $this->is_logged_in();
        $role = $this->input->post('role');
        $code = $this->input->post('code');
        $param = array(
            'authtoken' => $this->_user_hash,
            'roleCode' => $role
        );
        $val = array();
        
        if ($role == 'GR') {
            $val = array(
                'group' => array(
                    'code' => $code
                )
            );
        } else {
            $val = array(
                'user' => array(
                    'code' => $code
                )
            );
        }
        $menu = $this->api_model->getRolePermission($param, $val);
        $menu = json_decode($menu);
        
        $mn_temp = array();
        $sub_temp = array();
        
        foreach ($menu->data AS $mn) {
            if ($mn->lookup->code != '') {
                $sub_temp[$mn->lookup->code][] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'enabledFlag' => $mn->enabledFlag,
                    'level' => 2
                );
            } else {
                $mn_temp[$mn->code] = array(
                    'code' => $mn->code,
                    'name' => $mn->name,
                    'link' => $mn->link,
                    'activeFlag' => $mn->activeFlag,
                    'defaultFlag' => $mn->defaultFlag,
                    'eventList' => $mn->eventList,
                    'lookup' => $mn->lookup,
                    'enabledFlag' => $mn->enabledFlag,
                    'level' => 1
                );
            }
        }


        $data['p_parent'] = $mn_temp;
        $data['p_sub_menu'] = $sub_temp;
        echo json_encode(array('parent' => $data['p_parent'], 'submenu' => $data['p_sub_menu']));
    }

    public function update_menu_permissions() {
        $this->is_logged_in();
        $menu = $this->input->post('menu');
        $role = $this->input->post('role');
        $event = $this->input->post('event');

        $evt = explode(',', $event);
        foreach ($evt as $et) {
            $evts[] = array('code' => $et);
        }

        $data['rolename'] = $role;

        if ($role == 'UR') {
            $data['privilege'] = array(
                "activeFlag" => $this->input->post('activeFlag'),
                "code" => $menu,
                "eventList" => $evts,
                'user' => array(
                    'code' => $this->input->post('code')
                )
            );
        } else if ($role == 'GR') {
            $data['privilege'] = array(
                "activeFlag" => $this->input->post('activeFlag'),
                "code" => $menu,
                "eventList" => $evts,
                'group' => array(
                    'code' => $this->input->post('code')
                )
            );
        } else {
            $data['privilege'] = array(
                "activeFlag" => $this->input->post('activeFlag'),
                "code" => $menu,
                "eventList" => $evts
            );
        }
        echo $this->api_model->updatePrivilege($data);
    }

    function assigned_users_list() {
        $this->is_logged_in();
        
        echo $this->api_model->menuAssignedUsers(array(
            'menuCode' => $this->input->post('code')
        ));
    }

}

?>