(function ( $ ) {
  // icon picker
  // see iconList.jsp
  
  var registerPickerEvents = function() {
    
    // Selection of an emoji 
    $(document).on('click', '.listeIcones A', function(event) {
      var $emojiButton = $($(event.target).closest('A')[0]);
      var emoji = $emojiButton ? $emojiButton.attr('data-icon') : null;
      if (parent && parent.jQuery && frameElement) {
        var event = parent.jQuery.Event( "icon-selected" );
        event.emoji = emoji;
        parent.jQuery(frameElement).trigger(event);
        event.stopImmediatePropagation();
        return false;
      }
    });
   
  }

  
  $(document).ready(function(){
    registerPickerEvents();
  });
  

}( jQuery ));

