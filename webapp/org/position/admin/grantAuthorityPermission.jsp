<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="ta" tagdir="/WEB-INF/tags/tatags"%>
<div  style="color:red;padding-left:10px;">注：这两种授权都是针对管理员，如甲乙两个管理员，甲给乙授了左边的权限，则乙可以给普通<br/>操作员授相应的操作权限，甲给乙授了右边的权限，则乙可以给管理员授相应的授权权限。</div>
<ta:panel id="gpanel" hasBorder="false" expanded="false" fit="true"  bodyStyle="overflow:auto;border:0px" cols="2" layout="column" heightDiff="38">
	<ta:panel  key="授权权限" hasBorder="false" expanded="false" cssStyle="margin-right:2px;" bodyStyle="border-bottom:0px;border-right:1px solid #e6e6e6">
		<ta:tree id="grantingTree1" checkable="true"  checkedKey="checked1" onCheck="fnTreeChg1" onExpand="fnSyncExpand" onCollapse="fnSyncCollapse" beforeCheck="fnBfChk" fontCss="fnSetFont"/>
	</ta:panel>
	<ta:panel  key="再授权权限" hasBorder="false" expanded="false"  bodyStyle="border-bottom:0px;border-left:1px solid #e6e6e6">
		<ta:tree id="grantingTree2" checkable="true" checkedKey="checked2" onCheck="fnTreeChg2"  onExpand="fnSyncExpand" onCollapse="fnSyncCollapse" beforeCheck="fnBfChk" fontCss="fnSetFont"/>
	</ta:panel>
	<ta:textarea id="grantAuthorityPermissionsPositionids" display="false"></ta:textarea>
</ta:panel>
<ta:buttonLayout align="right" cssClass="left-themes-color" cssStyle="border-top:1px solid #e6e6e6">
	<ta:button id="saveRoleGrantingBtn" key="保存" icon="icon-add1" isok="true" onClick="fnSaveGranting('adminMgAction!grantAuthorityPermissions.do')"/>
	<ta:button id="closeGrantingBtn" key="关闭" icon="icon-no" onClick="Base.closeWindow('grantingWin');"/>
</ta:buttonLayout>
<script>
function fnSetFont(treeId, treeNode) {
	if(treeNode.policy == 4 || treeNode.policy == 3)
		return {color:"red"};
}
function fnBfChk(treeId, treeNode) {
	if(treeNode.policy == 4 || treeNode.policy == 3)
		return Base.alert("该功能无需安全认证，所有用户都有权限，即便修改也无效。"), false;
	return true;
}
function fnSaveGranting(url) {
	var tree1 = Base.getObj("grantingTree1");
	var tree2 = Base.getObj("grantingTree2");
	var nodes1 = tree1.getChangeCheckedNodes();
	var nodes2 = tree2.getChangeCheckedNodes();
	var checkedNodes1 = tree1.getCheckedNodes(true);
	var checkedNodes2 = tree2.getCheckedNodes(true);
	var len1 = nodes1.length;
	var len2 = nodes2.length;
	if (len1 == 0 && len2 == 0) {
		return Base.alert("没有任何改变，不需要保存。"), false;
	}
	var str = "";
	for(var m = 0; m < checkedNodes1.length; m++){
		str += "{\"id\":\"" + checkedNodes1[m].id + "\",\"checked\":\"true\"},";
	}
	for(var n = 0; n < checkedNodes2.length; n++){
		str += "{\"id\":\"" + checkedNodes2[n].id + "\",\"checked\":\"true\",\"re\":\"1\"},";
	}
	for (var i = 0; i < len1; i++) {
		nodes1[i].checkedOld = nodes1[i].checked1;
	}
	for (var j = 0; j < len2; j++) {
		nodes2[j].checkedOld = nodes2[j].checked2;
	}
	if (str != "") {
		str = "[" + str.substr(0, str.length - 1) + "]";
		Base.submit("gpanel", url, {"ids":str,"positionids":Base.getValue("grantAuthorityPermissionsPositionids")},null,null,function(){
			Base.msgTopTip("<div style='width:130px;margin:0 auto;font-size:16px;margin-top:15px;text-align:center;'>批量授予权限成功</div>");
		});
	}
	
}
function fnSyncExpand(event, treeId, treeNode) {
	var treeObj;
	if (treeId == "grantingTree1") {
		treeObj = Base.getObj("grantingTree2");
	} else {
		treeObj = Base.getObj("grantingTree1");
	}
	treeObj.expandNode(treeObj.getNodeByParam("id", treeNode.id), true, false, false);
}
function fnSyncCollapse(event, treeId, treeNode) {
	var treeObj;
	if (treeId == "grantingTree1") {
		treeObj = Base.getObj("grantingTree2");
	} else {
		treeObj = Base.getObj("grantingTree1");
	}
	treeObj.expandNode(treeObj.getNodeByParam("id", treeNode.id), false, false, false);
}
function fnTreeChg1(event, treeId, treeNode) {
	var tree2 = Base.getObj("grantingTree2");
	var treeNode2 = tree2.getNodeByParam("id", treeNode.id);
	var checkbox2 = $("#" + treeNode2.tId + "_check");
	if (!treeNode.checked1 && treeNode2.checked2)
		checkbox2.click();
}
function fnTreeChg2(event, treeId, treeNode) {
	var tree1 = Base.getObj("grantingTree1");
	var treeNode1 = tree1.getNodeByParam("id", treeNode.id);
	var checkbox1 = $("#" + treeNode1.tId + "_check");
	if (treeNode.checked2 && !treeNode1.checked1)
		checkbox1.click();
	else if (treeNode.isParent && treeNode.checked2 && treeNode1.checked1) {
		var children = treeNode1.children;
		fnIterateNode(children);
	}
}
function fnIterateNode(children) {
	for (var i = 0; i < children.length; i++) {
		if (!children[i].checked1) {
			$("#" + children[i].tId + "_check").click();
		}
		if (children[i].isParent) fnIterateNode(children[i].children);
	}
}
</script>
<%@ include file="/ta/incfooter.jsp"%>