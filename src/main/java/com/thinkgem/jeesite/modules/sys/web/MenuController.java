/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.datatype.Json;
import com.thinkgem.jeesite.common.datatype.Tree;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 菜单Controller
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/menu")
public class MenuController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute("menu")
	public Menu get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return systemService.getMenu(id);
		}else{
			return new Menu();
		}
	}
	
	//获取菜单树结构
	@ResponseBody
	@RequestMapping(value = "getTree")
	public List<Tree> getTree() {
		
		List<Menu> list = Lists.newArrayList();
		List<Menu> sourcelist = systemService.findAllMenu();
		
		Menu.sortList(list, sourcelist, Menu.getRootId(), true);
		
		List<Tree> treeList = Lists.newArrayList();//菜单树list
		
		for (int i=0; i<list.size(); i++){
			Menu e = list.get(i);
			Tree t = new Tree();
			t.setId(e.getId());
			t.setPid(e.getParentId());
			t.setText(e.getName());
			
			t.setAttributes(e);
			treeList.add(t);
		}
		return treeList;
	}
	
	//根据roleId获取菜单树
	@ResponseBody
	@RequestMapping(value = "getTreeByRoleId")
	public List<Menu> getTreeByRoleId(String roleId) {
		
		Role role = new Role();
		role.setId(roleId);
		//List<Menu> list = Lists.newArrayList();
		List<Menu> sourcelist = systemService.findByRoleId(role);
		
		//Menu.sortList(list, sourcelist, Menu.getRootId(), true);
		
		return sourcelist;
	}
	
	//菜单授权
	@ResponseBody
	@RequestMapping(value = "roleMenuGrant")
	public Json roleMenuGrant(String ids, String roleId) {
		
		Json json = new Json();
		
		List<Menu> menuList = Lists.newArrayList();
		
		String menuIds[] = new String[0];
		if(null != ids && !"".equals(ids)) {
			menuIds = ids.split(",");
		}
        for(String item : menuIds) {
			Menu e = new Menu();
			e.setId(item);
			menuList.add(e);
		}
		
		Role role = new Role();
		role.setId(roleId);
		role.setMenuList(menuList);
		
		systemService.saveRoleMenu(role);
		json.setSuccess(true);
		json.setMsg("授权成功");
		
		return json;
	}

/*	@RequiresPermissions("sys:menu:view")*/
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		List<Menu> list = Lists.newArrayList();
		List<Menu> sourcelist = systemService.findAllMenu();
		Menu.sortList(list, sourcelist, Menu.getRootId(), true);
        model.addAttribute("list", list);
		return "modules/sys/menuList";
	}

/*	@RequiresPermissions("sys:menu:view")*/
	@RequestMapping(value = "form")
	public String form(Menu menu, Model model) {
		if (menu.getParent()==null||menu.getParent().getId()==null){
			menu.setParent(new Menu(Menu.getRootId()));
		}
		menu.setParent(systemService.getMenu(menu.getParent().getId()));
		// 获取排序号，最末节点排序号+30
		if (StringUtils.isBlank(menu.getId())){
			List<Menu> list = Lists.newArrayList();
			List<Menu> sourcelist = systemService.findAllMenu();
			Menu.sortList(list, sourcelist, menu.getParentId(), false);
			if (list.size() > 0){
				menu.setSort(list.get(list.size()-1).getSort() + 30);
			}
		}
		model.addAttribute("menu", menu);
		return "modules/sys/menuForm";
	}
	
/*	@RequiresPermissions("sys:menu:edit")*/
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(Menu menu, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(!UserUtils.getUser().isAdmin()){
			addMessage(redirectAttributes, "越权操作，只有超级管理员才能添加或修改数据！");
			json.setSuccess(false);
			json.setMsg("越权操作，只有超级管理员才能添加或修改数据！");
			return json;
		}
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
	/*	if (!beanValidator(model, menu)){
			json.setSuccess(false);
			json.setMsg("数据验证失败！");
			return json;
		}*/
		systemService.saveMenu(menu);
		addMessage(redirectAttributes, "保存菜单'" + menu.getName() + "'成功");
		
		json.setSuccess(true);
		json.setMsg("保存菜单'" + menu.getName() + "'成功");
		
		return json;
	}
	
/*	@RequiresPermissions("sys:menu:edit")*/
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(Menu menu, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
//		if (Menu.isRoot(id)){
//			addMessage(redirectAttributes, "删除菜单失败, 不允许删除顶级菜单或编号为空");
//		}else{
/*			systemService.deleteMenu(menu);
			addMessage(redirectAttributes, "删除菜单成功");
			json.setSuccess(true);
			json.setMsg("删除菜单成功");*/
//		}
		String menuIds[] = ids.split(",");
		for(String item : menuIds) {
			//根据Id取出menu，然后进行删除
			Menu e = new Menu(item);
			systemService.deleteMenu(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除菜单成功");
			
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "start")
	public Json start(String ids, String state, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		String menuIds[] = ids.split(",");
		for(String item : menuIds) {
			//根据Id取出menu，然后进行删除
			Menu e = new Menu(item);
			e.setIsShow(state);
			systemService.updateMenuShow(e);
		}
		
		json.setSuccess(true);
		if("1".equals(state)) {
			json.setMsg("启用成功");
		}else {
			json.setMsg("停用成功");
		}
			
		return json;
	}

/*	@RequiresPermissions("user")*/
	@RequestMapping(value = "tree")
	public String tree() {
		return "modules/sys/menuTree";
	}

/*	@RequiresPermissions("user")*/
	@RequestMapping(value = "treeselect")
	public String treeselect(String parentId, Model model) {
		model.addAttribute("parentId", parentId);
		return "modules/sys/menuTreeselect";
	}
	
	/**
	 * 批量修改菜单排序
	 */
/*	@RequiresPermissions("sys:menu:edit")*/
	@RequestMapping(value = "updateSort")
	public String updateSort(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/menu/";
		}
    	for (int i = 0; i < ids.length; i++) {
    		Menu menu = new Menu(ids[i]);
    		menu.setSort(sorts[i]);
    		systemService.updateMenuSort(menu);
    	}
    	addMessage(redirectAttributes, "保存菜单排序成功!");
		return "redirect:" + adminPath + "/sys/menu/";
	}
	
	/**
	 * isShowHide是否显示隐藏菜单
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
/*	@RequiresPermissions("user")*/
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Menu> list = systemService.findAllMenu();
		for (int i=0; i<list.size(); i++){
			Menu e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				if(isShowHide != null && isShowHide.equals("0") && e.getIsShow().equals("0")){
					continue;
				}
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}
