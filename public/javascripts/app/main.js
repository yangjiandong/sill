/**
 * 系统主页面
 */
var uiDcInc;
Ext.ns("Ext.app");

Ext.app.Main = function() {
  /* -------------------- private属性 -------------------- */
  var aboutWin, menuBar, menuComponent, mainPanel, viewport;
  var sysConfig, subSysMenu, thumbTemplate;
  var maxPanelNum = 3;

  /* -------------------- private方法 -------------------- */
  /**
   * 创建菜单栏显示模板
   */
  function initTemplates() {
    thumbTemplate = new Ext.XTemplate(
        '<tpl for=".">',
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
                  mainPanel.loadContent(selRecord.data.url, selRecord.data.oid,
                      selRecord.data.text);
                }
              }
            });

        menuComponent.add({
              id : 'menu-according-panel-' + subSys[i].oid,
              region : 'center',
              layout : 'fit',
              cls : 'img-chooser-view',
              title : '<img src="public/icons/menus/' + subSys[i].oid
                  + '.gif">&nbsp;' + subSys[i].text,
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
    aboutWin = new Ext.app.AboutWin({
          sysConfig : sysConfig
        });

    var statusBar = new Ext.BoxComponent({
          region : 'south',
          height : 18,
          autoEl : {
            html : '<center>&nbsp;&copy;' + sysConfig.copyright + '</center>'
          }
        });

    mainPanel = new Ext.app.MainPanel();
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
    var curUser = Ext.Utils.getCurUser();
    if (curUser) {
      Ext.get('cur-user-name').dom.innerHTML = curUser.userName;
    }
  }

  /* ----------------------- public方法 ----------------------- */
  return {
    init : function() {
      uiDcInc = new Ext.util.MixedCollection();
      sysConfig = Ext.app.Utils.getSysConfig();

      initUiDcIncludes(uiDcInc);
      initTemplates();
      createMenus();
      createViewport();
      getCurUserInfos();
    }
  }
}();

Ext.onReady(Ext.app.Main.init, Ext.app.Main, true);
