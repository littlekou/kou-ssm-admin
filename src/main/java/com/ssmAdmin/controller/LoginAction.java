package com.ssmAdmin.controller;

import com.alibaba.fastjson.JSONObject;
import com.ssmAdmin.common.Constants;
import com.ssmAdmin.controller.base.BaseController;
import com.ssmAdmin.entity.Data;
import com.ssmAdmin.entity.sqlEntity.Menu;
import com.ssmAdmin.entity.sqlEntity.RoleMenu;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.entity.sqlEntity.UserSession;
import com.ssmAdmin.service.MemberService;
import com.ssmAdmin.service.MenuService;
import com.ssmAdmin.service.RoleMenuService;
import com.ssmAdmin.service.SessionService;
import com.ssmAdmin.util.*;
import com.ssmAdmin.util.Verify.ImageCodeUtil;
import com.zbjr.log.LogMgr;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("admin")
public class LoginAction extends BaseController {

	@Autowired
	MemberService memberService;
    @Autowired
    private RoleMenuService roleMenuService;
    @Autowired
    private MenuService mmenuService;
	@Autowired
	private SessionService sessionService;
	@Autowired
	private RedisUtils redisUtils;


	@RequestMapping(value = "/index", method = RequestMethod.GET)
    public String transfer(HttpServletRequest req) {
        Member member = memberService.getMemberById(getUserId(req));
        if(member == null){
            return "login";
        }else{
            Map<String, Object> params = new HashMap<>();
            params.put("isEffective", 1);
            if(member.getRoleId()!=1) {
                List<RoleMenu> relations = roleMenuService.selectRelationByRoleId(member.getRoleId());
                List<Long> menuIds = new ArrayList<>();
                for (RoleMenu roleMenu : relations) {
					menuIds.add(roleMenu.getMenuId());
                }
                if(menuIds.size()==0) {
					menuIds.add(-1l);
                }
                params.put("menuIds", menuIds);
            }
                params.put("menuType",2);
            List<Menu> menus = mmenuService.getMenuByParams(params);
			req.setAttribute("sysName", "管理系统");
            req.setAttribute("leftMenu",menus);
			req.setAttribute("currentUser",member);
            return "index";
        }
    }


	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(HttpServletRequest req) {
		return "common/welcome";
	}


	@RequestMapping(value = "/login")
	public String login(HttpServletRequest req,String loginName,String pwd,String googleCode,String imgVerify,String phoneVerify) {
		Member member = (Member)req.getSession().getAttribute("currentUser");
		req.setAttribute("loginName",loginName);
		if(StringUtils.isBlank(loginName)){
			return "login";
		}
		if(member!=null && member.getLoginName().equals(loginName)){
			UserSession sysSession = sessionService.getSessionIdById(member.getId());
			String sessionId = req.getSession().getId();
			if(sessionId.equals(sysSession.getSessionId())){
				return "redirect:/admin/index.html";
			}
		}
        Member currentUser = memberService.getMemberByMobile(loginName,null);
		Map<String,Object> msgMap = getMemberMsg(currentUser);
		req.setAttribute("google",msgMap.get("google"));
		req.setAttribute("verity", msgMap.get("verity"));
		if("ok".equals(msgMap.get("verity"))){
			Data data = getImgVerity(imgVerify);
			if(data.getCode()!=200){
				req.setAttribute("loginInfo", data.getMsg());
				return "login";
			}
			if (StringUtils.isNotEmpty(phoneVerify)) {
				Long timemili = System.currentTimeMillis() / 1000;
				String phone = redisUtils.getFixedDB(currentUser.getPhone(), Constants.FIXED_DB);
				if (StringUtils.isNotEmpty(phone)) {
					if (timemili - Long.parseLong(phone.substring(4)) > (15*60)) {
						redisUtils.setEXFixedDB(currentUser.getPhone(), "", 1, Constants.FIXED_DB);
						req.setAttribute("loginInfo", "短信验证码已过期");
						return "login";
					} else {
						if (!(phone.substring(0, 4).equals(phoneVerify))) {
							req.setAttribute("loginInfo", "短信验证码错误");
							return "login";
						}
					}
				} else {
					req.setAttribute("loginInfo", "请获取短信验证码");
					return "login";
				}
			} else {
				req.setAttribute("loginInfo", "请输入短信验证码");
				return "login";
			}
		}
        if(null==currentUser){
            req.setAttribute("loginName",loginName);
            req.setAttribute("loginInfo","用户名和密码错误！");
            return "login";
        }else{
            if(!"2".equals(currentUser.getStatus().toString()) && !"5".equals(currentUser.getStatus().toString())){
                req.setAttribute("loginName",loginName);
                req.setAttribute("loginInfo","此账户暂无法登陆,请联系管理员！");
                return "login";
            }
			//验证谷歌验证码
			if("ok".equals(msgMap.get("google"))){
				if(CheckNum.checkNum(googleCode)){
					Boolean aBoolean = GoogleAuthenticator.check_code(currentUser.getGoogleSecretKey(), Integer.parseInt(googleCode), System.currentTimeMillis());
					if (!aBoolean) {
						req.setAttribute("loginName",loginName);
						req.setAttribute("loginInfo","谷歌验证码不正确");
						return "login";
					}
				}else{
					req.setAttribute("loginName",loginName);
					req.setAttribute("loginInfo","谷歌验证码不符合规范");
					return "login";
				}
			}

            String password = currentUser.getPassword();
            String md5PWD = DigestUtils.md5DigestAsHex((DigestUtils.md5DigestAsHex(pwd.getBytes())+loginName).getBytes());
            if(md5PWD.equals(password)){
            	HttpSession session = req.getSession();
				UserSession sysSession = sessionService.getSessionIdById(currentUser.getId());
                session.setAttribute("currentUser", currentUser);
				Map<String,Object> param = new HashMap<>();
				param.put("sessionId",req.getSession().getId());
				param.put("userId",currentUser.getId());
				param.put("lastLoginIp", PCAddress.getIpAddress(req));
				if(sysSession==null){
					sessionService.saveSession(param);
				}else{
					sessionService.updateSession(param);
				}
				return "redirect:/admin/index.html";
            }else{
                req.setAttribute("loginName",loginName);
                req.setAttribute("loginInfo","用户名和密码错误！");
                return "login";
            }
        }
	}

	@RequestMapping("getVerifyCode")
	@ResponseBody
	public void getVerifiCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        /*
             1.生成验证码
             2.把验证码上的文本存在session中
             3.把验证码图片发送给客户端
             */
		ImageCodeUtil ivc = new ImageCodeUtil();     //用我们的验证码类，生成验证码类对象
		String image = ivc.generateVerifyCode(4);  //获取验证码
//		redisUtils.setEXFixedDB("imgVerify",image,15*60,Constants.FIXED_DB);
		ivc.outputImage(200,80, response.getOutputStream(),image);//将验证码图片响应给客户端
	}

	@RequestMapping(value = "/getPhoneVerify", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> getPhoneVerify(HttpServletRequest request, HttpServletResponse response,String mobile,String imgVerify) throws IOException {
    	if(StringUtils.isEmpty(mobile)){
			return ResultUtil.resultError("请输入账号");
		}
		Member member = memberService.getMemberByMobile(mobile,null);
    	if(StringUtils.isEmpty(member.getPhone())){
			return ResultUtil.resultError("请设置手机号");
		}
    	return getPhoneCode(member.getPhone(),imgVerify);
	}

	@RequestMapping(value = "/getMemberPhoneVerify", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> getMemberPhoneVerify(HttpServletRequest request, HttpServletResponse response,String phone,String imgCode){
		if(StringUtils.isEmpty(phone)){
			return ResultUtil.resultError("请输入手机号");
		}
		return getPhoneCode(phone,imgCode);
	}

	@RequestMapping(value = "/getMemberMsg", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String,Object> getMemberMsg(HttpServletRequest request, HttpServletResponse response,String mobile){
		Member member = memberService.getMemberByMobile(mobile,null);
		return getMemberMsg(member);
	}
	@RequestMapping(value = "/logout")
	public String exit(HttpServletRequest request) {
		request.setAttribute("loginInfo","");
		request.getSession().invalidate();
		return "redirect:/admin/login.html";
	}
	@RequestMapping(value = "/toUpdatePassWd")
	public String toUpdatePassWd(HttpServletRequest request) {
		String type = request.getParameter("type");
		String  flag="no";
		if(StringUtils.isNotBlank(type)&&"2".equals(type)){
			Member member = memberService.getMemberById(getUserId(request));
			if(member!=null&&StringUtils.isNotBlank(member.getPayPassword())){
				flag="yes";
			}
		}
		request.setAttribute("isRequire",flag);
		request.setAttribute("type",type);
		return "sys/updatePassWd";
	}

	public  Map<String, Object> getPhoneCode(String phone,String imgVerify){
		Data data = getImgVerity(imgVerify);
		if(data.getCode()!=200){
			return ResultUtil.resultError(data.getMsg());
		}
		Map<String,Object> param = new HashMap<>();
		param.put("length",4);
		param.put("mobile",phone);
		param.put("token",System.currentTimeMillis());
		param.put("templateId","t1");
		String result;
		Long timemili = System.currentTimeMillis() / 1000;
		try {
			String fixedDB = redisUtils.getFixedDB(phone, Constants.FIXED_DB);
			if(StringUtils.isNotEmpty(fixedDB)){
				if (timemili - Long.parseLong(fixedDB.substring(4)) < 60) {
					return ResultUtil.resultError("请一分钟后再次重试" );
				}
			}
			result = HttpClientUtil.httpPostRequest("http://validate.aliyun.com//validate/sendsms", param);
			JSONObject json = JSONObject.parseObject(result);
			if ((Integer) json.get("code") == 200) {
				redisUtils.setEXFixedDB(phone, json.getString("msg")+timemili, 15*60, Constants.FIXED_DB);
				LogMgr.writeSysInfoLog(result);
				return ResultUtil.resultSuccess();
			} else {
				return ResultUtil.resultError("获取验证码失败:" + json.getString("msg"));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return ResultUtil.resultError("获取验证码失败");
		}
	}
	
	

}
