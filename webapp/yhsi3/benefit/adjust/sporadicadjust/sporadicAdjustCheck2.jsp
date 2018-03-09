<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>零星调整审批</title>
<%@ include file="/ta/inc.jsp"%>
<%@ include file="/yhsi3/benefit/common/js/benefit.js"%>
</head>
<body>
	<ta:pageloading />
	<ta:toolbar id="tlb">
		<ta:button id="to_save" icon="xui-icon-spotSave" key="保存[S]" hotKey="ctrl+S" onClick="toSave()" asToolBarItem="true" />
		<ta:button id="colseBtn" key="关闭[C]" icon="xui-icon-spotClose" hotKey="ctrl+C" onClick="parent.Base.closeWindow('userwin');" asToolBarItem="true" />
	</ta:toolbar>
	<ta:form id="form1" fit="true" cssStyle="overflow:auto;">
		<ta:panel id="procInc" key="审核信息" cssStyle="display:none;">
			<%@ include file="/yhsi3/comm/veritySuggestView1.jsp"%>
			<%@ include file="/yhsi3/comm/veritySuggestView2.jsp"%>
		</ta:panel>
		<%@ include file="/yhsi3/benefit/common/treatmentTypes.jsp"%>
		<ta:panel id="flt_jbxx" cols="3" key="基本信息">
			<%@ include file="/yhsi3/benefit/common/personBaseInfo.jsp"%>
			<%@ include file="/yhsi3/benefit/common/treatmentBaseInfo.jsp"%>
			<ta:text id="aaz257" display="false" labelWidth="130" key="享受定期待遇人员ID" />
		</ta:panel>
		<ta:panel id="ac61ListPanel" key="调整明细信息" bodyStyle="margin:0px">
			<ta:datagrid id="ac79ListGrid" forceFitColumns="true" height="235">
				<ta:datagridItem id="aae140" key="险种类型" width="175px" collection="AAE140" hiddenColumn="true" />
				<ta:datagridItem id="aae177" key="调整方式" width="95px" collection="AAE177" />
				<ta:datagridItem id="aae043" key="调整开始年月" width="90px" formatter="convertState" align="right" dataAlign="right" />
				<ta:datagridItem id="aae176" key="调整数值" width="65px" formatter="convertState" align="right" dataAlign="right" />
				<ta:datagridItem id="aaa036" key="待遇项目" width="90px" collection="AAA036" />
				<ta:datagridItem id="aae192" key="调整前金额" width="75px" formatter="convertState" align="right" dataAlign="right" />
				<ta:datagridItem id="aae188" key="调整差额" width="75px" formatter="convertState" align="right" dataAlign="right" />
				<ta:datagridItem id="aae193" key="调整后金额" width="75px" formatter="convertState" align="right" dataAlign="right" />
				<ta:datagridItem id="aaa077" key="补扣发业务类型" width="105px" collection="AAA077" />
				<ta:datagridItem id="aae041" key="补退开始年月" width="90px" dataAlign="center" />
				<ta:datagridItem id="aae042" key="补退结束年月" width="90px" dataAlign="center" />
				<ta:datagridItem id="aae058" key="补退金额" width="65px" align="right" dataAlign="right" formatter="convertState" dataType="number" />
				<ta:datagridItem id="aae036" key="经办时间" width="145px" dataAlign="center" align="center" />
				<ta:datagridItem id="aae011" key="经办人" collection="YAE092" width="85px" />
			</ta:datagrid>
		</ta:panel>
	</ta:form>
</body>
</html>
<script type="text/javascript">
	function toSave() {
		Base.setDisabled("to_save");
		Base.submit("form1", "sporadicAdjustCheck2Action!toSave.do", null, null, null, function() {
		});
	}
	
	//人员信息RPC
	function showRyRPC() {
		Base.openWindow("newRPCWindow", "RPC查询窗口", myPath() + "/newRPCWindows/newRPCWindowsAction!showRPCWindow01.do", null, 1000, 450, null, null, true);
	}
	
	function convertState(row, cell, value, columnDef, dataContext) {
		return "<div style='color:red;font-weight:bolder;margin-top:4px;text-align:right'>" + value + "</div>";
	}
</script>
<%@ include file="/ta/incfooter.jsp"%>