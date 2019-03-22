/**
 * Plugin's JavaScript sample.
 * 
 * To include this file :
 *  - in a JSP : jcmsContext.addJavaScript("plugins/{Name}/js/plugin.js");
 *  - or in Java : implements PortalPolicyFilter.setupHeaders()
 * 
 * This files contains some sample 'static' like Object and 'instance'
 * like creation using Prototype framework coding style.
 * More information at http://prototypejs.org/api
 *
 * The following comments are declared for JSLint : 
 *  http://www.jslint.com/
 * You should use JSLint to ensure you have a nice and clean JavaScript code.
 */ 
/* JSLint options : */ /*jslint bitwise: true, browser: true, eqeqeq: true */
/* Prototype      : */ /*extern Class, $, $$, Ajax, Element, Event         */ 
/* JCMS           : */ /*extern JCMS, Util, JcmsJsContext, JcmsLogger      */
 
/*
'JCMS.plugin.myplugin'.namespace();

// -----------------------------------------------------------------
// 'Static' like object
JCMS.plugin.myplugin.MyPluginUtils = {

  someFunction : function (arg1, arg2) {
    //...
  },
  
  someOtherFct : function () {
    //...
  }
};

// -----------------------------------------------------------------
// 'Class' like object 

JCMS.plugin.myplugin.MyPlugin = Class.create({
  
  // Constructor
  initialize : function (nickname) {
    this.nickname = nickname;
  },
  
  // method
  welcome :  function () {
    this.saySomething('Welcome !');
  },
  
  saySomething : function (msg) {
    var something = this.nickname + ', ' + msg;
    alert(something);
  }

});

// -----------------------------------------------------------------
// Onload Initialization
  
Event.observe(window, 'load', function() { 
  
  // Using 'static' object
  JCMS.plugin.myplugin.MyPluginUtils.someFunction();
    
  // Creating instances and invoking methods
  var obj1 = new JCMS.plugin.myplugin.MyPlugin('John Doe');
  obj1.welcome();
    
});
  
*/