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
import com.thinkgem.jeesite.common.datatype.DataGrid;
import com.thinkgem.jeesite.common.datatype.Json;
import com.thinkgem.jeesite.common.datatype.PageHelper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 角色Controller
 * @author ThinkGem
 * @version 2013-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/role")
public class RoleController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute("role")
	public Role get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return systemService.getRole(id);
		}else{
			return new Role();
		}
	}
	
/*	@RequiresPermissions("sys:role:view")*/
	@RequestMapping(value = {"list", ""})
	public String list(Role role, Model model) {
		List<Role> list = systemService.findAllRole();
		model.addAttribute("list", list);
		return "modules/sys/roleList";
	}
	
	@ResponseBody
	@RequestMapping(value = "datagrid")
	public DataGrid datagrid(String name, PageHelper pageHelper) {
		
		Role role = new Role();
		role.setName(name);
		
		List<Role> roleList = systemService.getRoleList(pageHelper.getPage(), pageHelper.getRows(), role);
		int total = systemService.getRoleListCount(role);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : roleList);
		dataGrid.setTotal(total);
		dataGrid.setPage(pageHelper.getPage());
		
		return dataGrid;
	}
	
/*	@RequiresPermissions("sys:role:view")*/
	@RequestMapping(value = "form")
	public String form(Role role, Model model) {
		if (role.getOffice()==null){
			role.setOffice(UserUtils.getUser().getOffice());
		}
		model.addAttribute("role", role);
		model.addAttribute("menuList", systemService.findAllMenu());
		model.addAttribute("officeList", officeService.findAll());
		return "modules/sys/roleForm";
	}
	
/*	@RequiresPermissions("sys:role:edit")*/
	@ResponseBody
	@RequestMapping(value = "save")
	public Json save(Role role, Model model, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(!UserUtils.getUser().isAdmin()&&role.getSysData().equals(Global.YES)){
			addMessage(redirectAttributes, "越权操作，只有超级管理员才能修改此数据！");
			json.setSuccess(false);
			json.setMsg("越权操作，只有超级管理员才能修改此数据！");
			return json;
		}
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("越权操作，只有超级管理员才能修改此数据！");
			return json;
		}
		if (!"true".equals(checkName(role.getOldName(), role.getName()))){
			addMessage(model, "保存角色'" + role.getName() + "'失败, 角色名已存在");
			json.setSuccess(false);
			json.setMsg("保存角色'" + role.getName() + "'失败, 角色名已存在");
			return json;
		}
		if (!"true".equals(checkEnname(role.getOldEnname(), role.getEnname()))){
			addMessage(model, "保存角色'" + role.getName() + "'失败, 英文名已存在");
			json.setSuccess(false);
			json.setMsg("保存角色'" + role.getName() + "'失败, 英文名已存在");
			return json;
		}
		systemService.saveRole(role);
		
		json.setSuccess(true);
		json.setMsg("保存角色'" + role.getName() + "'成功");
		
		return json;
	}
	
/*	@RequiresPermissions("sys:role:edit")*/
	@ResponseBody
	@RequestMapping(value = "delete")
	public Json delete(Role role, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(!UserUtils.getUser().isAdmin() && role.getSysData().equals(Global.YES)){
			addMessage(redirectAttributes, "越权操作，只有超级管理员才能修改此数据！");
			json.setSuccess(false);
			json.setMsg("越权操作，只有超级管理员才能修改此数据！");
			return json;
		}
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String roleIds[] = ids.split(",");
		for(String item : roleIds) {
			Role e = new Role(item);
			systemService.deleteRole(e);
		}
		
		json.setSuccess(true);
		json.setMsg("删除角色成功");
		
		return json;
	}
	
	//↓↓↓↓↓↓↓↓权限管理功能↓↓↓↓↓↓↓↓
	//获取所有角色
	@ResponseBody
	@RequestMapping(value = "getRoles")
	public DataGrid getRoles() {
		
		List<Role> roleList = systemService.getRoles(new Role());
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(roleList.size() <= 0 ? "" : roleList);
		
		return dataGrid;
	}
	
	
	//根据roleId获取该角色已分配的用户
	@ResponseBody
	@RequestMapping(value = "getUsersByRoleId")
	public DataGrid getUsersByRoleId(String roleId, PageHelper pageHelper) {
		
		User user = new User();
		Role role = new Role(roleId);
		user.setRole(role);
		List<User> list = systemService.getUserRoleList(pageHelper.getPage(), pageHelper.getRows(), user);
		int total = systemService.getUserRoleListCount(user);
		
		DataGrid dataGrid = new DataGrid();
		dataGrid.setRows(0 == total ? "" : list);
		dataGrid.setTotal(total);
		
		return dataGrid;
	}
	
	
	/**
	 * 角色分配页面
	 * @param role
	 * @param model
	 * @return
	 */
/*	@RequiresPermissions("sys:role:edit")*/
	@RequestMapping(value = "assign")
	public String assign(Role role, Model model) {
		List<User> userList = systemService.findUser(new User(new Role(role.getId())));
		model.addAttribute("userList", userList);
		return "modules/sys/roleAssign";
	}
	
	/**
	 * 角色分配 -- 打开角色分配对话框
	 * @param role
	 * @param model
	 * @return
	 */
/*	@RequiresPermissions("sys:role:view")*/
	@RequestMapping(value = "usertorole")
	public String selectUserToRole(Role role, Model model) {
		List<User> userList = systemService.findUser(new User(new Role(role.getId())));
		model.addAttribute("role", role);
		model.addAttribute("userList", userList);
		model.addAttribute("selectIds", Collections3.extractToString(userList, "name", ","));
		model.addAttribute("officeList", officeService.findAll());
		return "modules/sys/selectUserToRole";
	}
	
	//角色分配用户
	@ResponseBody
	@RequestMapping(value = "addUserToRole")
	public Json addUserToRole(String ids, String roleId) {
		
		Json json = new Json();
		
		String userIds[] = new String[0];
		if(null != ids && !"".equals(ids)) {
			userIds = ids.split(",");
		}
		int newNum = 0;
        for(String item : userIds) {
        	
        	User user = systemService.assignUserToRole(new Role(roleId), systemService.getUser(item));
        	if (null != user) {
				newNum++;
			}
		}
		
		json.setSuccess(true);
		json.setMsg("已成功分配 "+newNum+" 个用户");
		
		return json;
	}
	
	//角色删除用户
	@ResponseBody
	@RequestMapping(value = "deleteUserRole")
	public Json deleteUserRole(String roleId, String ids, RedirectAttributes redirectAttributes) {
		
		Json json = new Json();
		
		if(!UserUtils.getUser().isAdmin()){
			addMessage(redirectAttributes, "越权操作，只有超级管理员才能修改此数据！");
			json.setSuccess(false);
			json.setMsg("越权操作，只有超级管理员才能修改此数据！");
			return json;
		}
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			json.setSuccess(false);
			json.setMsg("演示模式，不允许操作！");
			return json;
		}
		
		String userIds[] = ids.split(",");
		for(String item : userIds) {
			
			Role role = systemService.getRole(roleId);
			User user = systemService.getUser(item);
			
			if (UserUtils.getUser().getId().equals(item)) {
				addMessage(redirectAttributes, "无法从角色【" + role.getName() + "】中移除用户【" + user.getName() + "】自己！");
				json.setSuccess(false);
				json.setMsg("无法从角色【" + role.getName() + "】中移除用户【" + user.getName() + "】自己！");
			}else {
				Boolean flag = systemService.outUserInRole(role, user);
				if (!flag) {
					addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！");
					json.setSuccess(false);
					json.setMsg("用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！");
				}else {
					addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除成功！");
					json.setSuccess(true);
					json.setMsg("用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除成功！");
				}
			}
		}
		
		return json;
	}
	
	/**
	 * 角色分配 -- 根据部门编号获取用户列表
	 * @param officeId
	 * @param response
	 * @return
	 */
/*	@RequiresPermissions("sys:role:view")*/
	@ResponseBody
	@RequestMapping(value = "users")
	public List<Map<String, Object>> users(String officeId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		User user = new User();
		user.setOffice(new Office(officeId));
		Page<User> page = systemService.findUser(new Page<User>(1, -1), user);
		for (User e : page.getList()) {
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", 0);
			map.put("name", e.getName());
			mapList.add(map);			
		}
		return mapList;
	}
	
	/**
	 * 角色分配 -- 从角色中移除用户
	 * @param userId
	 * @param roleId
	 * @param redirectAttributes
	 * @return
	 */
/*	@RequiresPermissions("sys:role:edit")*/
	@RequestMapping(value = "outrole")
	public String outrole(String userId, String roleId, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/role/assign?id="+roleId;
		}
		Role role = systemService.getRole(roleId);
		User user = systemService.getUser(userId);
		if (UserUtils.getUser().getId().equals(userId)) {
			addMessage(redirectAttributes, "无法从角色【" + role.getName() + "】中移除用户【" + user.getName() + "】自己！");
		}else {
			if (user.getRoleList().size() <= 1){
				addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！这已经是该用户的唯一角色，不能移除。");
			}else{
				Boolean flag = systemService.outUserInRole(role, user);
				if (!flag) {
					addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除失败！");
				}else {
					addMessage(redirectAttributes, "用户【" + user.getName() + "】从角色【" + role.getName() + "】中移除成功！");
				}
			}		
		}
		return "redirect:" + adminPath + "/sys/role/assign?id="+role.getId();
	}
	
	/**
	 * 角色分配
	 * @param role
	 * @param idsArr
	 * @param redirectAttributes
	 * @return
	 */
/*	@RequiresPermissions("sys:role:edit")*/
	@RequestMapping(value = "assignrole")
	public String assignRole(Role role, String[] idsArr, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/role/assign?id="+role.getId();
		}
		StringBuilder msg = new StringBuilder();
		int newNum = 0;
		for (int i = 0; i < idsArr.length; i++) {
			User user = systemService.assignUserToRole(role, systemService.getUser(idsArr[i]));
			if (null != user) {
				msg.append("<br/>新增用户【" + user.getName() + "】到角色【" + role.getName() + "】！");
				newNum++;
			}
		}
		addMessage(redirectAttributes, "已成功分配 "+newNum+" 个用户"+msg);
		return "redirect:" + adminPath + "/sys/role/assign?id="+role.getId();
	}

	/**
	 * 验证角色名是否有效
	 * @param oldName
	 * @param name
	 * @return
	 */
/*	@RequiresPermissions("user")*/
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String checkName(String oldName, String name) {
		if (name!=null && name.equals(oldName)) {
			return "true";
		} else if (name!=null && systemService.getRoleByName(name) == null) {
			return "true";
		}
		return "false";
	}

	/**
	 * 验证角色英文名是否有效
	 * @param oldName
	 * @param name
	 * @return
	 */
/*	@RequiresPermissions("user")*/
	@ResponseBody
	@RequestMapping(value = "checkEnname")
	public String checkEnname(String oldEnname, String enname) {
		if (enname!=null && enname.equals(oldEnname)) {
			return "true";
		} else if (enname!=null && systemService.getRoleByEnname(enname) == null) {
			return "true";
		}
		return "false";
	}

}
