package com.ssmAdmin.interceptor;

import com.ssmAdmin.common.Constants;
import com.ssmAdmin.controller.base.BaseController;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.entity.sqlEntity.UserSession;
import com.ssmAdmin.service.SessionService;
import com.ssmAdmin.util.PCAddress;
import com.zbjr.log.LogMgr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CheckLoginInterceptor extends BaseController implements HandlerInterceptor {
	private NamedThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<>("WatchExecuteTime");
	@Autowired
	private SessionService sessionService;

	String [] noLoginUrls = {"/admin/login.html","/fileUpload/upload.html","/admin/getVerifyCode.html","/admin/getPhoneVerify.json","/admin/getMemberMsg.json"};

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		String servletPath = request.getServletPath();
		for (String url:noLoginUrls) {
			if(servletPath.startsWith(url)){
				LogMgr.writeSysInfoLog(PCAddress.getIpAddress(request)+"|"+servletPath);
				return true;
			}
		}
		String reqUrl = request.getRequestURI();
		if(reqUrl.contains("member/payIn")){
			return true;
		}
		LogMgr.writeSysInfoLog(PCAddress.getIpAddress(request));
		Member usesession = (Member) request.getSession().getAttribute("currentUser");
		if(usesession != null){
			String sessionId = request.getSession().getId();
				long beginTime = System.currentTimeMillis();            //开始时间
				startTimeThreadLocal.set(beginTime);
					UserSession userSession = sessionService.getSessionIdById((usesession).getId());
					if(sessionId.equals(userSession.getSessionId())){
						return true;
					}else{
						response.sendRedirect(request.getContextPath() + noLoginUrls[0]);
						return false;
					}
		}else{
			LogMgr.writeSysInfoLog(PCAddress.getIpAddress(request)+"|"+servletPath);
		}
		if(!servletPath.contains("transfer/getTotalMsg")){
			response.sendRedirect(request.getContextPath() + noLoginUrls[0]);
		}
		return false;
	}
	@Override
	public void postHandle(HttpServletRequest request,
						   HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		request.setAttribute("staticUrl", Constants.STATIC_URL);
	}
	@Override
	public void afterCompletion(HttpServletRequest request,
								HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
//		request.setAttribute("staticUrl", Constants.STATIC_URL);
		long endTime = System.currentTimeMillis();
/*		if(startTimeThreadLocal.get()!=null){
			long executeTime = endTime - startTimeThreadLocal.get();
			if(executeTime>4000){
				LogMgr.writeSysInfoLog(String.format("%s executeu %d ms." , request.getRequestURI() , executeTime));
			}
		}*/
	}
}