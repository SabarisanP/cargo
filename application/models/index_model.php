<?php
class Index_model extends CI_Model {
	function getAllDestinations() {
		$sql = 'SELECT loc_tg_id as id, loc_name as label, loc_name as value 
				FROM destinations 
				WHERE loc_status=1 ORDER BY loc_name ASC';
		$rs = $this->db->query($sql);
    	return $rs->result();
	}
}
?>