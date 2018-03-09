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
		<ta:toolbarItem id="queryBtn"   key="查询[Q]" icon="xui-icon-query"       hotKey="Q"  onClick="toQuery()" />
		<ta:toolbarItem id="regBtn"     key="登记"    icon="xui-icon-spotAdd"     onClick="toReg()" />
		<ta:toolbarItem id="modifyBtn"  key="修改明细"    icon="xui-icon-spotEdit"    onClick="toEditMx()" />
		<ta:toolbarItem id="yjsBtn" key="预结算" icon="xui-icon-spotEdit"  onClick="toYjs()" />
		<ta:toolbarItem id="cancelBtn"  key="撤销"    icon="xui-icon-spotClear"   onClick="toCancel()" />
		<ta:toolbarItem id="printBtn"   key="打印"         icon="xui-icon-spotPrint" onClick="toPrint()" />
		<ta:toolbarItem id="checkBtn"   key="查看明细"   icon="xui-icon-show"      onClick="toCheck()" />
		<ta:button id="btnReset" key="重置[R]" icon="xui-icon-spotReset" type="resetPage"  hotKey="R" asToolBarItem="true"/>
	</ta:toolbar>
	<ta:form id="form1" fit="true">
	    <ta:text id="aaz217" key="最新的登记数据" display="false"/>
	    <ta:text id="aae011" key="经办人" display="false"/>
	 	<ta:text id="aaa027" key="分中心" display="false"/>
		<ta:panel id="panel1" key="查询条件" cols="3" >
			<ta:text id="aac001" key="个人ID"/>
			<ta:text id="aac003" key="姓名" />
			<ta:selectInput id="aae140" key="险种类型" collection="YL140" filter="340"/>
			<ta:text id="akb020"  key="医疗机构编号" popWin="true" popWinType="top" popWinUrl="medicalbenefit/common/commonFunctionAction.do" popWinHeight="500" popWinWidth="900" />
			<ta:text id="akb021" key="医疗机构名称" readOnly="true"  />
		    <ta:selectInput id="yke056" key="结算状态"  data="[{'id':'0','name':'未结算'},{'id':'1','name':'已结算'}]" />
			<ta:box span="1" cols="2">
				<ta:date id="aae036s" key="登记时间" showSelectPanel="true" columnWidth="0.6"/>
				<ta:date id="aae036e" key="至" labelWidth="15" showSelectPanel="true" columnWidth="0.4"/>
			</ta:box>	
			<ta:box span="1" cols="2">
				<ta:date id="aae030" key="结算时间" showSelectPanel="true" columnWidth="0.6"/>
				<ta:date id="aae031" key="至" labelWidth="15" showSelectPanel="true" columnWidth="0.4"/>
			</ta:box>	
		    <ta:date id="aae001" key="年度" showSelectPanel="true"  dateYear="true"  required="true"/>
		</ta:panel>
		<ta:panel id="panel2" key="医疗先行支付报销信息"  fit="true">
			<ta:datagrid id="kc21List" fit="true" selectType="radio" >
				<ta:datagridItem id="yke056" key="结算状态" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4" collection="YKE056" />
				<ta:datagridItem id="aac001" key="个人编号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6" />
				<ta:datagridItem id="aac003" key="姓名" align="center"  showDetailed="true"  dataAlign="left"  maxChart="3" />
				<ta:datagridItem id="aac002" key="身份证号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="10"  />
				<ta:datagridItem id="akc021" key="人员性质" align="center"  showDetailed="true"  dataAlign="left"  maxChart="5"  collection="AKC021"/>
				<ta:datagridItem id="aae140" key="险种类型" align="center"  showDetailed="true"  dataAlign="left"  maxChart="5"  collection="AAE140"/>
				<ta:datagridItem id="aab003" key="单位名称" align="center"  showDetailed="true"  dataAlign="left"  maxChart="12" />
				<ta:datagridItem id="aka130" key="医疗支付类别" align="center"  showDetailed="true"  dataAlign="left"  maxChart="8"  collection="AKA130"/>
				<ta:datagridItem id="aae030" key="开始日期" align="center"  showDetailed="true"  dataAlign="center"  maxChart="5"  dataType="date"/>
				<ta:datagridItem id="aae031" key="结束日期" align="center"  showDetailed="true"  dataAlign="center"  maxChart="5"  dataType="date"/>
				<ta:datagridItem id="yke014" key="住院号" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4" />
				<ta:datagridItem id="akb021" key="医疗机构名称" align="center"  showDetailed="true"  dataAlign="left"  maxChart="10" />
				<ta:datagridItem id="akb097" key="医疗机构等级" align="center"  showDetailed="true"  dataAlign="left"  maxChart="6"  collection="AKB096"/>
				<ta:datagridItem id="aae019" key="总费用" align="center"  showDetailed="true"  dataAlign="right"  maxChart="6"  />
				<ta:datagridItem id="akc228" key="全自费" align="center"  showDetailed="true"  dataAlign="right"  maxChart="6"  />
				<ta:datagridItem id="akc268" key="超限价" align="center"  showDetailed="true"  dataAlign="right"  maxChart="6"  />
				<ta:datagridItem id="yka318" key="先自付" align="center"  showDetailed="true"  dataAlign="right"  maxChart="6"  />
				<ta:datagridItem id="yka319" key="符合范围" align="center"  showDetailed="true"  dataAlign="right"  maxChart="6"  />
				<ta:datagridItem id="ake013" key="报销原因" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4"  collection="AKE013"/>
				<ta:datagridItem id="aae011" key="经办人" align="center"  showDetailed="true"  dataAlign="left"  maxChart="4"  collection="AAE011"/>
				<ta:datagridItem id="aae036" key="经办时间" align="center"  showDetailed="true"  dataAlign="center"  maxChart="9"  dataType="datetime" />
				<ta:datagridItem id="aaz217" key="就诊流水号"  align="center"  maxChart="6" />
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
	});
	// 个人ID change事件
	$("#aac001").change(function(){
		sfwQueryUtilForYl(1,'getAc01ByAae140ForYL',{"dto.jstj":Base.getValue('aac001')});
	});

	// 人员回调函数
	function fn_getPerson(){
		Base.setValue("aac001",g_Suggest[2]);
		Base.setValue("aac003",g_Suggest[1]);
	}
	
	 // 医疗机构放大镜回调方法
	function fnKb01MagifierBack(rowdata){
	   Base.setValue("akb020",rowdata.akb020); // 医疗机构编码
	   Base.setValue("akb021",rowdata.akb021); // 医疗机构名称
	}
	
	 // 查询
	 function toQuery()
	 {
		 var aae001 = Base.getValue("aae001"); // 年度
		 if("" == aae001 || null == aae001)
		 {
			 Base.alert("年度为必录入项!", "warn");
			 return ;
		 }else{
		     Base.clearGridData("kc21List");
			 Base.submit("panel1","personCalzfAction!toQuery.do"); 
		 }
	 }
	 
	// 登记
	function toReg()
	{
		top.win_ylxxzf = this.window;
		var param = {};
		Base.openWindow('win_reg',"医疗先行支付报销登记","<%=path%>/medicalbenefit/calculation/personCalzfAction!toReg.do",param,"85%","75%",null,function(){
            var aaz217 = Base.getValue("aaz217");
            if("" == aaz217 || null == aaz217){
            	
            }else{
				Base.submit("aaz217","personCalzfAction!toQueryByAaaz217.do");
            }
		},true);
	}
	 
	// 修改明细
	function toEditMx()
	{
		var gridData = Base.getGridSelectedRows("kc21List");
		if("" == gridData || null == gridData){
			Base.alert("请选择需要修改的数据!","warn");
		}else{
			var yke056 = gridData[0].yke056;
			if(yke056 != "01" && yke056 != "02"){
				Base.alert("已结算,不能修改明细!","warn");
			}else{
				var param={"dto['aaz217']":gridData[0].aaz217,"dto['aac001']":gridData[0].aac001};
			    parent.Base.openWindow('win_xxzfbx',"明细信息","<%=path%>/medicalbenefit/calculation/personCalzfAction!toEditDetail.do", param, "98%", "98%",null,function(){
				},true);
			}
		}
	}
	
	// 查看明细
	function toCheck()
	{
		var gridData = Base.getGridSelectedRows("kc21List");
		if("" == gridData || null == gridData){
			Base.alert("请选择需要修改的数据!","warn");
		}else{
		   var param={"dto['aaz217']":gridData[0].aaz217,"dto['aac001']":gridData[0].aac001};
		   parent.Base.openWindow('detailWin',"明细信息","<%=path%>/process/medicalbenefit/reckoning/detailAuditZYAction!checkDetail.do", param, "98%", "98%",null,function(){
			},true);
		}   
	}
	
	//撤销 
	function toCancel() 
	{
		// 医疗先行支付报销记录
		var kc21List = Base.getGridSelectedRows("kc21List");
		if(kc21List.length == 0){
			Base.alert("请选择要撤销的记录!", "warn");
			return false;
		}else{
			var aaz217 = kc21List[0].aaz217; // 就诊流水号
			var yke056 = kc21List[0].yke056; // 结算状态
			var aac001 = kc21List[0].aac001; // 个人ID
			if("" == aaz217 || null == aaz217)
				return Base.alert("就诊流水号不能为空!","warn");
			if("01" != yke056 && "02" != yke056)
				return Base.alert("已经结算不能撤销!","warn");
			Base.confirm('确定要撤销吗？',function(yes){
				if(yes){
					var param = {};
					param["dto.aaz217"] = aaz217;
					param["dto.aac001"] = aac001;
					Base.submit("","personCalzfAction!toCancel.do",param,null,false,function(){
						Base.deleteGridSelectedRows("kc21List");
					});
				}
			});
		}
	}
	
	//预结算
	function toYjs()
	{
		var gridData = Base.getGridSelectedRows("kc21List");
		if("" == gridData || null == gridData){
			Base.alert("请选择需要修改的数据!","warn");
		}else{
		   var parameter={"dto['aaz217']":gridData[0].aaz217,"dto['aac001']":gridData[0].aac001};
		Base.openWindow("win_yjs", "预结算信息", "<%=path%>/medicalbenefit/calculation/cenCalDetailAction!toYjs.do", parameter, "99%", "99%", null, null, true, null, null);
		}
	}
	
	//打印审核表
	function toPrint()
	{
		var kc21List = Base.getGridSelectedRows('kc21List');
		if(kc21List.length == 0){
			Base.alert("请选择需要打印的数据!", "warn");
			return false;
		}
		var aae011 = Base.getValue("aae011");
		var aaz217 = kc21List[0].aaz217;
		var aac001 = kc21List[0].aac001;
		var reportName="CenterJS_SHD.raq"; // 职工住院审核单
		$("#report1_printIFrame").attr("src","<%=path%>/reportServlet?action=2&name=report1&reportFileName="+reportName+"&"+
				"srcType=file&savePrintSetup=yes&appletJarName=runqian/runqianReport4Applet.jar%2Crunqian/dmGraphApplet.jar&"+
				"serverPagedPrint=no&mirror=no&"+"paramString=aaz217="+aaz217+";aae011="+aae011+";aac001="+aac001);
	}
	
</script>
<%@ include file="/ta/incfooter.jsp"%>