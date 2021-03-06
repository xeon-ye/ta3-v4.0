<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" uri="/ta3"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>报销结算</title>
<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar">
	<ta:pageloading />
	<ta:toolbar id="ButtonLayout1">
		<ta:toolbarItem id="queryBtn"   key="查询"    icon="xui-icon-query"          onClick="toQuery()" />
		<ta:toolbarItem id="regBtn"     key="确定"    icon="xui-icon-spotAdd"        onClick="toSave()" />
		<ta:toolbarItem id="closeBtn"   key="退出"    icon="xui-icon-spotClose"      onClick="closeWin()" />
	</ta:toolbar>
	<ta:form id="form1" fit="true">
		<ta:text id="aaz217" key="流水号"  display="false"/>
		<ta:panel id="pnlCxtj" key="查询条件" cols="3" >
			<ta:text id="aac001" key="个人ID" required="true"/>
			<ta:text id="aac003" key="姓名"    readOnly="true"/>
			<ta:text id="aac002" key="身份证号"  readOnly="true"/>
			<ta:text id="akb020"  key="医疗机构编号" popWin="true" popWinType="top" popWinUrl="medicalbenefit/common/commonFunctionAction.do" popWinHeight="500" popWinWidth="900" />
			<ta:text id="akb021" key="医疗机构名称" readOnly="true"  />
			<ta:box span="1" cols="2">
				<ta:date id="aae036_s" key="结算时间" showSelectPanel="true" columnWidth="0.6"/>
				<ta:date id="aae036_e" key="至" labelWidth="15" showSelectPanel="true" columnWidth="0.4"/>
			</ta:box>	
		</ta:panel>
		<ta:panel id="panel2" key="离休二乙门诊信息"  fit="true">
			<ta:datagrid id="dgKc24" fit="true"  forceFitColumns="true" selectType="checkbox" >
				<ta:datagridItem id="aac001" key="个人编号" width="100" align="center" dataAlign="center" />
				<ta:datagridItem id="aac003" key="姓名" width="80" align="center" dataAlign="center" />
				<ta:datagridItem id="aac004" key="性别" width="50" align="center" dataAlign="center" collection="AAC004"/>
				<ta:datagridItem id="aac002" key="身份证号" width="150" align="center" dataAlign="center" />
				<ta:datagridItem id="aab003" key="单位名称" width="150" align="center" showDetailed="true"  dataAlign="center" />
				<ta:datagridItem id="akb021" key="医疗机构名称" width="150" align="center" showDetailed="true" />
				<ta:datagridItem id="aae030" key="就诊日期" width="90" dataType="date" align="center"/>
				<ta:datagridItem id="akc264" key="医疗费总额" width="150" align="center" showDetailed="true" dataAlign="right" />
				<ta:datagridItem id="akc228" key="全自费金额" width="150" align="center" showDetailed="true"  dataAlign="right" />
				<ta:datagridItem id="yka319" key="符合范围部分" width="150" align="center" showDetailed="true"  dataAlign="right"/>
				<ta:datagridItem id="ake034" key="账户支付" width="150" align="center" showDetailed="true"  dataAlign="right"/>
			    <ta:datagridItem id="akb020" key="医疗机构编号" maxChart="6" align="center" showDetailed="true" />
				<ta:datagridItem id="akc191" key="医院流水号"  maxChart="6" />
				<ta:datagridItem id="aaz217" key="就诊流水号"  maxChart="6" />
				<ta:datagridItem id="aaz216" key="结算流水号"  maxChart="6" />
			</ta:datagrid>
	  </ta:panel>
   </ta:form>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
		$("body").taLayout();
		initializeSuggestFramework(1,"", "aac001", 750, 300, 7, fn_getPerson, 0, false);
	});
	// 个人ID change事件
	$("#aac001").change(function(){
		sfwQueryUtilForYl(1,'getAc01ByAae140ForYL',{"dto.jstj":Base.getValue('aac001')});
	});
	// 人员回调函数
	function fn_getPerson(){
		Base.setValue("aac001",g_Suggest[2]);
		Base.setValue("aac003",g_Suggest[1]);
		Base.setValue("aac002",g_Suggest[0]);
	}
	 // 医疗机构放大镜回调方法
	function fnKb01MagifierBack(rowdata){
	   Base.setValue("akb020",rowdata.akb020); // 医疗机构编码
	   Base.setValue("akb021",rowdata.akb021); // 医疗机构名称
	}
	// 关闭窗口
	function closeWin()
	{
		top.lxeymzbbx_aaz217 = Base.getValue("aaz217");
		top.Base.closeWindow("win_reg");
	}
	// 查询
	function toQuery()
	{
		var aac001 = Base.getValue("aac001");
		if("" == aac001 || null == aac001 )
			return Base.alert("请输入个人ID!","warn",function(){
				Base.focus("aac001");
			});
		Base.clearGridData("dgKc24");
		Base.submit("pnlCxtj","lxeyMzBbxAction!toQueryForReg.do");
		Base.setEnable("regBtn");
	}
	
	//保存
    function toSave()
	{
		var gridData = Base.getGridSelectedRows("dgKc24"); // 选中的数据 
		if("" == gridData || null == gridData || gridData.length < 1)
			return Base.alert("请先选择报销数据!","warn");
		var param = {};
		param["dto.aac001"] = gridData[0].aac001;
		param.aaz217List = Ta.util.obj2string(gridData);
		Base.setDisabled("regBtn");
		Base.submit("","lxeyMzBbxAction!toSaveReg.do",param,null,false,function(){
			Base.alert("处理成功!", "success",function(){
				closeWin();
			});
		});
	}
</script>
<%@ include file="/ta/incfooter.jsp"%>