<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('generate_slug')) {
    function generate_slug($referenceIds) {
        $slug = get_tracking_domain_url() . '/';
        foreach ($referenceIds as $index => $referenceId) {
            $slug .= encode($referenceId);
            if ($index < count($referenceIds) - 1) {
                $slug .= '/';
            }
        }
        return $slug;
    }
}

if ( ! function_exists('get_slug_details')) {
    function get_slug_details($slugURL) {
        $referenceIds = [];
        try {
            $slugURL = ltrim($slugURL, '/');
            $referenceCodes = explode('/', $slugURL);
            foreach ($referenceCodes as $reference) {
                $referenceIds[] = decode($reference);
            }
        } catch (Exception $e) {
            echo $e->getMessage();
        }
        return $referenceIds;
    }
}

if ( ! function_exists('encode')) {
    function encode($referenceId) {
        $alphabet = 'bctvxDwFdfyzBCghJNPQnpqrsGH45YZM2KL3jkm6RSTVW78X9';
        $base = strlen($alphabet);
        $str = '';
        while ($referenceId > 0) {
            $str = $alphabet[$referenceId % $base] . $str;
            $referenceId = intdiv($referenceId, $base);
        }
        return $str;
    }
}

if ( ! function_exists('decode')) {
    function decode($encodedStr) {
        $alphabet = 'bctvxDwFdfyzBCghJNPQnpqrsGH45YZM2KL3jkm6RSTVW78X9';
        $base = strlen($alphabet);
        $num = 0;
        for ($i = 0; $i < strlen($encodedStr); $i++) {
            $num = $num * $base + strpos($alphabet, $encodedStr[$i]);
        }
        return $num;
    }
}

if ( ! function_exists('get_tracking_domain_url')) {
    function get_tracking_domain_url() {
        return 'ezcg.in'; 
    }
}


?>
