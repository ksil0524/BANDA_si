package com.mvc.banda;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;

@Component
public class Bandafilter implements Filter {

   public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
       HttpServletResponse response = (HttpServletResponse) res;

       response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
       response.setHeader("Access-Control-Max-Age", "3600");
       response.setHeader("Access-Control-Allow-Headers", "x-requested-with");

       // 허용대상: 전부 허용하던지
       response.setHeader("Access-Control-Allow-Origin", "*");
       // 허용대상: 아래 3개의 도메인만 허용하던지
       // response.addHeader("Access-Control-Allow-Origin", "http://S1.ABC.co.kr");
       // response.addHeader("Access-Control-Allow-Origin", "http://S2.ABC.co.kr");
       // response.addHeader("Access-Control-Allow-Origin", "http://S3.ABC.co.kr");

       chain.doFilter(req, res);
   }
   public void init(FilterConfig filterConfig) {}
   public void destroy() {}
}