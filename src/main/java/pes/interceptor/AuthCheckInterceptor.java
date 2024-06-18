package pes.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class AuthCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object handler) throws Exception {
		HttpSession session = req.getSession(false);
		if(session != null) {
			Object auth = session.getAttribute("auth");
			if(auth != null) {
				return true;
			}
		}
		String userURI = req.getRequestURI();
		String queryString = req.getQueryString();
		if(queryString != null && !queryString.isEmpty()) {
			userURI += "?" + queryString;
		}
		if(session != null) {
			session.setAttribute("userURI", userURI);
		}
		resp.sendRedirect(req.getContextPath() + "/member/login");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
	
}
