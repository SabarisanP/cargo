<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

global $_css;
global $_js;
global $_page_css;
global $_page_js;

if( !function_exists('_include_common_css') ) {
    function _include_common_css($file) {
        global $_css;
        $_css[] = $file;
    }
}

if( !function_exists('_include_css') ) {
    function _include_css($file) {
        global $_page_css;
        $_page_css[] = $file;
    }
}

if( !function_exists('_include_common_js') ) {
    function _include_common_js($file) {
        global $_js;
        if(is_array($file)) {
            foreach($file as $f) {
                $_js[] = $f;
            }
        } else {
            $_js[] = $file;
        }
    }
}

if( !function_exists('_include_js') ) {
    function _include_js($file,$callback='') {
        global $_page_js;
        $_page_js[] = array('file'=>$file,'callback'=>$callback);
    }
}

if( !function_exists('_get_common_css') ) {
    function _get_common_css($file) {
        global $_css;
        return $_css;
    }
}

if( !function_exists('_get_css') ) {
    function _get_css($file) {
        global $_page_css;
        return $_page_css;
    }
}

if( !function_exists('_get_js') ) {
    function _get_js() {
        global $_page_js;
        return $_page_js;
    }
}

if( !function_exists('_get_common_js') ) {
    function _get_common_js() {
        $files = config_item('js_files');
        $no_combine_uri = '';
        foreach ($files as $file) {    
            $no_combine_uri .= '<script src="'.$file.'?'.config_item('asset_version').'"></script>'.PHP_EOL;
        }
        return $no_combine_uri;
    }
}

/* End of file common_helper.php */
/* Location: ./system/helpers/common_helper.php */