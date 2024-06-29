<?php

require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
class seenuPdf extends TCPDF
{
    private $customFooterText = '';
    public function Footer()
    {
        $this->SetY(-15);
        $this->SetFillColor(255, 255, 255); // Set background color to white
        $this->Rect(0, $this->GetY(), $this->getPageWidth(), 15, 'F'); // Fill a rectangle with white color
        $this->SetTextColor(0, 0, 0); // Set text color to black
        $this->SetFont('helvetica', '', 9);
        $this->MultiCell(0, 12, $this->customFooterText, 0, 'C', 0, 0, '', '', true, 0, true, true, 0); // Write the text
    }

    public function setCustomFooterText($text)
    {
        $this->customFooterText = $text;
    }
}
