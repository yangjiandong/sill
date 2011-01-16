Ext.ns('Ext.app.base');

Ext.app.base.SubmitButton = Ext.extend(Ext.Button, {
     text:'确定'
    ,iconCls:'icon-submit'
    ,initComponent:function() {
        Ext.app.base.SubmitButton.superclass.initComponent.apply(this, arguments);
    } // eo function initComponent
}); // eo extend

Ext.reg('submitbutton', Ext.app.base.SubmitButton);

Ext.app.base.CancelButton = Ext.extend(Ext.Button, {
     text:'取消'
    ,iconCls:'icon-undo'
    ,initComponent:function() {
        Ext.app.base.CancelButton.superclass.initComponent.apply(this, arguments);
    } // eo function initComponent
}); // eo extend

Ext.reg('cancelbutton', Ext.app.base.CancelButton);