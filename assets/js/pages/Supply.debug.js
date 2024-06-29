//! Supply.debug.js
//

(function($) {


Type.registerNamespace('Supply');

////////////////////////////////////////////////////////////////////////////////
// Supply.DiversionPageMgr

Supply.DiversionPageMgr = function Supply_DiversionPageMgr() {
    /// <field name="_cntDiv" type="jQueryObject" static="true">
    /// </field>
}
Supply.DiversionPageMgr.start = function Supply_DiversionPageMgr$start() {
    Supply.DiversionPageMgr._cntDiv = $('#ContainerDiv');
    Supply.DiversionPageMgr._cntDiv.html('testing');
}


Supply.DiversionPageMgr.registerClass('Supply.DiversionPageMgr');
Supply.DiversionPageMgr._cntDiv = null;
})(jQuery);

//! This script was generated using Script# v0.7.4.0
