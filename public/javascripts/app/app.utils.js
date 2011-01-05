Ext.namespace('Ext.app.Utils');

/**
 * 获取当前用户的信息
 */
Ext.app.Utils.getCurUser = function() {
  var curUser;
  SysFacade.getCurUserInfo({
        callback : function(retValue) {
          curUser = retValue;
        },
        async : false
      });

  return curUser;
}

/**
 * 根据当前字符串,获取五笔助记符和拼音助记符
 */
Ext.app.Utils.getMemo = function(str) {
  var result;
  SysFacade.getMemo(str, {
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (!result)
    return {
      py : '',
      wb : ''
    };
  return result;
}

Ext.app.Utils.getCurrentMonthDays = function() {
  var result;
  FaFacade.getCurrentMonthDays({
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (!result)
    return {
      startDate : '',
      endDate : '',
      yearMonth : ''
    };
  return result;
}

Ext.app.Utils.getNowString = function() {
  var result;
  SysFacade.getNowString({
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (!result)
    return '';
  return result;
}

/**
 * 获取住院或门诊的标识
 *
 * @param {}
 *          str : 门诊(in)、住院(out)
 */
Ext.app.Utils.getBookCategory = function(name) {
  var result;
  FaFacade.getBookCategory(name, {
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });

  if (result != null && result.success) {
    return result.category;
  } else {
    return "";
  }
}

/**
 * 判断当前登录用户是否有报销单模块的相应权限
 */
Ext.app.Utils.haveCompetence = function(moduleName) {
  var result;
  FaFacade.haveCompetence(moduleName, {
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (result.success) {
    return result.data;
  }
  return false;
}

/**
 * 判断用户选取的会计科目是否存在并且是叶子节点
 */
Ext.app.Utils.isValidSubject = function(subjectCode) {
  var result;
  FaFacade.isValidSubject(subjectCode, {
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (result.success) {
    return result.data;
  }
  return false;
}

/**
 * 获取系统配置信息
 */
Ext.app.Utils.getSysConfig = function() {
  var result;
  SysFacade.getSysConfig({
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (result.success) {
    return result.data;
  }

  return null;
}

Ext.app.Utils.getSysConfig2 = function() {
  var result;
  SysFacade.getSysConfig({
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (result.success) {
    return result.data;
  }

  return null;
}

/**
 * 获取系统配置参数(sys_fa:系统级或程序级，code:参数编码)
 */
Ext.app.Utils.getSetupValue = function(sys_fa, code) {
  var result;
  FaFacade.getSetupValue(sys_fa, code, {
        callback : function(retValue) {
          result = retValue;
        },
        async : false
      });
  if (result.success) {
    return result.data;
  }

  return null;
}

/**
 * 在原字符串的左侧添加若干个字符,以使字符串达到指定的长度
 *
 * @param {}
 *          str:原字符串
 * @param {}
 *          size：目标字符串总长度
 * @param {}
 *          padChar:附加的字符
 * @return {}
 */
Ext.app.Utils.leftPad = function(str, size, padStr) {
  if (Ext.isEmpty(str)) {
    return '';
  }
  var pads = size - str.length;
  if (pads <= 0) {
    return str;
  } else {
    var buf = [];
    for (var i = 0; i < pads; i++) {
      buf.push(padStr);
    }

    var padding = buf.join('');
    return padding.concat(str);
  }
}