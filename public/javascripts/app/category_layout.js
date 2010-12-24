Ext.onReady(function(){
  var viewport = new Ext.Viewport({
    layout : 'border',
    renderTo : Ext.getBody(),
      items:[{
        region: 'north',
        xtype: 'panel',
        html: 'North'
      },{
        region: 'west',
      xtype:'panel',
      split:true,
      width:200,
      html:'West'
      },{





});
