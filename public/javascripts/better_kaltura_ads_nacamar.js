if( document.URL.indexOf('forceMobileHTML5') != -1 ){
  mw.setConfig( 'forceMobileHTML5' , true );
}
mw.setConfig( 'EmbedPlayer.OverlayControls', false );
mw.setConfig('Kaltura.ServiceUrl' , 'http://medianac.nacamar.de');
mw.setConfig('Kaltura.CdnUrl' , 'http://mn.mdn.nacamar.de');
mw.setConfig('KalturaServiceBase', 'http://medianac.nacamar.de/api_v3/index.php?service=');
$( mw ).bind( 'Kaltura.SendAnalyticEvent', function( monitorEvent ){
  $('#analyticsLog').append( monitorEvent + "\n");
});
