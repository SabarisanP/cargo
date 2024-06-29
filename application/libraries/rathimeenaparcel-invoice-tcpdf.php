<?php

require_once APPPATH . 'third_party/tcpdf/tcpdf.php';

class InvoicePdf extends TCPDF {

	private $customFooterText = '';

	public function Header() {
		$image_file = FCPATH . 'assets/img/clientlogo/Rathimeena_LR-Header.jpg';
		$this->Image($image_file, 10, 0, 190, '', 'JPG', '', 'T', false, 300, '', false, false, 0, false, false, false);
	}

	public function Footer() {
        $this->SetY(-15);
		$this->SetFillColor(43, 45, 150);
		// set color for text
		$this->SetTextColor(255, 255, 255);
		// write the first column
		$this->SetFont('helvetica', '', 9);
		$this->MultiCell(0, 12, $this->customFooterText, 0, 'C', 1, 0, '', '', true, 0, true, true, 0);
	}

	public function setCustomFooterText($text) {
		$this->customFooterText = $text;
	}
}