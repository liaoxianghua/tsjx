/*
 * Copyright (C), 2014-2015, 杭州小卡科技有限公司
 * FileName: MainController.java
 * Author:   muxing
 * Date:    2016/3/13 23:55
 * Description:
 */
package cn.com.tsjx.admin;

import cn.com.tsjx.attch.entity.Attch;
import cn.com.tsjx.attch.service.AttchService;
import cn.com.tsjx.auditRecord.entity.AuditRecord;
import cn.com.tsjx.common.constants.enums.UserEnum;
import cn.com.tsjx.common.model.Result;
import cn.com.tsjx.common.util.StringUtil;
import cn.com.tsjx.common.util.alg.Base64;
import cn.com.tsjx.common.util.json.JSONToStringStyle;
import cn.com.tsjx.common.util.json.JsonMapper;
import cn.com.tsjx.common.web.model.Pager;
import cn.com.tsjx.company.entity.Company;
import cn.com.tsjx.company.service.CompanyService;
import cn.com.tsjx.user.entity.User;
import cn.com.tsjx.user.service.UserService;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * MainController
 *
 * @author muxing
 * @date 2016/3/13
 */
@Controller
@RequestMapping("/admin")
public class MainController {

	@Resource
	UserService userService;

	@Resource
	CompanyService companyService;

	@Resource
	AttchService attchService;

	@RequestMapping(value = "/main")
	public String initMain(Model model) {
		model.addAttribute("main", true);
		return "admin/main";
	}

	@ResponseBody
	@RequestMapping(value = "/login")
	public Result<String> login(@RequestBody User user, Model model, HttpSession httpSession) {

		Result<String> result = new Result<String>();
		//		System.out.println(user.getUserName() + user.getPassword());
		result.setResult(false);
		user = userService.getUsersByParam(user.getUserName(), Base64.encode(user.getPassword().toString().getBytes()));
		if (user == null) {
			result.setObject("1");
			result.setMessage("用户名或密码错误");
			return result;
		} else if (!user.getUserType().equals(UserEnum.user_type_admin.code()) && !user.getUserType()
		                                                                               .equals(UserEnum.user_type_master
				                                                                               .code())) {
			result.setObject("1");
			result.setMessage("普通会员无法登陆系统");
			return result;
		}
		httpSession.setAttribute("user", user);
		result.setResult(true);
		result.setMessage("登录成功");
		model.addAttribute("main", true);
		return result;
	}

	@RequestMapping(value = "/company/list")
	public String companyInit(Model model) {

		model.addAttribute("company", true);
		return "admin/company/list";
	}

	@RequestMapping(value = "/company/list/getData")
	@ResponseBody
	public Pager<Company> list(Pager<Company> pager, Company company, Model model) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("entity", company);
		pager = companyService.page(params, pager);
		return pager;
	}

	@RequestMapping(value = "/company/getDetail", method = RequestMethod.GET)
	public String input(Long id, Model model) {
		Company company = new Company();
		if (id != null) {
			company = companyService.get(id);
		}
		model.addAttribute("bean", company);
		//		model.addAttribute("bean", JsonMapper.getMapper().toJson(company));
		return "admin/company/detail";
	}

	@RequestMapping(value = "/company/update", method = RequestMethod.POST)
	@ResponseBody
	public Result<String> update(@RequestBody Company company, Model model) {
		companyService.update(company);
		//// TODO: 2016/3/21 新增审核人记录表
		Result<String> result = new Result<String>();
		result.setMessage("修改成功！");
		result.setResult(true);
		return result;
	}

	@RequestMapping(value = "/infomation/list")
	public String infomationInit(Model model) {

		model.addAttribute("infomation", true);
		return "admin/infomation/list";
	}

	@RequestMapping(value = "/user/list")
	public String adminUserInit(Model model) {

		model.addAttribute("adminUser", true);
		return "admin/user/list";
	}
}
