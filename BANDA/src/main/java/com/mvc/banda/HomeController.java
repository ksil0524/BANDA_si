package com.mvc.banda;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping("/index.do")
	public String index() {
	
		return "index";
	}

	
	@RequestMapping("/boardDetail.do")
	public String boardDetail() {
		return "temp/boardDetail";
	}
	
	
	@RequestMapping("/boardListExchange.do")
	public String boardListExchange() {
		return "temp/boardListExchange";
	}
	
	
	@RequestMapping("/boardListFree.do")
	public String boardListFree() {
		return "temp/boardListFree";
	}
	
	
	@RequestMapping("/boardWrite.do")
	public String boardWrite() {
		return "temp/boardWrite";
	}
	
	
	@RequestMapping("/mapDrugstore.do")
	public String mapDrugstore() {
		return "temp/mapDrugstore";
	}
	
	
	@RequestMapping("/mapHospital.do")
	public String mapHospital() {
		return "temp/mapHospital";
	}
	
	
	@RequestMapping("/mapPark.do")
	public String mapPark() {
		return "temp/mapPark";
	}
	
	
	@RequestMapping("/myChat.do")
	public String myChat() {
		return "temp/myChat";
	}
	
	
	@RequestMapping("/mypageAccount.do")
	public String mypageAccount() {
		return "temp/mypageAccount";
	}
	
	@RequestMapping("/mypageFeed.do")
	public String mypageFeed() {
		return "redirect:mypageFeed_list.do";
	}
	
	@RequestMapping("/mypageFollw.do")
	public String mypageFollw() {
		return "temp/mypageFollw";
	}
	
	@RequestMapping("/mypagePets.do")
	public String mypagePets() {
		return "temp/mypagePets";
	}
	
	@RequestMapping("/index_go.do")
	public String index_go(){
		
		return "redirect:main_selectList.do";
	}
	
	@RequestMapping("/index_search.do")
	public String index_search(){
		
		return "redirect:index_search_test.do";
	}
	
}
