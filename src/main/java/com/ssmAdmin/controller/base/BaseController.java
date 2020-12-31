package com.ssmAdmin.controller.base;

import com.github.pagehelper.StringUtil;
import com.ssmAdmin.common.Constants;
import com.ssmAdmin.entity.Data;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.entity.Paging;
import com.ssmAdmin.service.MemberService;
import com.ssmAdmin.util.CheckNum;
import com.ssmAdmin.util.GoogleAuthenticator;
import com.ssmAdmin.util.RedisUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

public class BaseController {

    /**
     * 请求对象转 MAP
     * @param request 请求对象
     * @return 返回Map 对象
     */
    public Map requestTOMap(HttpServletRequest request){
        //request --> map
        Map<String,String[]> rmap =request.getParameterMap();
        Map rparameters = new TreeMap();
        for(String key:rmap.keySet()) {
            rparameters.put(key,rmap.get(key)[0]);
        }
        return rparameters;
    }

	@Autowired
	private MemberService memberService;
    @Autowired
    private RedisUtils redisUtils;


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }


    private String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cs = request.getCookies();
        if(cs != null) {
            Cookie[] arr$ = cs;
            int len$ = cs.length;

            for(int i$ = 0; i$ < len$; ++i$) {
                Cookie c = arr$[i$];
                if(c.getName().equals(name)) {
                    return c.getValue();
                }
            }
        }

        return null;
    }


    public Long getUserId(HttpServletRequest request) {
        Member currentUser = (Member) request.getSession().getAttribute("currentUser");
        Long userId = null;
        if(currentUser != null) {
            userId = currentUser.getId();
        }

        return userId != null?userId:-1;
    }

    public String getMemberMobile(HttpServletRequest request) {
        Member currentUser = (Member) request.getSession().getAttribute("currentUser");
        return currentUser.getLoginName();
    }
    public Member getCurrentUser(HttpServletRequest request) {
        Member currentUser = (Member) request.getSession().getAttribute("currentUser");
        return currentUser;
    }

//    /**
//     * 防止表单重复提交第一步
//     */
//    protected String setFormSession(String flag, Integer memberId){
//        String token = System.currentTimeMillis()+""+memberId;
//        redisUtils.setEXFixedDB(flag+memberId,token,60*5,Constants.FIXED_DB);
//        return token;
//    }
//String url,String sessionId,
    public boolean isRepeatForm(HttpServletRequest request){
        String servletPath = request.getServletPath();
        String sessionId = request.getRequestedSessionId();
        String key = servletPath.replace(Constants.submitForm,sessionId).replace(".json","");
        String value = request.getParameter(Constants.stoken);
        return isRepeat(key,value);
    }
    /**
     * 判断redis是否有值
     * @param value redis 存的值
     * @return 如果有值，则返回 true
     */
    private synchronized boolean isRepeat(String key,String value){
        String v = redisUtils.getFixedDB(key, Constants.FIXED_DB);
        if(StringUtils.isNotBlank(v)&&v.equals(value)){
            redisUtils.setEXFixedDB(key,"",1, Constants.FIXED_DB);
            return true;
        }
        return false;
    }

    /**
     * 获得paging对象用于分页
     * @param request
     * @return
     */
    public Paging getPaging(HttpServletRequest request) {
        if(request == null) {
            return null;
        } else {
            Paging paging = new Paging();
            String pagesize = request.getParameter("pageSize");
            if (StringUtils.isNotEmpty(pagesize)) {
                paging.setPageSize(Integer.parseInt(pagesize));
            }
            String currentPage = request.getParameter("currentPage");
            if (StringUtils.isNotEmpty(currentPage)) {
                paging.setCurrentPage(Integer.parseInt(currentPage));
            }
            return paging;
        }
    }

    /**
     * 验证是否变变化登录用户
     * @param request
     * @return
     */
    public boolean vadateCurrentUser(HttpServletRequest request) {
        Member member = this.getCurrentUser(request);
        int currentRoleId = member.getRoleId();
        Long currentUserId = member.getId();
        String currentUserIdStr = request.getParameter("currentUserId");
        String currentUserRoleIdStr = request.getParameter("currentUserRoleId");
        if(CheckNum.checkNum(currentUserRoleIdStr)&& CheckNum.checkNum(currentUserIdStr)){
            if(Integer.valueOf(currentUserRoleIdStr)==currentRoleId&&Long.valueOf(currentUserIdStr)==currentUserId){
                return true;
            }else{
                return false;
            }
        }else {
            return false;
        }

    }
	/**
	 * @Title: getAgentMemberIds
	 * @Description: 得到代理的memberId
	 * @date 2018年12月26日 上午11:15:41
	 */
	 public String getAgentMemberIds(Integer agentId) {
	    	StringBuffer stringBuffer = new StringBuffer();
	    	stringBuffer.append("(");
 		Map<String, Object> params = new HashMap<>();
 		// 封装参数
 		params.put("createBy", agentId);
 		List<Member> merchants = memberService.getMerchantList(params);
 		if(merchants!=null&&merchants.size()>0) {
 			for (Member member2 : merchants) {
 				stringBuffer.append(member2.getId()+",");
 			}
 		}
 		stringBuffer.deleteCharAt(stringBuffer.length()-1).append(")");
 		if(")".equals(stringBuffer.toString())) {
 			return "("+-1+")";
 		}else {
 			return stringBuffer.toString();
 		}
	 }

	 public Map<String,Object> getMemberMsg(Member member){
         Map<String,Object> map = new HashMap<>();
         if(member!=null){
             if(org.apache.commons.lang3.StringUtils.isNotEmpty(member.getGoogleSecretKey())){
                 map.put("google","ok");
             }else{
                 map.put("google","no");
             }
             if (org.apache.commons.lang3.StringUtils.isNotEmpty(member.getPhone())) {
                 map.put("verity", "ok");
             } else {
                 map.put("verity", "no");
             }
         }
         return map;
     }

     public Data getImgVerity(String imgVerify){
         String img = redisUtils.getFixedDB("imgVerify", Constants.FIXED_DB);
         if (StringUtils.isNotEmpty(imgVerify)) {
             if (!imgVerify.equalsIgnoreCase(img)) {
                 return new Data(400,"图片验证码不正确");
             }
         } else {
             return new Data(400,"请输入图片验证码");
         }
         return new Data(200,"");
     }

    public Data getMemberGoogleSecretKey(Long id,Integer googleSecretKey){
        Member member = memberService.getMemberById(id);
        if(StringUtil.isNotEmpty(member.getGoogleSecretKey())){
            if(googleSecretKey!=null) {
                Boolean aBoolean = GoogleAuthenticator.check_code(member.getGoogleSecretKey(), googleSecretKey, System.currentTimeMillis());
                if (!aBoolean) {
                    return new Data(402, "谷歌验证码输入错误");
                }
            }else{
                return new Data(402, "请填写谷歌验证码");
            }
        }
        return new Data(200,"");
    }

}
