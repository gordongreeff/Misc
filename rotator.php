<?php

$site_list = array (
'https://reports.zoho.com/ZDBDataSheetView.cc?OBJID=795632000000008948&STANDALONE=true&privatelink=6a3a468b81c87d3fd41365f755d3ab89&ZDB_THEME_NAME=blue'
'http://ran.isnet.net/sysmon.html'
'http://guava2.isnet.net/weathermap/ismetro-wc1.html'
'http://guava2.isnet.net/weathermap/ismetro-gp1.html'
'http://guava2.isnet.net/weathermap/ismetro-gp2.html'
'http://guava2.isnet.net/weathermap/ismetro-gp3.html'
'http://guava2.isnet.net/weathermap/ismetro-gp5.html'
'http://guava2.isnet.net/weathermap/africa-map.html'
'http://paul.isnet.net/weathermap/eastafrica.html'
'http://paul.isnet.net/weathermap/international-bandwidth-overview-mpls.html'
'http://paul.isnet.net/weathermap/international-peering-and-transit.html'
'http://paul.isnet.net/weathermap/internet-breakouts.html'
'http://paul.isnet.net/weathermap/za-peering.html'
'http://guava2.isnet.net/weathermap/is-cdn.html'
'http://guava.isnet.net/not/cms-view.html'
'http://guava2.isnet.net/weathermap/wireless-bry-mesh.html',
'http://guava2.isnet.net/weathermap/wireless-rba-mesh-1.html',
'http://guava2.isnet.net/weathermap/wireless-rba-mesh-2.html',
'http://guava2.isnet.net/weathermap/wireless-cpt-mesh.html',
'http://guava2.isnet.net/weathermap/wireless-umh-mesh.html',
'http://guava2.isnet.net/weathermap/wireless-pta-mesh.html',
'http://guava2.isnet.net/weathermap/wireless-regions-mesh.html'
);

$site_delay = 30;

$currentSite = $_GET['currentSite'];
$num_of_sites = count($site_list);

$site_pos = array_search($currentSite, $site_list);

$next_site = $site_pos + 1;

if ($next_site >= $num_of_sites || $next_site < 0)
     {
$next_site = 0;
     }

$show_site = $site_list[$next_site];

?>

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html">
<META HTTP-EQUIV="Refresh"  CONTENT="<?php echo $site_delay ?>;URL=wrl-rotator.php?currentSite=<?php echo $show_site ?>">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<TITLE>Rotator</TITLE>
</HEAD>

      <FRAMESET>
            <FRAME name="mainbody" src="<?php echo $show_site ?>" marginwidth="0" marginheight="0" SCROLLING=NO>
      </FRAMESET>


      <BODY>
      <H2>Sorry!</H2>
      This is a Web page using frames. You will need a program like
      Netscape or Internet Explorer to view this page.
    </BODY>
</HTML>
