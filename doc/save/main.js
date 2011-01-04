/**
 * 系统主页面
 */
Ext.namespace('Divo');
Ext.namespace('Divo.app');
Ext.QuickTips.init();
Ext.BLANK_IMAGE_URL = 'public/extjs/resources/images/default/s.gif';

var uiDcInc;

/**
 * 关于对话框
 */
Divo.app.AboutWin = Ext.extend(Ext.Window, {
      itemPanel : null,
      sysConfig : null,
      initComponent : function() {
        // 创建内容
        this.itemPanel = this.getItemPanel();

        Ext.apply(this, {
              iconCls : 'icon-win',
              autoHeight : false,
              title : this.sysConfig ? '关于&nbsp;&nbsp;' + this.sysConfig.productName : '关于',
              width : 570,
              height : 320,
              layout : 'border',
              plain : false,
              buttonAlign : 'right',
              closable : true,
              closeAction : 'hide',
              modal : true,
              items : [this.itemPanel],
              buttons : [{
                    text : '确定',
                    handler : this.onWinHide.createDelegate(this)
                  }]
            });

        Divo.app.AboutWin.superclass.initComponent.apply(this, arguments);
      },
      render : function() {
        Divo.app.AboutWin.superclass.render.apply(this, arguments);
      },
      initEvents : function() {
        Divo.app.AboutWin.superclass.initEvents.call(this);
      },
      /**
       * 关闭窗体
       */
      onWinHide : function() {
        this.hide();
      },
      getItemPanel : function() {
        if (this.itemPanel) {
          return this.itemPanel;

        } else {
          var item;
          if (this.sysConfig == null) {
            item = new Ext.Panel({
                  region : 'center',
                  html : '没有找到系统配置信息'
                });

          } else {
            var html = [
                '<table width="100%" border="0" cellspacing="0" cellpadding="0">',
                ' <tr>',
                '<td colspan="2" align="right"><img src="public/images/about.gif"></td>',
                '</tr>',
                '<tr>',
                '<td width="7%">&nbsp;</td>',
                '<td width="93%"><table width="100%" border="0" cellspacing="0" cellpadding="0">',
                '<tr>',
                '<td height="35" class="moduleTitle" >' + this.sysConfig.productName + '</td>',
                '</tr>',
                '<tr>',
                '<td><p>版本: <span>' + this.sysConfig.version + '</span></p>',
                '</tr>',
                '<tr>',
                '<td><p>构建标识: <span>' + this.sysConfig.buildId + '</span></p>',
                '</tr>',
                '<tr>',
                '<td><p>版权所有&nbsp;&copy;' + this.sysConfig.copyright + '</p>',
                '</tr>',
                '<tr>',
                '<td><p>请访问: <a href="' + this.sysConfig.website + '"  target="_blank">'
                    + this.sysConfig.website + '</a></p>', '</tr>', '</table></td>', '</tr>'];
            item = new Ext.Panel({
                  region : 'center',
                  html : html.join('')
                });
          }

          return item;
        }

      }
    });
Ext.reg('Divo.app.AboutWin', Divo.app.AboutWin);

/* 操作界面主面板 */
Divo.app.MainPanel = function() {
  var html = ['<div id="welcome-div">',
      '<div style="float:left;"><img src="public/images/layout-icon.gif" /></div>',
      '<div style="margin-left:100px;">', '<h2>欢迎使用财务一体化管理系统！</h2>', '<p></p>', '</div>'];

  Divo.app.MainPanel.superclass.constructor.call(this, {
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

Ext.extend(Divo.app.MainPanel, Ext.TabPanel, {
  NEW_LINE : '\n',
  CFG_DEPLOYMENT_TYPE : 'DEV',
  loadContent : function(href, menuId, title) {
    var ifrId = 'frame-' + menuId;
    var tabId = 'contants-tab-' + menuId;

    if (Ext.isEmpty(document.getElementById(ifrId)) && !Ext.isEmpty(window.frames[ifrId])) {
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
        + this.NEW_LINE;
    out += '<html>' + this.NEW_LINE;
    out += this.buildHtmlHead(href);
    out += this.buildHtmlBody();
    out += '</html>' + this.NEW_LINE;
    out += '';
    return out;
  },
  buildHtmlHead : function(href) {
    var out = '';
    out += '<head>' + this.NEW_LINE;
    out += ' 	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=UTF-8"/>' + this.NEW_LINE;
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') { // 开发模式(DEV)
      out += ' 	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE"/>' + this.NEW_LINE;
    } else { // 生产模式(PROD)
      out += ' 	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PRIVATE"/>' + this.NEW_LINE;
    }

    out += this.buildImportExtjs();
    out += this.buildImportDwrBase();
    out += this.buildImportEkingBase();
    out += this.buildImportDoc(href);
    out += '</head>' + this.NEW_LINE;
    out += '';
    return out;
  },
  buildHtmlBody : function() {
    var out = '';
    out += '<body>' + this.NEW_LINE;
    out += '</body>' + this.NEW_LINE;
    out += '';
    return out;
  },
  buildImportExtjs : function() {
    var out = '';
    out += '  <link rel="stylesheet" type="text/css" href="public/extjs/resources/css/ext-all.css"/>'
        + this.NEW_LINE;
    out += '  <link rel="stylesheet" type="text/css" href="public/css/default.css"/>'
        + this.NEW_LINE;
    out += ' <link rel="stylesheet" type="text/css" href="public/css/app.css"/>' + this.NEW_LINE;
    out += ' <link rel="stylesheet" type="text/css" href="public/css/portal.css"/>' + this.NEW_LINE; // 窗体拖拽
    out += '  <script type="text/javascript" src="public/extjs/ext-base.js" ><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/extjs/ext-all.js" ><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/extjs/ext-lang-zh_CN.js"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/drag/miframe.js"><\/script>'
        + this.NEW_LINE; // 窗体拖拽
    out += '  <script type="text/javascript" src="public/drag/Portal.js"><\/script>'
        + this.NEW_LINE; // 窗体拖拽
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') {
      out += '  <script type="text/javascript" src="public/extjs/debug.js" ><\/script>'
          + this.NEW_LINE;
    }

    if (Ext.isIE) {
      out += '<script id="ie-deferred-loader" defer="defer" src="//:"></script>' + this.NEW_LINE;
    }

    out += '';
    return out;
  },
  buildImportEkingBase : function() {
    var out = '';
    out += '  <script type="text/javascript" src="public/js/common/core.js' + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-grid.js' + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-edit-grid.js'
        + '"><\/script>' + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/base-form.js' + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/utils.js' + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/column-tree.js' + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="public/js/common/tdgi.borderLayout.js'
        + '"><\/script>' + this.NEW_LINE;

    out += '';
    return out;
  },
  buildImportDwrBase : function() {
    var out = '';
    var ts = '';
    if (this.CFG_DEPLOYMENT_TYPE == 'DEV') {
      ts = '?_t_=' + (new Date()).getTime();
    }

    out += '  <script type="text/javascript" src="dwr/engine.js' + ts + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/util.js' + ts + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/interface/SysFacade.js' + ts + '"><\/script>'
        + this.NEW_LINE;
    out += '  <script type="text/javascript" src="dwr/interface/FaFacade.js' + ts + '"><\/script>'
        + this.NEW_LINE;

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
        out += '<script  type="text/javascript" src="' + basePath + pDcArray[j] + ts
            + '"><\/script>' + this.NEW_LINE;
      }
    }

    out += '';
    return out;
  }

});

Divo.app.Main = function() {
  /* -------------------- private属性 -------------------- */
  var aboutWin, menuBar, menuComponent, mainPanel, viewport;
  var sysConfig, subSysMenu, thumbTemplate;
  var maxPanelNum = 3;

  /* -------------------- private方法 -------------------- */
  /**
   * 创建菜单栏显示模板
   */
  function initTemplates() {
    thumbTemplate = new Ext.XTemplate('<tpl for=".">',
        '<div class="thumb-wrap" id="menu-icon-div-{oid}">',
        '<div class="thumb"><img src="public/icons/menus/{oid}.gif" title="{text}"></div>',
        '<span>{text}</span></div>', '</tpl>');
  }

  // 创建菜单栏
  function createMenus() {
    subSysMenu = new Ext.menu.Menu({
          id : 'sys-menu',
          items : []
        });
    var sessionMenu = new Ext.menu.Menu({
          id : 'session-menu',
          style : {
            overflow : 'visible'
          },
          items : [{
                id : "menu-logout",
                text : '注销',
                handler : function() {
                  doLogout();
                },
                scope : this,
                disabled : false
              }, "-", {
                id : "menu-lock",
                text : '锁屏',
                handler : function() {
                  // doLockSession();
                },
                scope : this,
                disabled : false
              }]
        });

    var aboutMenu = new Ext.menu.Menu({
          id : 'about-menu',
          style : {
            overflow : 'visible'
          },
          items : [{
                text : '关于',
                handler : function() {
                  aboutWin.show();
                },
                scope : this
              }, {
                text : '在线帮助',
                handler : function() {
                },
                scope : this,
                disabled : true
              }]
        });

    menuBar = new Ext.Toolbar({
          id : 'menu-toolbar',
          items : [new Ext.Toolbar.Separator(), {
                text : '子系统',
                icon : 'public/icons/subsys.gif',
                menu : subSysMenu
              }, {
                text : '会话',
                icon : 'public/icons/session.gif',
                menu : sessionMenu
              }, {
                text : '帮助',
                icon : 'public/icons/help.gif',
                menu : aboutMenu
              }, '->', '当前用户:&nbsp;&nbsp;<span id="cur-user-name"></span>']
        });
  }

  /**
   * 加载子系统的菜单,并关闭mainPanel中已打开的面板
   */
  function loadModuleMenu(item) {
    // onCloseMainPanelTabs();
    menuComponent.setTitle(item.text);
    menuComponent.removeAll(true);
    Ext.Ajax.request({
          url : 'loadMenu.htm',
          params : {
            module : item.code
          },
          success : onGetAllMenu
        });
  }

  /**
   * 获得子系统的所有菜单信息后
   */
  function onGetAllMenu(r) {
    var data = Ext.decode(r.responseText);

    if (data != null && data.success) {
      subSys = data.subSystems;
      for (var i = 0; i < subSys.length; i++) {
        var store = new Ext.data.JsonStore({
              url : 'loadMenu.htm',
              idProperty : 'oid',
              root : 'subSystems',
              fields : ['oid', 'text', 'url']
            });

        store.on('beforeload', function(store, options) {
              store.baseParams.module = subSys[i].oid;
            }, this, true);

        store.load();

        var dataView = new Ext.DataView({
              tpl : thumbTemplate,
              singleSelect : true,
              store : store,
              overClass : 'x-view-over',
              itemSelector : 'div.thumb-wrap',
              emptyText : 'No images to display',
              listeners : {
                'click' : function(dataview, index, node, e) {
                  e.stopEvent();
                  var selRecord = dataview.getSelectedRecords()[0];
                  mainPanel
                      .loadContent(selRecord.data.url, selRecord.data.oid, selRecord.data.text);
                }
              }
            });

        menuComponent.add({
          id : 'menu-according-panel-' + subSys[i].oid,
          region : 'center',
          layout : 'fit',
          cls : 'img-chooser-view',
          title : '<img src="public/icons/menus/' + subSys[i].oid + '.gif">&nbsp;' + subSys[i].text,
          autoScroll : true,
          items : [dataView]
        });
      }
    }

    menuComponent.doLayout();
  }

  // 关闭全部打开的主面板Tab Panel
  function onCloseMainPanelTabs() {
    var ps = []
    var items = mainPanel.items.items;
    for (var i = 1; i < items.length; i++) {
      ps.push(items[i].id);
    } // [0]为占位Panel
    for (var i = 0; i < ps.length; i++) {
      mainPanel.remove(mainPanel.getItem(ps[i]), true);
    }
  }

  // 创建布局
  function createViewport() {
    aboutWin = new Divo.app.AboutWin({
          sysConfig : sysConfig
        });

    var statusBar = new Ext.BoxComponent({
          region : 'south',
          height : 18,
          autoEl : {
            html : '<center>&nbsp;&copy;' + sysConfig.copyright + '</center>'
          }
        });

    mainPanel = new Divo.app.MainPanel();
    // 限制最多能打开的面板,防止浏览器过载崩溃
    mainPanel.on('beforeadd', function(container, component, index) {
          if (index > maxPanelNum) {
            var items = container.items.items;
            var menuId = items[1].id; // [0]为占位Panel
            var tab = mainPanel.getItem(menuId)
            mainPanel.remove(tab, true);
          }
        });

    mainPanel.on('tabchange', function(tabpanel, tab) {
          if (document.getElementById("activeFrameId")) {
            document.getElementById("activeFrameId").value = tab.getId();
          }
        });

    menuComponent = new Ext.Panel({
          region : 'west',
          id : 'west-panel', // see Ext.getCmp() below
          title : '系统导航',
          split : true,
          width : 150,
          minSize : 120,
          maxSize : 180,
          collapsible : true,
          collapsedTitle : true,
          margins : '3 0 3 3',
          layout : {
            type : 'accordion',
            animate : true
          }
        });

    var titleBar = new Ext.Panel({
          region : 'north',
          id : 'north-panel',
          split : false,
          height : 56,
          border : false,
          collapsible : false,
          margins : '0 0 0 0',
          layout : 'border',
          items : [{
            region : 'north',
            html : '<div id="titlebar"><input type=hidden value="" id="activeFrameId">'
                + '</input><h1>' + sysConfig.productName + '</h1></div>',
            border : false,
            height : 28
          }, {
            region : 'center',
            border : false,
            height : 26,
            items : [menuBar]
          }]
        });

    viewport = new Ext.Viewport({
          layout : 'tdgi_border',
          items : [titleBar, statusBar, menuComponent, mainPanel],
          listeners : {
            render : function() {
              Ext.Ajax.request({
                    url : 'loadSubSystem.htm',
                    success : successFn
                  });
            }
          }
        });

  }

  // viewport 渲染后，加载子系统菜单项
  function successFn(response) {
    var data = Ext.decode(response.responseText);

    if (data != null && data.success) {
      subSys = data.subSystems;
      for (var i = 0; i < subSys.length; i++) {
        var menuCode = subSys[i].oid;
        var menuName = subSys[i].text;

        subSysMenu.add({
              id : 'menu-' + subSys[i].oid,
              icon : 'public/icons/menus/' + subSys[i].oid + '.gif',
              code : subSys[i].oid,
              text : subSys[i].text,
              handler : loadModuleMenu
            });
      }
    }

  }

  // 注销
  function doLogout() {
    Ext.Ajax.request({
          url : "logout.htm",
          scope : this,
          callback : function(o, s, r) {
            var respText = Ext.decode(r.responseText);
            if (respText.success && respText.message == "OK") {
              viewport.destroy();
              window.location.href = 'login.htm';
            } else {
              if (!Ext.isEmpty(respText.message)) {
                Ext.Msg.alert('错误', respText.message);
              } else {
                Ext.Msg.alert('错误', '因为不能取得服务端信息，不能正常注销。');
              }
            }
          }
        });
  }

  // 获取当前用户的信息
  function getCurUserInfos() {
    var curUser = Divo.Utils.getCurUser();
    if (curUser) {
      Ext.get('cur-user-name').dom.innerHTML = curUser.userName;
    }
  }

  /* ----------------------- public方法 ----------------------- */
  return {
    init : function() {
      uiDcInc = new Ext.util.MixedCollection();
      sysConfig = Divo.Utils.getSysConfig();

      initUiDcIncludes(uiDcInc);
      initTemplates();
      createMenus();
      createViewport();
      getCurUserInfos();
    }
  }
}();

Ext.onReady(Divo.app.Main.init, Divo.app.Main, true);
