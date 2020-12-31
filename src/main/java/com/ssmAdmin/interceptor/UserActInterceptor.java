package com.ssmAdmin.interceptor;

import com.ssmAdmin.common.Constants;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.service.UserActService;
import com.ssmAdmin.util.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserActInterceptor implements HandlerInterceptor {

	@Autowired
	private UserActService userActService;
	@Autowired
	private RedisUtils redisUtils;

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {

		if (request.getSession().getAttribute("currentUser") != null) {
			String servletPath = request.getServletPath();
			if(servletPath.contains(Constants.toForm)){
				userActService.LogAct(
						(Member) request.getSession().getAttribute("currentUser"),
						request.getServletPath(), request.getParameterMap());
			}
			return true;
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) {
		this.beforeFormHander(request.getServletPath(),request.getRequestedSessionId(),request);
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex){

	}

	/**
	 * 表单重复提交处理
	 * true 表示正常；false 表示重复提交表单。
	 */
	public void beforeFormHander(String url,String sessionId, HttpServletRequest request){
		if(url.contains(Constants.toForm)){
			String stoken = System.currentTimeMillis()+"";
			redisUtils.setEXFixedDB(url.replace(Constants.toForm,sessionId).replace(".html",""),stoken,60*10, Constants.FIXED_DB);
			request.setAttribute(Constants.stoken,stoken);
		}
	}
}
