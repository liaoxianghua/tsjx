package cn.com.tsjx.user.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import cn.com.tsjx.common.enums.Deleted;
import cn.com.tsjx.common.model.Result;
import cn.com.tsjx.common.util.StringUtil;
import cn.com.tsjx.common.web.model.JsonResult;
import cn.com.tsjx.common.web.model.Pager;
import cn.com.tsjx.common.web.model.Params;
import cn.com.tsjx.infomation.entity.Infomation;
import cn.com.tsjx.infomation.entity.InfomationDto;
import cn.com.tsjx.infomation.service.InfomationService;
import cn.com.tsjx.sys.MailService;
import cn.com.tsjx.user.entity.User;
import cn.com.tsjx.user.service.UserService;
import cn.com.tsjx.util.SimpleCaptcha;

@Controller
@RequestMapping("/wap")
public class LoginController {

    Logger logger = LoggerFactory.getLogger(LoginController.class);
    @Resource
    public UserService userService;
    @Resource
    public MailService mailService;

    @Value("${validateUrl}")
    private String validateUrl;

    @Resource
    private InfomationService infomationService;

    @RequestMapping(value = "/login")
    public String userLogin(User user, Model model) {
        return "/wap/login";
    }

    @ResponseBody
    @RequestMapping(value = "/loginIn", method = RequestMethod.POST)
    public Result<String> loginIn(Model model, String userName, String password, HttpSession httpSession) {
        Result<String> result = new Result<String>();
        result.setResult(false);
        try {
        if (StringUtil.isTrimBlank(userName)) {
            result.setMessage("用户名不能为空");
            return result;
        }
        if (StringUtil.isTrimBlank(password)) {
            result.setMessage("密码不能为空");
            return result;
        }

        User user = userService.getUsersByParam(userName, password);
        if (user == null) {
            result.setMessage("用户名或密码错误");
            return result;
        }else if (Deleted.NO.value.equals(user.getIsActivate())) {
            result.setMessage("账号未激活，请激活后登录");
            return result;
        }
        user.setLastLoginTime(new Date());
        userService.update(user);
        httpSession.setAttribute("user", user);
        model.addAttribute("userId",user.getId());
        result.setResult(true);
        result.setMessage("登录成功");
        } catch (Exception e) {
            logger.info("登录异常--------------------------------------");
            e.printStackTrace();
            result.setMessage("登录失败，请联系管理员");
            return result;
        }
        return result;
    }

    @RequestMapping(value = "/toRegister")
    public String toRegister(User user, Model model) {
        return "/wap/register";
    }
    @RequestMapping(value = "/emailRegister")
    public String emailRegister(User user, Model model) {
        return "/wap/emailRegister";
    }

    @RequestMapping(value = "/index")
    public String index(Model model, HttpSession httpSession) {
        httpSession.removeAttribute("user");
        Pager<InfomationDto> pager = new Pager<InfomationDto>();
        pager.setPageOrder(Pager.ORDER_DESC);
        pager.setPageSort("a.create_time");
        pager.setPageSize(20);
        Infomation infomation = new Infomation();
        Params params = Params.create();
        infomation.setStatus("2");
        infomation.setIsTop("1");
        params.add("entity", infomation);
        pager = infomationService.getInfoPagerWithImg(params, pager,false);
        // 今日推荐 前20
        model.addAttribute("Tops", pager.getItems());
        //最新发布20
        Pager<InfomationDto> pagerNew = new Pager<InfomationDto>();
        Infomation infomation2 = new Infomation();
        infomation2.setStatus("2");
        params.add("entity", infomation2);
        pagerNew.setPageOrder(Pager.ORDER_DESC);
        pagerNew.setPageSort("a.create_time");
        pagerNew.setPageSize(20);
        pagerNew = infomationService.getInfoPagerWithImg(params, pagerNew, false);
        model.addAttribute("News", pagerNew.getItems());
        return "/wap/infor";
    }

    @ResponseBody
    @RequestMapping(value = "/registerEmail")
    public Result<String> registerEmail(User user, Model model, HttpSession httpSession) {
        Result<String> result = new Result<String>();
        result.setResult(false);
        if (user != null) {
            if (StringUtil.isTrimBlank(user.getEmail())) {
                result.setMessage("邮箱不能为空");
                return result;
            }
            if (StringUtil.isTrimBlank(user.getPassword())) {
                result.setMessage("密码不能为空");
                return result;
            }
        }
        // 判断邮箱是否已注册
        User entity = new User();
        entity.setEmail(user.getEmail());
        entity.setDeleted(Deleted.NO.value);
        entity.setIsActivate(Deleted.YES.value);
        List<User> list = userService.find(entity);
        if (!list.isEmpty()) {
            result.setMessage("邮箱已注册");
            return result;
        }
        user.setUserName(user.getEmail());
        user.setDeleted(Deleted.YES.value);
        user.setIsActivate(Deleted.NO.value);
        user.setUserType("2");
        user.setPassword(Base64.encodeBase64String(user.getPassword().getBytes()));
        user = userService.insert(user);
        // model.addAttribute("user", user);
        httpSession.setAttribute("user", user);
        if (user.getId() != null && user.getId() != 0) {
            model.addAttribute("userId", user.getId());
            result.setObject("/wap/emailRegister2");
            result.setResult(true);
            return result;
        }
        return result;
    }

    @RequestMapping(value = "/toRegisterEmail2")
    public String toEmailRegister2() {
        return "/wap/emailRegister2";
    }
    @RequestMapping(value = "/toRegister2")
    public String toRegister2() {
        return "/wap/register2";
    }

    @RequestMapping(value = "/register-success")
    public String registerSuccess() {

        return "/wap/register-success";
    }

    // 下一步
    @ResponseBody
    @RequestMapping(value = "/saveRegisterEmail2")
    public Result<Object> saveRegisterEmail2(User user, Model model) {
        Result<Object> result = new Result<Object>();
        
        // 判断手机是否已注册
        User entity = new User();
        entity.setMobile(user.getMobile());
        entity.setDeleted(Deleted.NO.value);
        entity.setIsActivate(Deleted.YES.value);
        List<User> list = userService.find(entity);
        if (!list.isEmpty()) {
            result.setMessage("手机已注册");
            return result;
        }
        
        int count = userService.update(user);
        result.setResult(false);
        result.setMessage("注册失败");
        if (count > 0) {
            result.setMessage("注册成功");
            result.setResult(true);
            user = userService.get(user.getId());

            // 发送邮箱验证
            String url =  validateUrl + Base64.encodeBase64String(user.getId().toString().getBytes());
            url = url + "&email="+user.getEmail();
            try {
                mailService.sendMail(user.getEmail(), "汤森机械网— --帐号激活", "感谢您注册汤森机械网！"
                        + "</br>你的登录邮箱为："+user.getEmail()+"请点击以下链接激活帐号："
                        + "</br>"+"链接：<a href='" + url + "'>点击我完成注册</a>"
                        + "</br>如果以上链接无法点击，请将上面的地址复制到你的浏览器(如IE)的地址栏进入汤森机械网。 （该链接在48小时内有效，48小时后需要重新注册）"
                        + "</br>祝您在汤森机械网找到称心如意之选！"
                        + "</br>如有任何疑问，请搜索并关注我们微信公众号(汤森机械网),将有后台服务人员竭诚为您服务！", "汤森机械");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    @RequestMapping(value = "/emailSuccess")
    public String emailSuccess(String r,String email) {
        
        User usertemp = new User();
        usertemp.setEmail(email);
        List<User> list = userService.find(usertemp);
        for (User user : list) {
            if (Deleted.YES.value.equals(user.getIsActivate())) {
                System.out.println("已有激活");
                return "/wap/login";
            }
        }
        String string2 = new String(Base64.decodeBase64(r.getBytes()));
        User user = userService.get(Long.valueOf(string2));
        if (user == null) {
            return "/wap/404";
        } else {
            user.setIsActivate(Deleted.YES.value);
            userService.update(user);
            return "/wap/login";
        }
    }

    @RequestMapping(value = "/forgotpwd", method = RequestMethod.GET)
    public String forgotpwd() {

        return "/wap/forgotpwd";
    }
    
    @RequestMapping(value = "/forgotpwd2", method = RequestMethod.GET)
    public String forgotpwd2() {

        return "/wap/forgotpwd2";
    }

    @ResponseBody
    @RequestMapping(value = "/toForgotpwd", method = RequestMethod.POST)
    public JsonResult toForgotpwd(String email, String captchaCode, HttpSession httpSession) {
        JsonResult jsonResult = new JsonResult();
        jsonResult.setSuccess(false);
        String verifyCode = (String) httpSession.getAttribute("verifyCode");
        if (verifyCode != null && verifyCode.equals(captchaCode.toLowerCase())) {
            if (email != null) {
                User entity = new User();
                entity.setEmail(email);
                entity.setIsActivate("T");
                List<User> list = userService.find(entity);
                if (list.isEmpty()) {
                    jsonResult.setMessage("邮箱未注册");
                    return jsonResult;
                }
                String password = list.get(0).getPassword();
                String returnString  = new String(Base64.decodeBase64(password));
                mailService.sendMail(email, "找回密码", "你的密码是  " + returnString + "   请登录后修改密码", "汤森机械");
                jsonResult.setSuccess(true);
            }else {
                jsonResult.setMessage("邮箱不能为空");
            }
        }else {
            jsonResult.setMessage("验证码错误");
        }
        return jsonResult;
    }
    
//    @ResponseBody
//    @RequestMapping(value = "/toForgotpwdByMobile", method = RequestMethod.POST)
//    public JsonResult toForgotpwdByMobile(String mobile, String captchaCode, HttpSession httpSession) {
//        JsonResult jsonResult = new JsonResult();
//        jsonResult.setSuccess(false);
//        String verifyCode = (String) httpSession.getAttribute("verifyCode");
//        if (verifyCode != null && verifyCode.equals(captchaCode.toLowerCase())) {
//            if (mobile != null) {
//                User entity = new User();
//                entity.setMobile(mobile);
//                entity.setIsActivate("T");
//                List<User> list = userService.find(entity);
//                if (list.isEmpty()) {
//                    jsonResult.setMessage("手机未注册");
//                    return jsonResult;
//                }
//            }else {
//                jsonResult.setMessage("邮箱不能为空");
//            }
//        }else {
//            jsonResult.setMessage("验证码错误");
//        }
//        return jsonResult;
//    }
    
    @RequestMapping("/savepwd")
    public String savepwd(String pwd, String captchaCode, HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("user");
        user.setPassword(Base64.encodeBase64String(pwd.getBytes()));
        userService.update(user);
        return "/wap/login";
    }
    @RequestMapping(value = "/toForgotpwdBySms",method = RequestMethod.POST)
    public String toForgotpwdBySms(String mobile, String captchaCode, HttpSession httpSession) {
        Result<User> jsonResult = new Result<User>();
        jsonResult.setResult(false);
        String smsCode = (String) httpSession.getAttribute("pwdSmsCode");
        if (smsCode.equals(captchaCode)) {
            if (mobile != null) {
                User entity = new User();
                entity.setMobile(mobile);
                entity.setIsActivate("T");
                entity.setDeleted("F");
                List<User> list = userService.find(entity);
                if (list.isEmpty()) {
                    jsonResult.setMessage("手机号未注册");
                    return "";
                }
                User user = list.get(0);
                jsonResult.setObject(user);
                httpSession.setAttribute("user", user);
                jsonResult.setResult(true);
                return "/wap/resetpwd";
            }else {
                jsonResult.setMessage("手机号不能为空");
            }
        }else {
            jsonResult.setMessage("验证码错误");
        }
        
        return "/wap/resetpwd";
    }
    

    @RequestMapping(value = "/loginOut", method = RequestMethod.GET)
    public String loginOut(HttpSession httpSession) {
        httpSession.removeAttribute("user");
        return "/wap/infor";
    }
    
    @RequestMapping(value = "/logout")
    public String logout(Model model,HttpSession httpSession) {
        httpSession.removeAttribute("adminUser");
        return "login";
    }
    
    @RequestMapping(value = "/toForgotpwdSuccess", method = RequestMethod.GET)
    public String toForgotpwdSuccess(HttpSession httpSession) {
        httpSession.removeAttribute("user");
        return "/wap/toForgotpwdSuccess";
    }

    /**
     * 获取验证码
     * 
     * @param request
     * @param response
     */
    @RequestMapping(value = "/getVerifyCode", method = RequestMethod.GET)
    public void getVerifyMCode(HttpServletRequest request, HttpServletResponse response) {
        SimpleCaptcha.showCaptcha(request, response, "verifyCode");
    }
    
    
    /**
     * 获取短信验证码
     * 
     * @param request
     * @param response
     */
    @RequestMapping(value = "/getSmsCode")
    public void getSmsCode(String mobile,HttpServletRequest request, HttpServletResponse response) {
        SimpleCaptcha.getSmsCode(request, response, mobile);
    }
 
    
    /**
     * 获取手机找回密码验证码
     * 
     * @param request
     * @param response
     */
    @RequestMapping(value = "/getpwdSmsCode")
    public void getpwdSmsCode(String mobile,HttpServletRequest request, HttpServletResponse response) {
        SimpleCaptcha.getPwdSmsCode(request, response, mobile);
    }
    
    
    @RequestMapping(value = "/terms-conditions")
    public String termsConditions() {
        return "/wap/terms-conditions"; 
    }
    
    @RequestMapping(value = "/about-us")
    public String aboutUs() {
        return "/wap/about-us"; 
    }
    
    @RequestMapping(value = "/contact-us")
    public String contactUs() {
        return "/wap/contact-us"; 
    }

    @ResponseBody
    @RequestMapping(value = "/registerMobile")
    public Result<String> registerMobile(User user, Model model, HttpSession httpSession) {
        Result<String> result = new Result<String>();
        System.out.println(JSON.toJSONString(user));
        result.setResult(false);
        if (user != null) {
           String smsCode =  (String) httpSession.getAttribute("smsCode");
            if (user.getSmsCode() == null || !user.getSmsCode().equals(smsCode)) {
                result.setMessage("验证码不正确");
                return result;
            }
            if (StringUtil.isTrimBlank(user.getMobile())) {
                result.setMessage("手机号不能为空");
                return result;
            }
            if (StringUtil.isTrimBlank(user.getPassword())) {
                result.setMessage("密码不能为空");
                return result;
            }
        }
        // 判断手机是否已注册
        User entity = new User();
        entity.setMobile(user.getMobile());
        entity.setDeleted(Deleted.NO.value);
        entity.setIsActivate(Deleted.YES.value);
        List<User> list = userService.find(entity);
        if (!list.isEmpty()) {
            result.setMessage("手机已注册");
            return result;
        }
        user.setUserName(user.getMobile());
        user.setDeleted(Deleted.YES.value);
        user.setIsActivate(Deleted.NO.value);
        user.setUserType("2");
        user.setPassword(Base64.encodeBase64String(user.getPassword().getBytes()));
        user = userService.insert(user);
        // model.addAttribute("user", user);
        httpSession.setAttribute("user", user);
        if (user.getId() != null && user.getId() != 0) {
            model.addAttribute("userId", user.getId());
            result.setObject("/wap/register2");
            result.setResult(true);
            return result;
        }
        return result;
    }
    
    @ResponseBody
    @RequestMapping(value = "/saveRegister2")
    public Result<String> saveRegister2(User user, Model model, HttpSession httpSession) {
        Result<String> result = new Result<String>();
        user.setIsActivate("T");
        user.setDeleted("F");
        int count = userService.update(user);
        result.setResult(false);
        result.setMessage("注册失败");
        if (count > 0) {
            result.setMessage("注册成功");
            result.setResult(true);
        }
        return result;
    }
    
}
