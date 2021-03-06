
/*
Object.prototype.hasOwnProperty = function(prop) {
  for (var k in this) {
    alert(k);

  }

}
  */
// NEW_LINE = '\n';

function getCurUser() {
  var name;
//        AppSysAction.doEcho('', function(result, e){
//          var t = e.getTransaction();
//          if(e.status){
//              name=result;
//              //alert('test:' + name);
//          }else{
//          }
//
//      });
  return name;
}

function getWindowInnerHeight() {
  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in 'standards compliant mode'
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    //IE 4 compatible
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  return myHeight;
}

function getWindowInnerWidth() {
  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in 'standards compliant mode'
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    //IE 4 compatible
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  return myWidth;
}

function find_window(p_name) {
  return Ext.getCmp(p_name);
}
function show_window(p_name) {
  return Ext.getCmp(p_name).show();
}
function hide_window(p_name) {
  return Ext.getCmp(p_name).hide();
}
function close_window(p_name) {
  return Ext.getCmp(p_name).close();
}

function show_message(p_message, p_type) {
  Ext.Msg.alert(p_type||'Error',p_message );
}

function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else var expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

function eraseCookie(name) {
  createCookie(name,"",-1);
}

/**
 *  Decode a string which has been urlencoded
 */
function urldecode ( str ) {
  var ret = str;
  ret = ret.replace(/\+/g, "%20");
  ret = decodeURIComponent(ret);
  ret = ret.toString();
  return ret;
}



Ext.form.TextField.prototype.caseRestriction = 'Mixed'; //Upper, Lower

Ext.form.TextField.prototype.getValue = function() {
   var v = Ext.form.TextField.superclass.getValue.call(this);
   if (this.caseRestriction == "Upper" ) {
     return v.toUpperCase();
   }else if (this.caseRestriction == "Lower" ) {
     return v.toLowerCase();
   }else
    return v;
}
