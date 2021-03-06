<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="ta" uri="/ta3"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>明细审核</title>
<%@ include file="/ta/inc.jsp"%>
</head>
<body class="no-scrollbar">
	<ta:pageloading />
	<ta:toolbar id="ButtonLayout1">
		<ta:toolbarItem id="queryBtn" key="查询[Q]" icon="xui-icon-query" hotKey="Q" onClick="toQuery()" />
		<ta:toolbarItem id="editRegBtn" key="修改登记信息" icon="xui-icon-spotEdit"  onClick="toEditReg()" />
		<ta:toolbarItem id="editMxBtn" key="修改明细信息" icon="xui-icon-spotEdit"   onClick="toEditMx()" />
		<ta:toolbarItem id="printBtn" key="打印审核表" icon="xui-icon-spotPrint" onClick="toPrint()" />
		<ta:button id="btnReset" key="重置[R]" icon="xui-icon-spotReset" type="resetPage"  hotKey="R" asToolBarItem="true"/>
	</ta:toolbar>
	<ta:form id="form1" fit="true">
		<ta:text id="aae011" key="经办人" display="false"/>
	    <ta:selectInput id="aka130_1" key="医疗类别" collection="AKA130"  display="false" /> 
		<ta:panel id="panel1" key="查询条件" cols="3" >
	        <ta:text id="ywlx" key="当前业务" display="false" /> 
			<ta:text id="aac001" key="个人ID"  />
			<ta:text id="aac003" key="姓名" />
			<ta:selectInput id="akc021" key="人员性质" collection="AKC021" /> 
			<ta:text  id="akb020"  key="医疗机构编号" />
			<ta:text id="akb021" key="医疗机构名称" readOnly="true"  />
			<ta:selectInput id="aka130" key="医疗类别" collection="AKA130"  filter="51,52,71,72" maxVisibleRows="8"/> 
		    <ta:date id="aae001" key="年度" showSelectPanel="true" required="true" dateYear="true"/>
			<ta:box span="1" cols="2">
				<ta:date id="aae036_s" key="登记时间" showSelectPanel="true" columnWidth="0.6"/>
				<ta:date id="aae036_e" key="至" labelWidth="15" showSelectPanel="true" columnWidth="0.4"/>
			</ta:box>	
			<ta:selectInput id="yke056" key="结算状态"  data="[{'id':'0','name':'未结算'},{'id':'1','name':'已结算'}]"  value="0"/>
		</ta:panel>
		<ta:panel id="panel2" key="登记信息"  fit="true">
			<ta:datagrid id="kc21List" fit="true" haveSn="true">
				<ta:datagridItem id="aaz217" key="就诊事件ID" hiddenColumn="true" />
				<ta:datagridItem id="aaz002" key="业务日志ID"  hiddenColumn="true" />
				<ta:datagridItem id="yke056" key="结算状态" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4" collection="YKE056" />
				<ta:datagridItem id="aac001" key="个人编号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6" />
				<ta:datagridItem id="aac003" key="姓名" align="center"  showDetailed="true"  dataAlign="left"  maxChart="3" />
				<ta:datagridItem id="aac002" key="身份证号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="10"  />
				<ta:datagridItem id="akc021" key="人员性质" align="center"  showDetailed="true"  dataAlign="left"  maxChart="5"  collection="AKC021"/>
				<ta:datagridItem id="aae140" key="险种类型" align="center"  showDetailed="true"  dataAlign="left"  maxChart="5"  collection="AAE140"/>
				<ta:datagridItem id="aab003" key="单位名称" align="center"  showDetailed="true"  dataAlign="left"  maxChart="12" />
				<ta:datagridItem id="aka130" key="医疗支付类别" align="center"  showDetailed="true"  dataAlign="left"  maxChart="8"  collection="AKA130"/>
				<ta:datagridItem id="yke069" key="票据份数" align="center"  showDetailed="true"  dataAlign="right"  maxChart="4" />
				<ta:datagridItem id="aae030" key="开始日期" align="center"  showDetailed="true"  dataAlign="center"  maxChart="5"  dataType="date"/>
				<ta:datagridItem id="aae031" key="结束日期" align="center"  showDetailed="true"  dataAlign="center"  maxChart="5"  dataType="date"/>
				<ta:datagridItem id="akb021" key="医疗机构名称" align="center"  showDetailed="true"  dataAlign="left"  maxChart="10" />
				<ta:datagridItem id="akb097" key="医疗机构等级" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6"  collection="AKB096"/>
				<ta:datagridItem id="aae019" key="总费用" align="center"  showDetailed="true"  dataAlign="right" totals="sum"  maxChart="8"  />
				<ta:datagridItem id="akc228" key="全自费" align="center"  showDetailed="true"  dataAlign="right" totals="sum"  maxChart="8"  />
				<ta:datagridItem id="akc268" key="超限价" align="center"  showDetailed="true"  dataAlign="right"  totals="sum"  maxChart="8"  />
				<ta:datagridItem id="yka318" key="先自付" align="center"  showDetailed="true"  dataAlign="right" totals="sum"  maxChart="8"  />
				<ta:datagridItem id="yka319" key="符合范围" align="center"  showDetailed="true"  dataAlign="right" totals="sum"  maxChart="8"  />
				<ta:datagridItem id="ake013" key="报销原因" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6"  collection="AKE013"/>
				<ta:datagridItem id="akc196" key="诊断" align="center"  showDetailed="true"  dataAlign="left"  maxChart="18"  />
				<ta:datagridItem id="yke014" key="住院号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6"  />
				<ta:datagridItem id="aae072" key="单据号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6"  />
				<ta:datagridItem id="aae011" key="经办人" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4"  collection="AAE011"/>
				<ta:datagridItem id="aae036" key="经办时间" align="center"  showDetailed="true"  dataAlign="center"  maxChart="9"  dataType="datetime"  sortable="true"/>
			</ta:datagrid>
	</ta:panel>
	</ta:form> 
	<iframe id="report1_printIFrame" name="report1_printIFrame" width="0" height="0" style="position:absolute;left:-100px;top:-100px"></iframe>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
		$("body").taLayout();
		initializeSuggestFramework(1,"", "aac001", 750, 300, 7, fn_getPerson, 0, false);
		initializeSuggestFramework(2,"", "akb020", 750, 300, 4, fn_getHospital, 0, false);
	});
	
	// 个人ID change事件
	$("#aac001").change(function(){
		sfwQueryUtil(1,'getAc01ByAae140ForYL',Base.getValue('aac001'));
	});
	
	// 定点医疗机构
	$("#akb020").change(function(){
		sfwQueryUtil(2,'getKb01',Base.getValue('akb020'));
	});
	
	/**
	 * 人员回调方法
	**/
	function fn_getPerson(){
		Base.setValue("aac001", g_Suggest[2]);
		Base.setValue("aac003", g_Suggest[1]);
	}
	
	/**
	 * 医疗机构回调方法
	**/
	function fn_getHospital(){
		Base.setValue("akb020", g_Suggest[0]); // 医疗机构编码
		Base.setValue("akb021", g_Suggest[1]); // 医疗机构名称
	}
	
	/**
	 * 登记信息双击录入明细数据 
	**/
	function clickfn(e, rowdata){
		var parameter = {};
		parameter["dto['aac001']"] = rowdata.aac001;
		parameter["dto['aaz217']"] = rowdata.aaz217;
		parameter["dto['aae030']"] = rowdata.aae030;
		parameter["dto['aae031']"] = rowdata.aae031;
		parameter["dto['aka130']"] = rowdata.aka130;
		parameter["dto['yke056']"] = rowdata.yke056;
		Base.openWindow("win_mxlr", "明细录入信息", "<%=path%>/medicalbenefit/calculation/cenCalDetailAction!getDetail.do", parameter, "99.5%", "99.5%", null, null, true, null, null);
	}
	
	/**
	 * 查询已登记未结算登记信息
	**/
	function toQuery(){
		// 年度
		var aae001 = Base.getValue("aae001");
		if("" == aae001 || null == aae001){
			return Base.alert("请输入年度!","warn",function(){
				Base.focus("aae001");
			});
		}else{
			Base.clearGridData("kc21List");
			Base.submit("panel1","cenCalDetailAction!toQuery.do");
		}
	}
	
	/**
	 * 修改明细
	**/ 
	function toEditMx(){
		var gridData = Base.getGridSelectedRows("kc21List");
		if("" == gridData || null == gridData){
			Base.alert("请选择需要修改的数据!","warn");
		}else{
			var yke056 = gridData[0].yke056;
			if(yke056 != "01" && yke056 != "02"){
				Base.alert("已结算,不能修改明细!","warn");
			}else{
    			clickfn(event,gridData[0]);
			}
		}
	}
	
	/**
	 * 修改登记信息
	**/
	function toEditReg()
	{
		var gridData = Base.getGridSelectedRows("kc21List");
		if("" == gridData || null == gridData){
			Base.alert("请选择需要修改的数据!","warn");
		}else{
			var yke056 = gridData[0].yke056;
			if(yke056 != "01" && yke056 != "02"){
				Base.alert("已结算,不能修改登记信息!","warn");
			}else{
				var parameter = {};
				parameter["dto['aac001']"] = gridData[0].aac001;
				parameter["dto['aaz217']"] = gridData[0].aaz217;
				parameter["dto['aae030']"] = gridData[0].aae030;
				parameter["dto['aae031']"] = gridData[0].aae031;
				parameter["dto['aka130']"] = gridData[0].aka130;
				parameter["dto['yke056']"] = gridData[0].yke056;
				Base.openWindow("win_reg", "修改登记信息", "<%=path%>/medicalbenefit/calculation/cenCalDetailAction!getRegInfo.do", parameter, "98%", "98%", null, null, true, null, null);
			}
		  }
	}
	
	/**
	 * 打印审核表
	**/
	function toPrint(){
		var kc21List = Base.getGridSelectedRows("kc21List");
		if(kc21List.length == 0){
			Base.alert("请选择需要打印的数据!", "warn");
			return false;
		}
		var aae011 = Base.getValue("aae011");
		var aaz217 = kc21List[0].aaz217;
		var aka130 = kc21List[0].aka130;
		var aac001 = kc21List[0].aac001;
		var aae140 = kc21List[0].aae140;
		var ake013 = kc21List[0].ake013;
		var reportName="CenterJS_SHD.raq"; // 职工住院审核单
		if("11" == aka130 || "12" == aka130 || "14"==aka130 || "15" == aka130)
			reportName = "centerBxMxsh_MZ.raq"; // 职工门诊审核单
		if("16" == aka130)
			reportName = "centerBxMxsh_sy.raq"; // 居民生育补贴报销
	    if("340" == aae140){
	        reportName="CenterJS_SHDLX.raq"; // 离休住院审核单
		   if("11" == aka130 || "12" == aka130 || "14"==aka130 || "15" == aka130)
			  reportName = "centerBxMxsh_LXMZ.raq"; // 离休门诊审核单
	    }
		if("13" == aka130 || "13a" == aka130 || "13b" == aka130)
			reportName="CenterJSMXB.raq"; // 中心慢性病审核单
		if("11" == ake013)
			reportName ="CenterJS_TSMXB.raq"; // 慢性病中心补保报销
		if("14" == ake013)
			reportName ="CenterJS_SHD_TB.raq"; // 停保补报销
		$("#report1_printIFrame").attr("src","<%=path%>/reportServlet?action=2&name=report1&reportFileName="+reportName+"&"+
				"srcType=file&savePrintSetup=yes&appletJarName=runqian/runqianReport4Applet.jar%2Crunqian/dmGraphApplet.jar&"+
				"serverPagedPrint=no&mirror=no&"+"paramString=aaz217="+aaz217+";aae011="+aae011+";aac001="+aac001);
	}
	
</script>
<%@ include file="/ta/incfooter.jsp"%>