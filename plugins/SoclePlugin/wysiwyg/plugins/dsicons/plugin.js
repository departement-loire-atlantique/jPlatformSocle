!function($) {
	
/* * * * * * * * * * * * * * * * * * * 
 *                                   *
 * Inspiré du module emoji de Jalios *
 *                                   *  
 * * * * * * * * * * * * * * * * * * */ 
	
  tinymce.PluginManager.add('dsicons', function(editor, url) {

      function getEmojiPickerIFrameId() {
        return editor.id+'_emoji_iframe';
      }
      function getHtml() {
    	return '<iframe id="'+getEmojiPickerIFrameId()+'" src="plugins/SoclePlugin/wysiwyg/plugins/dsicons/iconList.jsp" scrolling="no" style="overflow:hidden;border:0;width:300px;height:140px;"></iframe>';    	  
      }

      var panelButton = editor.addButton('dsicons', {
        tooltip: 'icônes',
        icon : 'mce-ico mce-i-emoticons', // reuse icon of TinyMCE emoticons plugin 
        type: 'panelbutton',
        panel: {
          role: 'application',
          autohide: true,
          html: getHtml,
          minWidth: 300,
          minHeight: 140
        },
        stateSelector: ['img.emoji']
      });
      
      // Listen to even triggered by icon-picker.js on iframe to insert in editor
      $(document).on('icon-selected', '#'+getEmojiPickerIFrameId(), function(event) {
        editor.execCommand('mceInsertContent', false, event.emoji);
        editor.controlManager.buttons.dsicons.panel.hide();
        editor.focus();
      });


      


      
  });
  
}(window.jQuery);
