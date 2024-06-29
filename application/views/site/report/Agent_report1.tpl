<div class="brand_top">
  <h3>Agent Report</h3>
</div>
<div id="main_wrapper">
  <div class="page_content">
    <div id="container-fluid">
      <div class="row">
        <div id="contents" class="col-lg-12">
          <!-- PAGE HEADER-->
          <div class="row" id="containerDiv">
            <div class="form-group col-md-3">
              <label class="sr-only" for="date_from">From Date</label>
              <div class="input-group">
                <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From"></input>
                  <span class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </span>
                </div>
            </div>
            <div class="form-group col-md-3">
              <label class="sr-only" for="date_to">To Date</label>
              <div class="input-group">
                <input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To"></input>
                  <span class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </span>
                </div>
            </div>

            <table rules="all" cellspacing="0" border="0" id="Table1" width="100%">
              <tbody>
                <tr>
                  <td>Agent Name :</td>
                  
                    <td>
                    <select id="userdd"></select>
                  </td>
                </tr>

                <tr>
                  <td colspan="2">
                    <input type="button" id="btnSubmit" value="Render report" />
                  </td>
                </tr>

              </tbody>
            </table>


            <div id="agentGrid" style="overflow: auto">
              <table id="agentRptTable">
              </table>

              <div id="pager"></div>
            </div>
            <div id="noRecFoundDiv" style="display:none;" > No Record found  </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    function init_agent_report() {

    AgentRpt.AgentRptMgr.start();
    }

  </script>
