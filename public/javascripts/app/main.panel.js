Ext.ns("Ext.app");

/* 操作界面主面板 */
Ext.app.MainPanel = function() {
  var html = [
      '<div id="welcome-div">',
      '<div style="float:left;"><img src="public/images/layout-icon.gif" /></div>',
      '<div style="margin-left:100px;">', '<h2>欢迎使用财务一体化管理系统！</h2>', '<p></p>',
      '</div>'];

  Ext.app.MainPanel.superclass.constructor.call(this, {
        id : 'menu-content-panel',
        region : 'center',
        margins : '3 3 3 0',
        resizeTabs : true,
        minTabWidth : 90,
        tabWidth : 150,
        enableTabScroll : true,
        activeTab : 0,
        deferredRender : false,
        items : [{
              id : 'welcome-panel',
              title : '欢迎',
              layout : 'fit',
              bodyStyle : 'padding:25px',
              html : html.join(''),
              autoScroll : true
            }]
      });
}

Ext.extend(Ext.app.MainPanel, Ext.TabPanel, {
  // NEW_LINE : '\n',
  // CFG_DEPLOYMENT_TYPE : 'DEV',
  loadContent : function(href, menuId, title) {
    var ifrId = 'frame-' + menuId;
    var tabId = 'contants-tab-' + menuId;

    if (Ext.isEmpty(document.getElementById(ifrId))
        && !Ext.isEmpty(window.frames[ifrId])) {
      delete window.frames[ifrId];
    }

    if (!Ext.isEmpty(document.getElementById(ifrId))) {
      if (this.getActiveTab().getId() == tabId) {
        this.loadMenuLink(ifrId, href);
      } else {
        this.activate(tabId);
      }
    } else {
      this.add(new Ext.Panel({
        title : title,
        id : tabId,
        autoScroll : true,
        layout : 'fit',
        closable : true,
        html : '<iframe id="'
            + ifrId
            + '" name="'
            + ifrId
            + '" src="about:blank" style="border:0;width:100%;height:100%;overflow: hidden" FRAMEBORDER="no"></iframe>'
      }));
      this.activate(tabId);
      this.loadMenuLink(ifrId, href);
    }

    this.doLayout();
  },
  loadMenuLink : function(ifrId, href) {
    var curIframe = window.frames[ifrId];

    var htmlString = this.buildHtml(href);
    curIframe.document.open("text/html", "replace");
    curIframe.document.write(htmlString);
    curIframe.document.close();
  },
  buildHtml : function(href) {
    var out = '';
    out += '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">'
        + NEW_LINE;
    out += '<html>' + NEW_LINE;
    out += this.buildHtmlHead(href);
    out += this.buildHtmlBody();
    out += '</html>' + NEW_LINE;
    out += '';
    return out;
  },
  buildHtmlHead : function(href) {
    var out = '';
    out += '<head>' + NEW_LINE;
    out += '  <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=UTF-8"/>'
        + NEW_LINE;
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') { // 开发模式(DEV)
      out += '  <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE"/>'
          + NEW_LINE;
    } else { // 生产模式(PROD)
      out += '  <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PRIVATE"/>'
          + NEW_LINE;
    }

    out += this.buildImportExtjs();
    out += this.buildImportDwrBase();
    out += this.buildImportEkingBase();
    out += this.buildImportDoc(href);
    out += '</head>' + NEW_LINE;
    out += '';
    return out;
  },
  buildHtmlBody : function() {
    var out = '';
    out += '<body>' + NEW_LINE;
    out += '</body>' + NEW_LINE;
    out += '';
    return out;
  },
  buildImportExtjs : function() {
    var out = '';
    out += '  <link rel="stylesheet" type="text/css" href="public/extjs/resources/css/ext-all.css"/>'
        + NEW_LINE;
    out += '  <link rel="stylesheet" type="text/css" href="public/css/default.css"/>'
        + NEW_LINE;
    out += ' <link rel="stylesheet" type="text/css" href="public/css/app.css"/>'
        + NEW_LINE;
    out += ' <link rel="stylesheet" type="text/css" href="public/css/portal.css"/>'
        + NEW_LINE; // 窗体拖拽
    out += '  <script type="text/javascript" src="public/extjs/ext-base.js" ><\/script>'
        + NEW_LINE;
    out += '  <script type="text/javascript" src="public/extjs/ext-all.js" ><\/script>'
        + NEW_LINE;
    out += '  <script type="text/javascript" src="public/extjs/ext-lang-zh_CN.js"><\/script>'
        + NEW_LINE;
    out += '  <script type="text/javascript" src="public/drag/miframe.js"><\/script>'
        + NEW_LINE; // 窗体拖拽
    out += '  <script type="text/javascript" src="public/drag/Portal.js"><\/script>'
        + NEW_LINE; // 窗体拖拽
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') {
      out += '  <script type="text/javascript" src="public/extjs/debug.js" ><\/script>'
          + NEW_LINE;
    }

    if (Ext.isIE) {
      out += '<script id="ie-deferred-loader" defer="defer" src="//:"></script>'
          + NEW_LINE;
    }

    out += '';
    return out;
  },
  buildImportEkingBase : function() {
    var out = '';
    out += '  <script type="text/javascript" src="public/js/common/core.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-grid.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-edit-grid.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-form.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/utils.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/column-tree.js'
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/tdgi.borderLayout.js'
        + '"><\/script>' + NEW_LINE;

    out += '';
    return out;
  },
  buildImportDwrBase : function() {
    var out = '';
    var ts = '';
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') {
      ts = '?_t_=' + (new Date()).getTime();
    }

    out += '  <script type="text/javascript" src="dwr/engine.js' + ts
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/util.js' + ts
        + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/interface/SysFacade.js'
        + ts + '"><\/script>' + NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/interface/FaFacade.js'
        + ts + '"><\/script>' + NEW_LINE;

    out += '';
    return out;
  },
  buildImportDoc : function(jsUI) {
    var basePath = 'public/js/';
    var out = '';
    var ts = '';
    // if (this.CFG_DEPLOYMENT_TYPE == 'DEV') {
    // ts = '?_t_=' + (new Date()).getTime();
    // }

    var pDcArray = uiDcInc.get(jsUI)
    if (pDcArray != undefined) {
      for (var j = 0; j < pDcArray.length; j++) {
        out += '<script  type="text/javascript" src="' + basePath + pDcArray[j]
            + ts + '"><\/script>' + NEW_LINE;
      }
    }

    out += '';
    return out;
  }

});