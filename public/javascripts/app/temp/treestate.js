// vim: sw=4:ts=4:nu:nospell:fdc=4
/*global Ext, Example */
/**
 * Asynchronous Tree State Example
 *
 * @author    Ing. Jozef Sakáloš
 * @copyright (c) 2009, by Ing. Jozef Sakáloš
 * @date      4. April 2008
 * @version   $Id: treestate.js 144 2009-04-07 13:04:52Z jozo $
 *
 * @license treestate.js is licensed under the terms of the Open Source
 * LGPL 3.0 license. Commercial use is permitted to the extent that the
 * code/component(s) do NOT become part of another Open Source or Commercially
 * licensed development library or toolkit without explicit permission.
 *
 * License details: http://www.gnu.org/licenses/lgpl.html
 */

Ext.ns('Ext.ux.tree');

Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

var tree = new Ext.tree.TreePanel({
     id:'tree'
    ,autoScroll:true
//  ,rootVisible:false
    ,root:{
         nodeType:'async'
        ,id:'root'
        ,text:'Solar System'
        ,expanded:true
    }
    ,loader: {
         url:'get-tree.php'
        ,baseParams:{
             cmd:'getChildren'
            ,treeTable:'tree2'
            ,treeID:1
        }
    }
    ,plugins:[new App.ux.state.TreePanel()]
}); // eo tree

// main entry point
Ext.onReady(function() {

    // create and show window
    var win = new Ext.Window({
         id:'combo-win'
        ,title:Ext.fly('page-title').dom.innerHTML
        ,layout:'fit'
        ,width:280
        ,height:360
        ,closable:false
        ,border:false
        ,items:tree
    });

    win.show();

}); // eo onReady

// eof