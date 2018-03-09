package com.yinhai.ta3.themes.index2015;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.yinhai.sysframework.config.IConfigSyspath;
import com.yinhai.sysframework.config.SysConfig;
import com.yinhai.sysframework.config.service.IConfigService;
import com.yinhai.sysframework.iorg.IOrganizationService;
import com.yinhai.sysframework.iorg.IPosition;
import com.yinhai.sysframework.iorg.IUser;
import com.yinhai.sysframework.menu.IMenu;
import com.yinhai.sysframework.security.IPermissionServcie;
import com.yinhai.sysframework.service.ServiceLocator;
import com.yinhai.sysframework.util.MenuTreeNode;
import com.yinhai.sysframework.util.StringUtil;
import com.yinhai.sysframework.util.ValidateUtil;
import com.yinhai.sysframework.util.WebUtil;
import com.yinhai.sysframework.util.json.JSonFactory;
import com.yinhai.ta3.sysapp.menumg.service.ICommonMenuService;
import com.yinhai.ta3.system.sysapp.domain.Menu;
import com.yinhai.webframework.BaseAction;

public class IndexAction extends BaseAction {

	static final String UserPermissionMenus = "IndexAction_UserPermissionMenus";
	private String menuid;
	private boolean needParent = false;
	private ICommonMenuService commonMenuService = (ICommonMenuService) super.getService("commonMenuService");

	public String execute() throws Exception {
		List<IMenu> list = WebUtil.getCurrentUserPermissionMenus(request.getSession());
		List<Menu> commonMenus = commonMenuService.getCommonMenusByUserId(getDto().getUserInfo().getUserid());
		if (ValidateUtil.isNotEmpty(list)) {
			MenuTreeNode treeNode = MenuTreeNode.createTree(list);
			List<Map<String, Object>> menuList = new ArrayList<Map<String, Object>>();
			List<MenuTreeNode> secondMenuList = treeNode.getChildNode();
			if ((secondMenuList != null) && (secondMenuList.size() > 0)) {
				menuList = menuToJson(secondMenuList);
			}
			request.setAttribute("menuList", menuList);
		} else {
			request.setAttribute("menuList", new ArrayList<Map<String, Object>>());
		}
		List<IPosition> currentUserPositions = WebUtil.getCurrentUserPositions(request.getSession());
		request.setAttribute("__USER_EFFECTIVE_POSITIONS__", currentUserPositions);
		request.setAttribute("commonMenus", commonMenus);
		return "success";
	}

	public String getCommonMenu() {
		setData("commonMenu", JSonFactory.bean2json(commonMenuService.getCommonMenusByUserId(getDto().getUserInfo().getUserid())));
		return "tojson";
	}

	public List<Map<String, Object>> menuToJson(List<MenuTreeNode> node) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < node.size(); i++) {
			MenuTreeNode menuNode = node.get(i);
			if (menuNode.getIsShow() == "show") {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("menuId", menuNode.getId());
				m.put("menuName", menuNode.getMenuName());
				m.put("url", menuNode.getUrl());
				m.put("img", menuNode.getImg());
				if ((menuNode.getChildNode() != null) && (menuNode.getChildNode().size() > 0)) {
					m.put("childList", menuToJson(menuNode.getChildNode()));
				}
				list.add(m);
			}
		}
		return list;
	}

	public String findChildMenu() throws Exception {
		writeJsonToClient(findChild());
		return null;
	}

	protected LinkedHashMap<Long, Menu> getUserPermissionMenus() {
		if (getSessionResource("IndexAction_UserPermissionMenus") != null)
			return (LinkedHashMap) getSessionResource("IndexAction_UserPermissionMenus");
		List<IMenu> list = WebUtil.getCurrentUserPermissionMenus(request.getSession());
		LinkedHashMap<Long, Menu> map = new LinkedHashMap<Long, Menu>();
		for (IMenu menu : list) {
			map.put(menu.getMenuid(), (Menu) menu);
		}
		putSessionResource("IndexAction_UserPermissionMenus", map);
		return map;
	}

	public List findChild() throws Exception {
		Long node = IMenu.ROOT_ID;
		if (StringUtil.isNotEmpty(menuid)) {
			node = Long.valueOf(menuid);
			needParent = false;
		}
		LinkedHashMap<Long, Menu> menus = getUserPermissionMenus();
		List<Menu> retlist = new ArrayList<Menu>();
		boolean noGetparentMenu = true;
		Set<Long> set = new HashSet<Long>();

		for (Iterator<Map.Entry<Long, Menu>> iterator = menus.entrySet().iterator(); iterator.hasNext();) {
			Map.Entry<Long, Menu> entry = iterator.next();
			Menu tempMenu = (Menu) entry.getValue();
			if ((noGetparentMenu) && (needParent) && (tempMenu.getMenuid().equals(node))) {
				tempMenu.setParent(true);
				tempMenu.setOpen(true);
				retlist.add(tempMenu);
			}

			if ((!"3".equals(tempMenu.getSecuritypolicy())) && (!"2".equals(tempMenu.getSecuritypolicy()))) {
				if ((tempMenu.getPmenuid() != null) && (tempMenu.getPmenuid().equals(node))) {
					retlist.add(tempMenu);
				}
				set.add(tempMenu.getPmenuid());
			}
		}
		IConfigService configService = (IConfigService) ServiceLocator.getService("configService");
		List<IConfigSyspath> syslist = configService.getConfigSyspaths();
		boolean isPortal = SysConfig.getSysconfigToBoolean("isPortal", false);
		String curSyspath = "";
		IConfigSyspath sysobj;
		if ((syslist != null) && (syslist.size() > 1) && (isPortal)) {
			for (Iterator<IConfigSyspath> i$ = syslist.iterator(); i$.hasNext();) {
				sysobj = i$.next();

				curSyspath = sysobj.getUrl();
				for (Menu m : retlist) {
					String url = m.getUrl();
					if ((sysobj.getId().equals(m.getSyspath())) && (ValidateUtil.isNotEmpty(url)) && (url.indexOf("http") < 0)) {
						m.setUrl(curSyspath + url);
					}

					if (set.contains(m.getMenuid())) {
						m.setParent(true);
					} else {
						m.setParent(false);
					}
				}
			}
		} else {
			for (Menu m : retlist) {
				if (set.contains(m.getMenuid())) {
					m.setParent(true);
				} else {
					m.setParent(false);
				}
			}
		}
		return retlist;
	}

	public String findQueryMenu() throws Exception {
		writeJsonToClient(getUserQuickMenu());
		return null;
	}

	private List<Menu> getUserQuickMenu() throws Exception {
		Long userid = getDto().getUserInfo().getUserid();

		List<Menu> retlist = new ArrayList<Menu>();
		Menu menu = new Menu();
		menu.setMenuid(Long.valueOf(-1L));
		menu.setMenuname("常用菜单");
		menu.setMenunamepath("常用菜单");
		menu.setOpen(true);
		retlist.add(menu);

		Menu menu1 = new Menu();
		menu1.setMenuid(Long.valueOf(1L));
		menu1.setPmenuid(Long.valueOf(-1L));
		menu1.setMenuname("测试");
		menu1.setMenunamepath("xx/aa");
		menu1.setUrl("org/position/positionMgAction.do");
		retlist.add(menu1);
		return retlist;
	}

	private void delComMenu(String menuid) {
		Long userid = WebUtil.getUserInfo(request).getUserid();
	}

	public boolean isNeedParent() {
		return needParent;
	}

	public void setNeedParent(boolean needParent) {
		this.needParent = needParent;
	}

	public String getMenuid() {
		return menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

	public String getMenuPosition() throws Exception {
		IPermissionServcie service = (IPermissionServcie) ServiceLocator.getService("permissionServcie");
		List<IPosition> positions = service.getPositionsByMenu(getDto().getUserInfo().getUserid(), Long.valueOf(request.getParameter("menuid")));
		writeJsonToClient(positions);
		return null;
	}

	public String changeNowPosition() throws Exception {
		IOrganizationService service = (IOrganizationService) super.getService("organizationService");
		String positionid = request.getParameter("positionid");
		if (StringUtil.isEmpty(positionid))
			return null;
		IPosition nowPosition = WebUtil.getUserInfo(request).getNowPosition();
		if ((nowPosition != null) && (!positionid.equals(nowPosition.getPositionid()))) {
			IPosition position = service.getPosition(Long.valueOf(positionid));
			if (position != null) {
				WebUtil.getUserInfo(request).setNowPosition(position);
				super.writeSuccess();
			}
		}
		return null;
	}

	public String changePosition() throws Exception {
		String positionid = request.getParameter("positionid");
		IUser iUser = WebUtil.getUserInfo(request);
		IPermissionServcie service = (IPermissionServcie) ServiceLocator.getService("permissionServcie");
		List<IMenu> userPermissionMenus = service.getUserPermissionMenus(iUser.getUserid(), Long.valueOf(positionid));
		Set<String> userPermissionUrl = service.getUserPermissionUrl(iUser.getUserid(), Long.valueOf(positionid));
		request.getSession().setAttribute("__USER_PERVIEW_MENUS_FLAG__", userPermissionMenus);
		request.getSession().setAttribute("__USER_PERVIEW_FLAG__", userPermissionUrl);
		return "tojson";
	}
}
