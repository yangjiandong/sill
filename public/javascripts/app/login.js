Ext.ns("Ext.app");
Ext.app.Login = Ext.extend(Ext.Window, {
      fields : new Ext.util.MixedCollection(),
      authServerUrl : null,
      authObj : null // on successfull authentication, this is filled
      // with session info returned by server(user full
      // name, authentication hash-code, etc)
      ,
      initComponent : function() {
        this.fields.add("username", new Ext.form.TextField({
                  allow_blank : false,
                  value : '',
                  fieldLabel : "用户名",
                  width : 150
                }));
        this.fields.add("password", new Ext.form.TextField({
                  allow_blank : false,
                  value : '',
                  inputType : 'password',
                  fieldLabel : "密码",
                  width : 150
                }));

        Ext.apply(this, {
              title : '用户登录',
              width : 300,
              height : 162,
              layout : "form",
              closable : false,
              closeAction : 'hide',
              bodyStyle : 'padding:10px;',
              plain : true,
              modal : true,
              resizable : false,
              constrain : true,
              items : [this.fields.get("username"),
                  this.fields.get("password")
              // !!!!disable mouse right click and ctrl Z on password field to
              // avoid undo to see the password from the previous login/unlock
              ],
              buttons : [{
                    xtype : "button",
                    scope : this,
                    text : "登录..",
                    handler : this.onLogin
                  }]

            });
        Ext.app.Login.superclass.initComponent.apply(this, arguments);
        this.addEvents('logonSuccess');
      },
      focusUserName : function() {
        this.fields.get("username").focus();
      }

      /**
       * Logon event processing.
       */
      ,
      onLogin : function() {
        Ext.Ajax.request({
              url : this.authServerUrl + "?_p_action=login&_p_sid="
                  + this.fields.get("service").getValue() + "&_p_usr="
                  + this.fields.get("username").getValue() + "&_p_psw="
                  + this.fields.get("password").getValue(),
              callback : this.afterOnlogin,
              scope : this
            });
      }

      /**
       * Post logon processing. If authentication succesful hide the logon
       * window and load the main menu.
       */
      ,
      afterOnlogin : function(o, s, r) {
        var respText = Ext.decode(r.responseText);
        if (respText.success) {
          this.fields.get("password").setRawValue("");
          this.authObj = new Object();
          // Add necessary properties to authObj ...
          this.fireEvent("logonSuccess", this.authObj);
        } else {
          if (!respText.success) {
            Ext.Msg.alert('Autenthication error', urldecode(respText.message));
          }
          this.fields.get("password").setRawValue("");
        }
      }
    });
// Ext.reg("appLogin", Ext.app.Login);

