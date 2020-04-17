//윈도우전용 컨트롤러
package com.mvc.banda;

import javax.crypto.Cipher;
import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Provider.Service;
import java.security.spec.RSAPublicKeySpec;
//import java.net.PasswordAuthentication;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpSession;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mvc.banda.auth.SNSLogin;
import com.mvc.banda.auth.Snsvalue;
import com.mvc.banda.biz.BandaBiz;
import com.mvc.banda.common.PageMaker;
import com.mvc.banda.common.SearchCriteria;
import com.mvc.banda.model.vo.AccountVo;
import com.mvc.banda.model.vo.CommentVo;
import com.mvc.banda.model.vo.FeedNoVo;
import com.mvc.banda.model.vo.BoardVo;
import com.mvc.banda.model.vo.ChatVo;
import com.mvc.banda.model.vo.PetVo;
import com.mvc.banda.model.vo.User;
import com.mvc.banda.model.vo.FeedVo;
import com.mvc.banda.model.vo.FollowVo;
import com.mvc.banda.model.vo.LikesVo;
import com.mvc.banda.model.vo.MapVo;

@Controller
public class BandaController {
	
	
	@Autowired
	public HttpSession session;
	
	@Autowired
	private BandaBiz biz;
	
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 김성일 파트  시작 >  
	
	@RequestMapping("/mypage_allselect.do")
	public String mypage_allselect(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		AccountVo votmp = (AccountVo)session.getAttribute("vo");
		
		session.removeAttribute("vo");
		
		session.setMaxInactiveInterval(60*60);
			
		AccountVo accvo = biz.mypage_allselect(votmp.getId());
		
		session.setAttribute("vo", accvo);
		System.out.println("mypage_allselect");
		
		return "temp/mypagePets";
	}
	
	
	
	@RequestMapping("/change_pet.do")
	@ResponseBody
	public Map<String, PetVo> change_pet(@RequestBody int pno){
		
		System.out.println("change_pet");
		
		PetVo selectpet = biz.mypage_selectPet(pno);		
				
		Map<String, PetVo> resMap = new HashMap<String, PetVo>();
		resMap.put("petVo", selectpet);
		
		return resMap;
	}
	
	@RequestMapping(value = "/mypage_pet_update.do", method=RequestMethod.POST)
	public String mypage_pet_update(HttpServletRequest request, Model model, PetVo petVo, @RequestParam String p_birthtmp, MultipartFile updateimgInp) throws IllegalStateException, IOException {
		
		System.out.println("mypage_pet_update");
		
		Date date = null;
		
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(p_birthtmp);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		petVo.setP_birth(date);
		
		int res = biz.mypage_pet_update(petVo);
		
		///////////////////////////////////////////////
		
		String filename = updateimgInp.getOriginalFilename();
				
		//파일을 새로 업로드 하지 않았다면 바로 return
		if(filename == "") {
			return "redirect:mypage_allselect.do";
		}
			
		String savepath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\pet\\pet_profile\\"+petVo.getP_no());
				
		File updateimg = new File(savepath+"\\"+filename);
		
		updateimgInp.transferTo(updateimg);
		
		//파일 이름 바꿔주기 작업
		//image.jpg 가져오기
		File imagefile = new File(savepath+"\\image.jpg");
		//image.jpg 삭제
		imagefile.delete();
		//업로드한 이미지 이름 image.jpg로 바꿔서 붙혀넣기
		updateimg.renameTo(imagefile);
		//업로드한 이미지 삭제
		updateimg.delete();
		
		return "redirect:mypage_allselect.do";
	}
	
	/*
	 * 파일 관리 참고용
	 File folder = new File(newpath);

         if (!folder.exists()) {
            try{
                folder.mkdir(); //폴더 생성합니다.
                System.out.println("폴더가 생성되었습니다.");
                 } 
                 catch(Exception e){
                e.getStackTrace();
            }        
               }else {
            System.out.println("이미 폴더가 생성되어 있습니다.");
         }
	 */
	
	
	@RequestMapping(value="/mypage_pet_insert.do", method = RequestMethod.POST)
	public String mypage_pet_insert(HttpServletRequest request, Model model, PetVo petVo, @RequestParam String p_birthtmp, MultipartFile insertimgInp) throws IllegalStateException, IOException {
		
		System.out.println("mypage_pet_insert");
		
		Date date = null;
		
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(p_birthtmp);
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		petVo.setP_birth(date);
				
		int res = biz.mypage_pet_insert(petVo);
		
		////////////////////////////////////////////////////
		
		if(res > 0) {
			
			int lastpno = biz.getLastPetSeq();
			PetVo vo = biz.mypage_selectPet(lastpno);
			
			String savepath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\pet\\pet_profile\\"+vo.getP_no());
			System.out.println("savepath : "+savepath);
			
			File folder = new File(savepath);

	         if (!folder.exists()) {
	            try{
	                folder.mkdir(); //폴더 생성합니다.
	                System.out.println("폴더가 생성되었습니다.");
	                 } 
	                 catch(Exception e){
	                e.getStackTrace();
	            }        
	               }else {
	            System.out.println("이미 폴더가 생성되어 있습니다.");
	         }

	         String filename = insertimgInp.getOriginalFilename();
	         
	         File insertimg = new File(savepath+"\\"+filename);
	         insertimgInp.transferTo(insertimg);
	         
	       //파일 이름 바꿔주기 작업
	 		//image.jpg 만들긴
	 		File imagefile = new File(savepath+"\\image.jpg");
	 		//업로드한 이미지 이름 image.jpg로 바꿔서 붙혀넣기
	 		insertimg.renameTo(imagefile);
	 		//업로드한 이미지 삭제
	 		insertimg.delete();

	 		
	 		return "redirect:mypage_allselect.do";
	 		
	 		
		}else {
			
			System.out.println("error : controller - mypage_pet_insert");
			
	 		return "redirect:mypage_allselect.do";

		}
		
	}
	
	@RequestMapping("/mypage_accountpage.do")
	public String mypage_accountpage(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		AccountVo votmp = (AccountVo)session.getAttribute("vo");
		
		session.removeAttribute("vo");
		
		session.setMaxInactiveInterval(60*60);
		
		AccountVo accvo = biz.mypage_allselect(votmp.getId());
		
		session.setAttribute("vo", accvo);
		System.out.println("mypage_accountpage");
		
		return "temp/mypageAccount";
	}
	
	@RequestMapping(value="/mypage_acco_changeprofileimg.do", method = RequestMethod.POST)
	public String mypage_acco_changeprofileimg(HttpServletRequest request, Model model, @RequestParam String account_id, MultipartFile profile_img) throws IllegalStateException, IOException {
		
		
		String savepath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\account\\account_profile\\"+account_id);
		System.out.println("savepath : "+savepath);
		
		String filename = profile_img.getOriginalFilename();
		
		System.out.println(filename);
		
		File updateprofileimg = new File(savepath+"\\"+filename);
		profile_img.transferTo(updateprofileimg);
		
		//image.jpg 가지는 객체
		File imagefile = new File(savepath+"\\image.jpg");
		//image.jpg 삭제
		imagefile.delete();
 		//업로드한 이미지 이름 image.jpg로 바꿔서 붙혀넣기
		updateprofileimg.renameTo(imagefile);
 		//업로드한 이미지 삭제
 		updateprofileimg.delete();
 		
 		return "redirect:mypage_accountpage.do";
	}
	
	
	@RequestMapping("/mypage_accountupdate.do")
	public String mypage_accountupdate(AccountVo accvo) {
		
		System.out.println("mypage_accountupdate");
		String enpassword = passwordEncoder.encode(accvo.getPassword());
		
		accvo.setPassword(enpassword);
		
		int res = biz.mypage_accountupdate(accvo);
		
		return "redirect:mypage_accountpage.do";
		
	}
	
	
	@RequestMapping("/mypage_followpage.do")
	public String mypage_followpage(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("mypage_followpage");

		HttpSession session = request.getSession();
		
		AccountVo votmp = (AccountVo)session.getAttribute("vo");
		
		session.removeAttribute("vo");
		
		session.setMaxInactiveInterval(60*60);
		
		String id = "ADMIN";
		
		AccountVo accvo = biz.mypage_allselect(votmp.getId());
		
		// 해당하는 아이디가  팔로우하고 있는 계정들 정보 리스트
		List<AccountVo> fr_acclist = biz.mypage_fr_accountSelectList(accvo.getId());

		// 해당하는 아이디를  팔로우하고 있는 계정들 정보 리스트
		List<AccountVo> fd_acclist = biz.mypage_fd_accountSelectList(accvo.getId());
		
		session.setAttribute("vo", accvo);
		model.addAttribute("fr_acclist", fr_acclist);
		model.addAttribute("fd_acclist", fd_acclist);
		
		return "temp/mypageFollw";
		
	}
	
	@RequestMapping("/mypage_unfollow.do")
	@ResponseBody
	public Map<String, Boolean> mypage_unfollow(@RequestBody String[] idarr){
		
		System.out.println("mypage_unfollow");
		
		String fr_id = idarr[0];
		String fd_id = idarr[1];
		FollowVo fvo = new FollowVo(fr_id, fd_id);
		
		int res = biz.mypage_unfollow(fvo);

		Map<String, Boolean> resMap = new HashMap<String, Boolean>();
		
		if(res>0) {
			resMap.put("res", true);
		}else {
			resMap.put("res", false);
		}
		
		return resMap;
	}
	
	
	@RequestMapping("/mypage_follow.do")
	@ResponseBody
	public Map<String, Boolean> mypage_follow(@RequestBody String[] idarr){
		
		System.out.println("mypage_follow");
		
		String fr_id = idarr[0];
		String fd_id = idarr[1];
		FollowVo fvo = new FollowVo(fr_id, fd_id);
		
		int res = biz.mypage_follow(fvo);

		Map<String, Boolean> resMap = new HashMap<String, Boolean>();
		
		if(res>0) {
			resMap.put("res", true);
		}else {
			resMap.put("res", false);
		}
		
		return resMap;
	}
	
	@RequestMapping("/mypage_feedpage.do")
	public String mypage_feedpage(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("mypage_feedpage");

		HttpSession session = request.getSession();
		
		AccountVo votmp = (AccountVo)session.getAttribute("vo");
		
		session.removeAttribute("vo");
		
		session.setMaxInactiveInterval(60*60);
				
		AccountVo accvo = biz.mypage_allselect(votmp.getId());

		session.setAttribute("vo", accvo);
		
		return "temp/mypageFeed";
	}
	
	
	@RequestMapping(value = "/mypage_insertfeed.do", method = RequestMethod.POST)
	public String mypage_insertfeed(HttpServletRequest request, Model model, FeedVo feedVo, @RequestParam String[] ptaglist , @RequestParam String[] hteglist, 
									MultipartFile file_1, MultipartFile file_2, MultipartFile file_3, MultipartFile file_4, MultipartFile file_5) throws IllegalStateException, IOException {
		
		System.out.println("mypage_insertfeed");
		
		String feed_ptag = "";
		String feed_hteg = "";
		String feed_file = "";
		
		for(int i=0; i<ptaglist.length;i++) {
			feed_ptag = feed_ptag+":"+ptaglist[i]+" ";
		}
		for(int i=0; i<hteglist.length;i++) {
			feed_hteg = feed_hteg+"#"+hteglist[i]+" ";
		}
		
		feedVo.setFeed_ptag(feed_ptag);
		feedVo.setFeed_hteg(feed_hteg);
		
		int contentCount = 0;
		
		List<MultipartFile> filelist = new ArrayList<MultipartFile>();
		filelist.add(file_1);
		filelist.add(file_2);
		filelist.add(file_3);
		filelist.add(file_4);
		filelist.add(file_5);
		
		for(MultipartFile tmp : filelist) {
			if(tmp.getOriginalFilename() != "" ) {
				contentCount++;	
			}
		}
		
		for(int i=0; i<contentCount ; i++) {
			String[] ext = filelist.get(i).getOriginalFilename().split("\\.");
			String extension = ext[1];
			feed_file = feed_file+"@content_"+(1+i)+"."+extension;
		}
		
		feedVo.setFeed_file(feed_file);
		
		int res = biz.mypage_insertfeed(feedVo);
		
		///////////////////////////////////////////////////////////
		//여기서 부터 파일
		
		if(res > 0) {
			
			int lastfno = biz.getLastFeedSeq();
			
			String savepath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\feed\\"+lastfno);
			
			System.out.println("savepath : "+savepath);
			
			File folder = new File(savepath);
			
			if (!folder.exists()) {
	            try{
	                folder.mkdir(); //폴더 생성합니다.
	                System.out.println("폴더가 생성되었습니다.");
	                 } 
	                 catch(Exception e){
	                e.getStackTrace();
	            }        
	               }else {
	            System.out.println("이미 폴더가 생성되어 있습니다.");
	         }
			
			for(int i=0; i<contentCount; i++) {
				
				//확장자
				String[] ext = filelist.get(i).getOriginalFilename().split("\\.");
				String extension = ext[1];
				
				//파일이름
				String filename = filelist.get(i).getOriginalFilename();
				
				//실제 경로와 파일이름
		        File insertcontent = new File(savepath+"\\"+filename);
		        
		        //위치에 넣기
		        filelist.get(i).transferTo(insertcontent);
		        
		        //변경할 이름으로 파일 객체 만들기
		 		File renamefile = new File(savepath+"\\content_"+(1+i)+"."+extension);
		 		//업로드한 컨텐스 이름 content_(번호).(확장자)로 바꿔서 붙혀넣기
		 		insertcontent.renameTo(renamefile);
		 		//업로드한 컨텐츠 삭제
		 		insertcontent.delete();
				
			}

		}
		
		return "redirect:mypageFeed.do";
	}
	
	@RequestMapping("/mypage_deletefeed.do")
	public String mypage_deletefeed(HttpServletRequest request, HttpServletResponse response, Model model, int deletefeed_no) {
		
		System.out.println("mypage_deletefeed");
		
		int res = biz.mypage_deletefeed(deletefeed_no);	
		
		String savepath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\feed\\"+deletefeed_no);
		
		if(res > 0) {		
			File deletefile = new File(savepath);
			deletefile.delete();
		}
		
		return "redirect:mypageFeed.do";
	}
	
	
	@RequestMapping("/streaming_test.do")
	public String streaming_test(Model model) {
		
		return "temp/Streaming_test";
	}
	
	
	//채팅 페이지로 이동
	@RequestMapping("/myChatpage.do")
	public String myChatpage(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("myChatpage.do");
		
		HttpSession session = request.getSession();
		
		AccountVo votmp = (AccountVo)session.getAttribute("vo");
		
		session.removeAttribute("vo");
		
		session.setMaxInactiveInterval(60*60);
			
		AccountVo accvo = biz.mypage_allselect(votmp.getId());
		List<ChatVo> chat_list = biz.myChat_selectlist(votmp.getId());
		accvo.setChat_list(chat_list);
		
		System.out.println("chat_list : "+chat_list);
		
		//검색할 수 있게 존재하는 모든 아이디 가져오기
		List<String> id_list = biz.mychat_searchidlist();
		
		session.setAttribute("vo", accvo);
		session.setAttribute("id_list", id_list);
		
		return "temp/myChat";
	}
	
	@RequestMapping("/change_chatroom.do")
	@ResponseBody
	public Map<String, List<ChatVo>> change_chatroom(HttpSession session, @RequestBody String otherid){
		
		System.out.println("change_chatroom");
		
		AccountVo nowvo = (AccountVo)session.getAttribute("vo");
		String userid = nowvo.getId();
		
		String anotherid = otherid.substring(1, otherid.length()-1);
						
		List<ChatVo> chatlist = biz.mychat_selectonelist(userid, anotherid);
		
		Map<String, List<ChatVo>> resMap = new HashMap<String, List<ChatVo>>();
		resMap.put("chatlist", chatlist);
		
		return resMap;
	}
	
	@RequestMapping("/insertchat.do")
	@ResponseBody
	public Map<String, Boolean> insertchat(@RequestBody Map<String, String> data){
		
		System.out.println("insertchat");
				
		ChatVo vo = new ChatVo();
		vo.setS_id(data.get("s_id"));
		vo.setG_id(data.get("g_id"));
		vo.setChat_content(data.get("chat_content"));
				
		int res = biz.insert_chat(vo);
				
		Map<String, Boolean> resMap = new HashMap<String, Boolean>();
		
		if(res>0) {
			resMap.put("res", true);
		}else {
			resMap.put("res", false);
		}
		
		return resMap;
	}
	
	
	
	
	// < 김성일 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 김재익 파트  시작 >  
	
	@RequestMapping(value = "/emailoverlab.do", method = RequestMethod.POST)
	   @ResponseBody
	   public Map<String,Boolean> emailoverlab(@RequestBody AccountVo vo) {
	      int res = 0;
	      String email = vo.getEmail();
	      res = biz.emailoverlab(email);
	      
	      Map<String,Boolean> resmap = new HashMap<String, Boolean>();
	      
	      if(res >=1 ) {
	         resmap.put("res", true);
	      }else {
	         resmap.put("res", false);
	      }
	      
	      return resmap;
	   }
	
	@RequestMapping(value = "/idoverlab.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Boolean> idoverlab(@RequestBody AccountVo vo) {
		int res = 0;
		String id = vo.getId();
		res = biz.idoverlab(id);
		
		Map<String,Boolean> resmap = new HashMap<String, Boolean>();
		
		if(res >=1 ) {
			resmap.put("res", true);
		}else {
			resmap.put("res", false);
		}
		
		return resmap;
	}
	
	@RequestMapping(value = "/joinregister.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Boolean> joinregister(HttpServletRequest request ,@RequestBody AccountVo vo) {
		
		
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		int res = biz.joinregister(vo);
		
		Map<String,Boolean> resmap = new HashMap<String, Boolean>();
		
		if(res >=1 ) {
			resmap.put("res", true);
		}else {
			resmap.put("res", false);
		}
		////
		String path = request.getSession().getServletContext()
	            .getRealPath("resources\\images\\filemanager\\account\\account_profile\\" + vo.getId());

	      File Folder = new File(path);

	      // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	      if (!Folder.exists()) {
	         try {
	            Folder.mkdir(); // 폴더 생성합니다.
	            System.out.println("폴더가 생성되었습니다.");
	         } catch (Exception e) {
	            e.getStackTrace();
	         }
	      } else {
	         System.out.println("이미 폴더가 생성되어 있습니다.");
	      }

	      // 원본 파일경로
	      String oriFilePath = request.getSession().getServletContext()
	            .getRealPath("resources\\images\\filemanager\\account\\account_profile\\image.jpg");
	      // 복사될 파일경로
	      String copyFilePath = path + "\\image.jpg";

	      // 파일객체생성
	      File oriFile = new File(oriFilePath);
	      // 복사파일객체생성
	      File copyFile = new File(copyFilePath);

	      try {

	         FileInputStream fis = new FileInputStream(oriFile); // 읽을파일
	         FileOutputStream fos = new FileOutputStream(copyFile); // 복사할파일

	         int fileByte = 0;
	         // fis.read()가 -1 이면 파일을 다 읽은것
	         while ((fileByte = fis.read()) != -1) {
	            fos.write(fileByte);
	         }
	         // 자원사용종료
	         fis.close();
	         fos.close();

	      } catch (FileNotFoundException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }

	      ////
		
		return resmap;
	}
	
	

	@RequestMapping(value = "/google.do", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public Map<String,Boolean> googlelogin(HttpServletRequest request ,@RequestBody AccountVo vo) throws Exception {
		Map<String,Boolean> resmap = new HashMap<String, Boolean>();
		Boolean chk = true;
	      //1. code이용하여 access token 받기
	      //2. access token이용하여 사용자 profile 정보 가져오기
	      //4. 존재하는 경우 로그인, 아닌경우 계정 생성
	      //3. db에 해당 유저 존재하는지 체크
		String id = vo.getId();
	      
	     

		
	      
	      AccountVo avo = new AccountVo();
	      avo.setId(id);
	      
	      AccountVo real_vo = biz.jy_login(avo);
	      
	      
	      if(real_vo == null) {
	         
	         System.out.println("아이디 없음");
	         
	         String pwd = passwordEncoder.encode("1234");
	         
	         real_vo = new AccountVo(id, pwd, id+"sns", "010-1111-1111");
	         
	         
	         int res = biz.naver_register(real_vo);
	         
	         if(res > 0 ) {
	            System.out.println("구글로 회원가입 성공");
	            
	            session.setAttribute("vo", real_vo);
	            session.setMaxInactiveInterval(60*60);
	         } else {
	            System.out.println("구글로 회원가입 실패");
	         }
	         
	      } else {
	         
	         System.out.println(real_vo+"아이디 존재");
	         session.setAttribute("vo", real_vo);
	         session.setMaxInactiveInterval(60*60);
	         
	      }
	      
	 
	      
	      String path = request.getSession().getServletContext()
	               .getRealPath("resources\\images\\filemanager\\account\\account_profile\\" + real_vo.getId());

	         File Folder = new File(path);

	         // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	         if (!Folder.exists()) {
	            try {
	               Folder.mkdir(); // 폴더 생성합니다.
	               System.out.println("폴더가 생성되었습니다.");
	            } catch (Exception e) {
	               e.getStackTrace();
	            }
	         } else {
	            System.out.println("이미 폴더가 생성되어 있습니다.");
	         }

	         // 원본 파일경로
	         String oriFilePath = request.getSession().getServletContext()
	               .getRealPath("resources\\images\\filemanager\\account\\account_profile\\image.jpg");
	         // 복사될 파일경로
	         String copyFilePath = path + "\\image.jpg";

	         // 파일객체생성
	         File oriFile = new File(oriFilePath);
	         // 복사파일객체생성
	         File copyFile = new File(copyFilePath);

	         try {

	            FileInputStream fis = new FileInputStream(oriFile); // 읽을파일
	            FileOutputStream fos = new FileOutputStream(copyFile); // 복사할파일

	            int fileByte = 0;
	            // fis.read()가 -1 이면 파일을 다 읽은것
	            while ((fileByte = fis.read()) != -1) {
	               fos.write(fileByte);
	            }
	            // 자원사용종료
	            fis.close();
	            fos.close();

	         } catch (FileNotFoundException e) {
	            e.printStackTrace();
	         } catch (IOException e) {
	            e.printStackTrace();
	         }
	      
	      resmap.put("chk", chk);
	      return resmap;
	}



	
	
	// < 김재익 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 정유진 파트  시작 >  
	
	//login
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	//login
	@ResponseBody
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public Map<String, Boolean> login(@RequestBody AccountVo vo) {
		
		session.setMaxInactiveInterval(60*60);

		
		AccountVo vo1 = biz.login(vo);
		Boolean chk = true;
		
		if(vo1 == null) {
			
			chk = false;

		}else {
			session.setAttribute("vo", vo1);
			session.setMaxInactiveInterval(60*60);
		}
		
		
		Map<String, Boolean> m = new HashMap<String, Boolean>();
		m.put("chk", chk);
		return m;
	}

	//logout
	@ResponseBody
	@RequestMapping(value = "/logout.do", method = RequestMethod.POST)
	public Map<String, Boolean> logout() {
		
		session.invalidate();

		Map<String, Boolean> m = new HashMap<String, Boolean>();
		m.put("chk", true);
		
		return m;
	}
	
	
	@RequestMapping("/register.do")
	public String register(AccountVo vo) {
		
		int res = biz.register(vo);
		
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		System.out.println("test:"+vo.getPassword());
		
		if(res>0) {
			return "redirect:login.do";
		}else {
			return "redirect:register.do";
		}
		
		
		
	
	}
	
	
	//메인 리스트 출력
	@RequestMapping("/uj_selectList.do")
	public String selectList(Model model) {
		
		
		if(session.getAttribute("vo") != null) {
			
			AccountVo vo = (AccountVo)session.getAttribute("vo");
			String id = vo.getId();
			
			System.out.println(id);
			
			System.out.println("세션존재");
			AccountVo vo1 = (AccountVo)biz.main_selectList(id);
			
			model.addAttribute("vo", vo1);
			
		} else {
			System.out.println("세션없음");
		}

		
		return "index";
	}

	
	
	
	
	
	// < 정유진 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 정재호 파트  시작 >  

	
//	@RequestMapping("/circleheader_searchindex.do")
//	public String circleheader_searchindex(Model model, String category, String keyword) {
//		
//		System.out.println("검색 : cate: " + category +"/ keyworkd: " + keyword);
//		
//		return null;
//	}
		
	@RequestMapping(value="/circleheader_autosearch.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> autosearch(HttpSession session, String keyword, String searchtype){
		/*
		 * 검색어 자동완성
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200219
		*/
		List<String> list = biz.circleheader_autosearch(keyword, searchtype);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("success", true);
		return map;
	}
	
	
	// < 정재호 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 최주예 파트  시작 >  

	//login
	@ResponseBody
	@RequestMapping(value = "/jy_login.do", method = RequestMethod.POST)
	public Map<String, Object> jy_login(@RequestBody AccountVo vo, HttpServletRequest request) {

		Map<String, Object> m = new HashMap<String, Object>();
		Boolean chk = true;
		
		//입력비밀번호
		String input_pwd = vo.getPassword();
		AccountVo vo2 = biz.jy_login(vo);
		
		//디비비밀번호
		try {
			
			String db_pwd = vo2.getPassword();
			
			if(passwordEncoder.matches(input_pwd, db_pwd)) {
				
				session.setAttribute("vo", vo2);
				session.setMaxInactiveInterval(60*60);
				
			} else {
				chk = false;
				m.put("msg","아이디와 비밀번호가 맞지 않습니다.");
			}

		} catch(Exception e) {
			chk = false;
			m.put("msg", "아이디가 존재하지 않습니다.");
		}

		m.put("chk", chk);
		
		return m;
	}
	
	
	//logout
	@ResponseBody
	@RequestMapping(value = "/jy_logout.do", method = RequestMethod.POST)
	public Map<String, Boolean> jy_logout() {
		
		session.invalidate();

		Map<String, Boolean> m = new HashMap<String, Boolean>();
		m.put("chk", true);
		
		return m;
	}

	@Inject
	private Snsvalue naverSns;
	
	//메인 리스트 출력
	@RequestMapping("/main_selectList.do")
	public String main_selectList(Model model) {
		
		//로그인 했을 떄
		if(session.getAttribute("vo") != null) {
			
			AccountVo vo = (AccountVo)session.getAttribute("vo");
			String id = vo.getId();
			
			//로그인의 팔로우 여부 판단
			List<FollowVo> fvo = biz.main_selectFollow(id);
			
			//로그인 시 팔로우 존재, 그후 그 팔로우의 피드 여부
			List<FeedVo> feedvo = new ArrayList<FeedVo>();
			
			if(fvo.size() != 0) {
				feedvo = biz.main_follow_feed(fvo);
			} else {
				feedvo = null;
			}

			//로그인 아이디의 팔로우가 존재할떄
			if(fvo.size() != 0) {
				
				//팔로우들의 피드가존재할떄
				if(feedvo.size() != 0) {
					
					AccountVo vo2 = (AccountVo)biz.main_selectList(id);
					
					model.addAttribute("fvo", vo2);

				} 
				//팔로우들의 피드가존재하지 않을 때
				else {
					
					List<FeedVo> fvo3 = biz.main_selectListN();
					
					AccountVo accvo = new AccountVo();
					
					accvo.setId(id);
					accvo.setFeed_list(fvo3);
					
					
					model.addAttribute("fvo",accvo);
					
					
				}
			} 
			
			//로그인 아이디의 팔로우가 존재하지 않을 때
			else {
				List<FeedVo> fvo2 = biz.main_selectListN();
				
				model.addAttribute("frvo",fvo2);
			}

			
		} 
		//로그인하지 않았을 경우
		else {
			List<FeedVo> fvo = biz.main_selectListN();
			
			model.addAttribute("frvo",fvo);
			
		}
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		return "index";
	}
	
	//naver에서 로그인 한 후 해당 정보 받기
	@RequestMapping(value = "/callback.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String snsLoginCallback(HttpServletRequest request, Model model, @RequestParam String code) throws Exception {
		
		//1. code이용하여 access token 받기
		//2. access token이용하여 사용자 profile 정보 가져오기
		//4. 존재하는 경우 로그인, 아닌경우 계정 생성
		//3. db에 해당 유저 존재하는지 체크
		SNSLogin snslogin = new SNSLogin(naverSns);
		
		User profile = snslogin.getUserProfile(code);	
		//System.out.println(profile + " 네이버 프로필 입니다.");

		String email = profile.getEmail();
		
		AccountVo avo = new AccountVo();
		avo.setId(email);
		
		AccountVo real_vo = biz.jy_login(avo);
		
		//AccountVo avo2 = null;
		
		if(real_vo == null) {

			String pwd = passwordEncoder.encode("1234");
			
			real_vo = new AccountVo(email, pwd, email+"sns", "010-1111-1111");
			
			int res = biz.naver_register(real_vo);
			
			if(res > 0 ) {
				
				session.setAttribute("vo", real_vo);
				session.setMaxInactiveInterval(60*60);
			} else {

			}
			
		} else {
			session.setAttribute("vo", real_vo);
			session.setMaxInactiveInterval(60*60);
			
		}
		
		////////////
		
		String path = request.getSession().getServletContext()
	            .getRealPath("resources\\images\\filemanager\\account\\account_profile\\" + real_vo.getId());

	      File Folder = new File(path);

	      // 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	      if (!Folder.exists()) {
	         try {
	            Folder.mkdir(); // 폴더 생성합니다.
	         } catch (Exception e) {
	            e.getStackTrace();
	         }
	      } else {
	      }

	      // 원본 파일경로
	      String oriFilePath = request.getSession().getServletContext()
	            .getRealPath("resources\\images\\filemanager\\account\\account_profile\\image.jpg");
	      // 복사될 파일경로
	      String copyFilePath = path + "\\image.jpg";

	      // 파일객체생성
	      File oriFile = new File(oriFilePath);
	      // 복사파일객체생성
	      File copyFile = new File(copyFilePath);

	      try {

	         FileInputStream fis = new FileInputStream(oriFile); // 읽을파일
	         FileOutputStream fos = new FileOutputStream(copyFile); // 복사할파일

	         int fileByte = 0;
	         // fis.read()가 -1 이면 파일을 다 읽은것
	         while ((fileByte = fis.read()) != -1) {
	            fos.write(fileByte);
	         }
	         // 자원사용종료
	         fis.close();
	         fos.close();

	      } catch (FileNotFoundException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
		
		
		return "redirect:main_selectList.do";
	}
	
	//내피드리스트 가져오기
	@RequestMapping("/mypageFeed_list.do")
	public String mypageFeed_list(Model model){
		
		AccountVo vo = (AccountVo)session.getAttribute("vo");
		String id = vo.getId();
		
		List<FeedVo> fvo = biz.my_feedList(id);
		
		model.addAttribute("fvo",fvo);			
		
		return "temp/mypageFeed";
	}
	
	//다른사람피드이동
	@RequestMapping("/main_otherfeed.do")
	public String main_otherfeed(Model model, String id) {
		
		Map<String, Object> m = biz.main_otherfeed(id);
		model.addAttribute("acc",m);
		
		return "temp/otherFeed";
	}
	
	//피드 하나가져오기
	@RequestMapping(value = "/each_feed.do",  method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> each_feed(@RequestBody FeedNoVo f) {
		
		Boolean chk = false;
		
		int feedno = f.getFeedno();
		FeedVo feed = biz.each_feed(feedno);

		Map<String, Object> m = new HashMap<String, Object>();
		
		if(feed != null) {
			chk = true;
			m.put("chk", chk);
			m.put("feed", feed);
		} else {
			m.put("chk", chk);
		}
		return m;
	}
	
	//댓글 삽입
	@RequestMapping("/main_insert_comment.do")
	@ResponseBody
	public Map<String, Object> main_insert_comment(@RequestBody CommentVo c){
		
		Boolean chk = false;
		Map<String, Object> m = new HashMap<String, Object>();
		
		//삽입
		int res = biz.main_insert_comment(c);
		
		//가져오기
		int feedno = c.getCom_pno();
		List<CommentVo> c2 = new ArrayList<CommentVo>();
		
		c2 = biz.main_select_comment(feedno);
		
		if(res > 0) {
		
			chk = true;
			m.put("chk", chk );
			m.put("comment_list",c2);
		
		} else {
			m.put("chk", chk );
			m.put("comment_list",c2);
		}
		
		return m;
	}
	
	//댓글삭제
	@RequestMapping("/main_delete_comment.do")
	@ResponseBody
	public Map<String, Object> main_delete_comment(@RequestBody CommentVo c){
		
			
			Boolean chk = false;
			
			Map<String, Object> m = new HashMap<String, Object>();
			
			//삭제
			int res = biz.main_delete_comment(c);
			
			//리스트
			int feedno = c.getCom_pno();
			List<CommentVo> c2 = new ArrayList<CommentVo>();
			
			c2 = biz.main_select_comment(feedno);
			
			if(res>0) {
				chk = true; 
				m.put("chk", chk);
				m.put("comment_list",c2);
			} else {
				m.put("chk", chk);
				m.put("comment_list",c2);
			}
		
		return m;
	}
	
	//댓글수정
	@RequestMapping("/main_update_comment.do")
	@ResponseBody
	public Map<String, Object> main_update_comment(@RequestBody CommentVo c){
		
		Map<String, Object> m = new HashMap<String, Object>();
		Boolean chk = false;
		
		int res = biz.main_update_comment(c);
		
		int feed_no = c.getCom_pno();
		List<CommentVo> clist = biz.main_select_comment(feed_no);
		
		if(res>0) {
			
			chk = true;
			m.put("chk", chk);
			m.put("comment_list", clist);
			
		} else {
			m.put("chk", chk);
			m.put("comment_list", clist);
		}

		return m;
	}
	
	//피드 좋아요 추가
	@RequestMapping("/feed_like_insert.do")
	@ResponseBody
	public Map<String, Object> feed_like_insert(@RequestBody LikesVo l){

		
		Map<String, Object> m = new HashMap<String, Object>();
		Boolean chk = false;
		
		int res = biz.feed_like_insert(l);
		List<LikesVo> llist = biz.main_like_list(l.getFeed_no());
		
		if(res >0) {
			chk = true;
			m.put("chk", chk);
			m.put("like_list",llist);
		} else {
			m.put("chk", chk);
			m.put("like_list",llist);
		}
		
		return m;
	}
	
	//피드 좋아요 삭제
	@RequestMapping("/feed_like_delete.do")
	@ResponseBody
	public Map<String, Object> feed_like_delete(@RequestBody LikesVo l){
		
		Map<String, Object> m = new HashMap<String, Object>();
		Boolean chk = false;
		
		int res = biz.feed_like_delete(l);
		List<LikesVo> llist = biz.main_like_list(l.getFeed_no());
		
		if(res >0) {
			chk = true;
			m.put("chk", chk);
			m.put("like_list",llist);
		} else {
			m.put("chk", chk);
			m.put("like_list",llist);
		}
		
		return m;
		
	}
	
	//아이디 찾기
	@RequestMapping("/idFind.do")
	@ResponseBody
	public Map<String, Object> idFind(@RequestBody AccountVo vo){
		
		Boolean chk = false;
		String email = vo.getEmail();
		
		Map<String, Object> m = new HashMap<String, Object>();
		
		AccountVo avo = biz.find_id(email);
		if(avo == null) {
			chk = true;
			m.put("id", "※아이디가 존재하지 않습니다");
			m.put("chk", chk);
			
		} else {
			if(avo != null) {
				chk = true;
				m.put("id", avo.getId());
				m.put("chk", chk);
			} else {
				m.put("chk", chk);
			}
		}
		
		return m;
	}

	@Autowired
	private JavaMailSender mailSender;
	
	
	//비밀번호 찾기
	@RequestMapping("/pwdFind.do")
	@ResponseBody
	public Map<String, Object> pwdFind(@RequestBody AccountVo vo){
		
		Map<String, Object> m = new HashMap<String, Object>();
		Boolean chk = true;
		
		AccountVo avo = biz.find_vo(vo);
		
		if(avo == null) {

			m.put("id", "※아이디와 이메일이 맞지 않습니다.");
			m.put("chk", chk);
			
		} else {
			
			//이메일
			String to_email = avo.getEmail();
			//아이디
			String id = avo.getId();
			
			//임시비밀번호
	         StringBuffer temp = new StringBuffer();
	         Random rnd = new Random();

	         for (int i = 0; i < 10; i++) {
	            int rIndex = rnd.nextInt(3);
	            switch (rIndex) {
	            case 0:
	               temp.append((char) ((int) (rnd.nextInt(26)) + 97));
	               break;
	            case 1:
	               temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	               break;
	            case 2:
	               temp.append((rnd.nextInt(10)));
	               break;
	            }
	         }

	         String AuthenticationKey = temp.toString();
	         
	         
	 		String setfrom = "juihy10004@gmail.com";

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(to_email); // 받는사람 이메일
				messageHelper.setSubject(id + "님의 임시 비밀번호입니다."); // 메일제목은 생략이 가능하다
				
				messageHelper.setText(id + "님의 임시 비밀번호는 " + AuthenticationKey + "입니다."); // 메일 내용

				mailSender.send(message);
				
			} catch (Exception e) {
				System.out.println(e);
			}
	         
	         //암호화
	         vo.setPassword(passwordEncoder.encode(AuthenticationKey));
	      
	         
	         int res = biz.pwdfind_update(vo);
	         
	         if(res > 0) {
	        	 m.put("id", "이메일이 전송되었습니다.");
		         m.put("chk", chk);
	         } else {
	        	 m.put("id", "이메일이 전송되었지만 데이터베이스에 입력되지 않았습니다.");
		         m.put("chk", chk);
	         }
	         
		}
	
		
		return m;
	}
	
	//검색
	 @RequestMapping("/circleheader_searchindex.do")
	 public String index_search(Model model, String category, String keyword) {
	  

	     List<FeedVo> fvo = new ArrayList<FeedVo>();
	     String keyword2 = null;
	     
	     if(category.equals("jh_searchid")) {
	    	 
	    	 fvo = biz.search_id(keyword);
	    	 keyword2 = keyword;
	    	 
	     } else if(category.equals("jh_searchfeedptag")) {
	    	 
	    	 fvo = biz.search_ptag(keyword);
	    	 keyword2 = ": "+keyword;
	    	 
	     } else {
	    	 
	    	 fvo = biz.search_htag(keyword);
	    	 keyword2 = "# "+keyword;
	     }

	     model.addAttribute("frvo",fvo);
	     model.addAttribute("keyword",keyword2);
	     

	     return "search_index";

	  }
	 
	 //회원탈퇴
	 @RequestMapping("/delete_user.do")
	 public String delete_user(String id, HttpServletRequest request) {
		 
		 Map<String, Object> res = biz.delete_user(id);
		 
		 //feed 삭제
		 List<Integer> remove_feedno = (List)res.get("feed_no");
		 
		 if(remove_feedno.size() != 0) {
			 for(Integer feedno : remove_feedno) {
				 
				 String feed_path = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\feed\\"+feedno);
				 
				 File feed_folder = new File(feed_path);
				 File[] feed_folder_list = feed_folder.listFiles();
				 
				 for(int i=0; i<feed_folder_list.length; i++) {
					 feed_folder_list[i].delete();
				 }
				 
				 if(feed_folder.isDirectory()) {
					 feed_folder.delete();
				 }
				 	 
			 }
		 }
		 
		 //pet 삭제
		 List<Integer> remove_petno = (List)res.get("pet_no");
		 
		 if(remove_petno.size() != 0) {
			 for(Integer petno : remove_petno) {
				 
				 String pet_path = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\pet\\pet_profile\\"+petno);
				 
				 File pet_folder = new File(pet_path);
				 File[] pet_folder_list = pet_folder.listFiles();

					 pet_folder_list[0].delete();
				 				 
				 if(pet_folder.isDirectory()) {
					 pet_folder.delete();
				 }
				 
			 }	 
		 }
		 
		 //board 삭제
		 List<Integer> remove_boardno = (List)res.get("board_no");
		 
		 if(remove_boardno.size() != 0) {
			 for(Integer boardno : remove_boardno) {
				 
				 String board_path = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\board\\"+boardno);
				 
				 File board_folder = new File(board_path);
				 File[] board_folder_list = board_folder.listFiles();

				 board_folder_list[0].delete();
				 				 
				 if(board_folder.isDirectory()) {
					 board_folder.delete();
				 }
				 
			 }	 
		 }
		 
		 //account 삭제
		 String remove_id = res.get("id").toString();
		 
		 String	account_path = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\account\\account_profile\\"+remove_id);

		 File account_folder = new File(account_path);
		 File[] acc_file_list = account_folder.listFiles();
		 
		 acc_file_list[0].delete();
		 
		 if(account_folder.isDirectory()) {
			 account_folder.delete();
		 }
		 
		 //최종
		 if(res.get("count").equals(1)) {

			 session.invalidate();
			 return "redirect:main_selectList.do";
		 } else {

			 return "temp/mypageAccount";
		 }
		 
	 }
	 
	 //following
	 @RequestMapping("/detail_follow_insert.do")
	 @ResponseBody
	 public Map<String, Object> detail_follow_insert(@RequestBody FollowVo fvo){
		 
		 Map<String, Object> m = new HashMap<String, Object>();
		 Boolean chk = false;
		 
		 int res = biz.detail_follow_insert(fvo);
		 
		 if(res>0) {
			 chk = true;
		 }
 
		 m.put("chk", chk);
		 
		 return m;
	 }
	 
	 //unfollowing
	 @RequestMapping("/deatil_follow_delete.do")
	 @ResponseBody
	 public Map<String, Object> deatil_follow_delete(@RequestBody FollowVo fvo){
		 
		 Map<String, Object> m = new HashMap<String, Object>();
		 Boolean chk = false;
		 
		 int res = biz.deatil_follow_delete(fvo);
		 
		 if(res > 0) {
			 chk = true;
		 }
		 
		 m.put("chk", chk);
		 
		 return m;
	 }
	
	 //모달 - 팔로우 여부
	 @RequestMapping("/follow_list_yn")
	 @ResponseBody
	 public Map<String, Object> follow_list_yn(@RequestBody FollowVo fvo){
		 
		 Map<String, Object> m = new HashMap<String, Object>();
		 Boolean chk = false;
		 
		 int fovo = biz.follow_list_yn(fvo);
		 
		 if(fovo == 1) {
			 chk = true;
		 }
		 
		 m.put("chk",chk);
		 
		 return m;
		 
	 }
	
	// < 최주예 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 주희진 파트  시작 >  
	
	@RequestMapping(value="/map_autocompleteAjax.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> map_autocompleteAjax(HttpSession session, String keyword, String mapcate){
		/*
		 * 검색어 자동완성
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200213
		*/
		
		/* 검색조건 map */
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("keyword", keyword);
		searchMap.put("mapcate", mapcate);
		
		/* result */
		List<String> list = biz.map_autocompleteAjax(searchMap); 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("success", true);
		
		return map;
	}
	
	@RequestMapping(value="/map_searchLocationAjax.do")
	@ResponseBody
	public Map<String, Object> map_searchLocationAjax(HttpSession session, String city, String district, String neighborhood,String keyword, String mapcate ){
		/*
		 * 검색
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200218
		*/
		
		/* 검색조건 map */
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("city", city);
		searchMap.put("district", district);
		searchMap.put("neighborhood", neighborhood);
		searchMap.put("addr", city+" "+district+" "+neighborhood);
		searchMap.put("keyword", keyword);
		searchMap.put("mapcate", mapcate);
		
		/* result */
		List<MapVo> list = biz.map_searchLocationAjax(searchMap);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("success", true);
		
		return map;
	}
	
	@RequestMapping(value="/map_defaultLocationAjax.do")
	@ResponseBody
	public Map<String, Object> map_searchlist(HttpSession session, String dong, String mapcate){
		/*
		 * 병원 검색
		 * 
		 * @author 주희진
		 * @version 1.0
		 * @date 200219
		*/
		
		/* 검색조건 map */
		dong = dong.replaceAll("[0-9]동","동");
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("dong", dong);
		searchMap.put("mapcate", mapcate);
		
		/* result */
		List<MapVo> list = biz.map_defaultLocationAjax(searchMap);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("success", true);
		
		return map;
	}
	
	
	
	
	// < 주희진 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------
	// < 하나경 파트  시작 >  
	
	
	//////////////////////////////////
	//무나
//	@RequestMapping(value = "/listTestSh.do", method = RequestMethod.GET)
	@RequestMapping(value = "/boardListFree.do", method = RequestMethod.GET)
	public String listSh(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		model.addAttribute("listShareNotice", biz.selectListShNotice());
		model.addAttribute("list", biz.pagingListSh(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCountSh(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "temp/boardListFree";
		
	}
	
	//물물교환
//	@RequestMapping(value = "/listTestEx.do", method = RequestMethod.GET)
	@RequestMapping(value = "/boardListExchange.do", method = RequestMethod.GET)
	public String listEx(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		model.addAttribute("listExchangeNotice", biz.selectListExNotice());
		model.addAttribute("list", biz.pagingListEx(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCountEx(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "temp/boardListExchange";
		
	}
	
	//게시글 상세
//	@RequestMapping(value = "/detailTest.do", method = RequestMethod.GET)
	@RequestMapping(value = "/boardDetail.do", method = RequestMethod.GET)
	public String read(BoardVo vo, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception{
		BoardVo vo2 = biz.selectOneBoard(vo.getBoard_no());
		
		model.addAttribute("detail", vo2);
		model.addAttribute("scri", scri);
		return "temp/boardDetail";
	}
	
	
	
	//////////////////////////////////	

	//게시글을 공지로 바꾸기
	@RequestMapping(value="/boardSetNotice.do")
	public String boardSetNotice(BoardVo vo) {
		int res = biz.boardSetNotice(vo.getBoard_no());
		if(res>0 && vo.getBoard_cate().equals("SH")) {
			return "redirect:boardListFree.do";
		} else if(res>0 && vo.getBoard_cate().equals("EX")) {			
			return "redirect:boardListExchange.do";
		} else {
			return "redirect:boardDetail.do?board_no="+vo.getBoard_no();
		}
	}

	//공지글을 일반 게시글로 내리기
	@RequestMapping(value="/boardSetNoticeCancel.do")
	public String boardNoticeCancel(BoardVo vo) {
		int res = biz.boardNoticeCancel(vo.getBoard_no());
		if(res>0 && vo.getBoard_cate().equals("SH")) {
			return "redirect:boardListFree.do";
		} else if(res>0 && vo.getBoard_cate().equals("EX")) {			
			return "redirect:boardListExchange.do";
		} else {
			return "redirect:boardDetail.do?board_no="+vo.getBoard_no();
		}	
	}
	
	//게시글 폼
	@RequestMapping(value="/boardWriteForm.do")
	public String boardWriteForm(BoardVo vo, @ModelAttribute("scri") SearchCriteria scri, Model model) {
		model.addAttribute("category", vo.getBoard_cate());
		System.out.println("카테고리 : "+vo.getBoard_cate());
		
		model.addAttribute("scri", scri);
		
		return "temp/boardWrite";
	}
	
	//게시판 글쓰기
	@RequestMapping(value="/boardWriteRes.do", method=RequestMethod.POST)
	public String boardWrite(HttpServletRequest request, Model model, BoardVo vo, MultipartFile boardfile) throws Exception {
		System.out.println(vo);
		int res = biz.boardWrite(vo);
		
		if(res>0) {	//insert 성공시
			int boardno = biz.getLastBoardSeq();	//insert한 게시글의 시퀀스번호 갖고옴
			BoardVo vo2 = biz.selectOneBoard(boardno);	//시퀀스 번호와 게시글 번호 일치하는지 확인
			
			//저장경로 생성
			String storagePath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\board\\"+vo2.getBoard_no());
			
			System.out.println("저장경로 : "+storagePath);
			
			//저장경로 정보 셋팅
			File folder = new File(storagePath);	
			
			//저장경로 디렉토리가 없을 경우 생성
			if(!folder.exists()) {
				try {
					folder.mkdir();	//storagePath의 경로 생성
					System.out.println("폴더가 생성되었습니다.");
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			//올릴려는 파일의 실제 이름을 fileName에 넣는다
			String fileName = boardfile.getOriginalFilename();
			
			//저장경로에 fileName까지 셋팅
			File insertImg = new File(storagePath+"\\"+fileName);
			
			//실제 가지고온 파일을 transerTo 메소드로 저장경로에 저장
			boardfile.transferTo(insertImg);
			
			//파일 이름 바꿔주기
			File imgFile = new File(storagePath+"\\boardImg.jpg");
			
			//실제로 가지고온 파일이름을 imgFile에서 셋팅해놓은 boardImg.jpg로 변경(복붙해서 이름 변경)
			insertImg.renameTo(imgFile);
			
			//원본파일(실제로 가지고온 파일 - insertImg) 삭제
			insertImg.delete();
			
			//상세 보기로 이동
			return "redirect:boardDetail.do?board_no="+boardno;
			
		} else {
			System.out.println("[ERROR] BOARD WRITE");
			
			return "rediect:boardWriteForm.do";
		}
		
	}
	
	//게시글 수정 폼
	@RequestMapping(value="/boardUpdateForm.do")
	public String boardUpdateForm(BoardVo vo, @ModelAttribute("scri") SearchCriteria scri ,Model model) throws Exception {
		model.addAttribute("detail", biz.selectOneBoard(vo.getBoard_no()));
		model.addAttribute("scri", scri);
		
		return "temp/boardUpdate";
	}
	
	//게시글 수정
	@RequestMapping(value="/boardUpdateRes.do", method=RequestMethod.POST)
	public String boardUpdate(HttpServletRequest request, Model model, BoardVo vo) throws IllegalStateException, IOException {
		System.out.println("aaaaaaaaaaaaa: "+vo);
		int res = biz.boardUpdate(vo);
		
		
		//수정하려는 파일의 원본 이름을 가져옴
//		String fileName = updateboardfile.getOriginalFilename();
		
/*		if(fileName == "") {
			//기존 파일과 같을 경우
			return "redirect:boardDetail_test.do?board_no="+vo.getBoard_no();
		} else {			
			String storagePath = request.getSession().getServletContext().getRealPath("resources\\images\\filemanager\\board\\"+vo.getBoard_no());
			
			
			File updateBoardImg = new File(storagePath+"\\"+fileName);
			
			updateboardfile.transferTo(updateBoardImg);
			
			//파일 이름 바꿔주기
			File imgFile = new File(storagePath+"\\boardImg.jpg");
			
			//실제로 가지고온 파일이름을 imgFile에서 셋팅해놓은 boardImg.jpg로 변경(복붙해서 이름 변경)
			updateBoardImg.renameTo(imgFile);
			
			//원본파일(실제로 가지고온 파일 - updateBoardImg) 삭제
			updateBoardImg.delete();
			*/
//			return "redirect:boardDetail_test.do?board_no="+vo.getBoard_no();
//		}
		if(res>0) {			
			return "redirect:boardDetail.do?board_no="+vo.getBoard_no();
		} else {
			return "redirect:boardUpdateForm.do?board_cate="+vo.getBoard_cate()+"&board_no="+vo.getBoard_no();
		}
	}
	
	//게시글 삭제
	@RequestMapping(value="/boardDelete.do")
	public String boardDelete(String board_cate, int board_no) {
		System.out.println("삭제할 게시글의 카테고리 : " + board_cate);
		
		int res = biz.boardDelete(board_no);
		if(res>0 && board_cate.equals("SH")) {
			return "redirect:boardListFree.do";							
		} else if(res>0 && board_cate.equals("EX")) {
			return "redirect:boardListExchange.do";						
		} else {
			return "redirect:boardDetail.do?board_no="+board_no;						
		}
	}
	
	//댓글 작성
	@RequestMapping(value="/boardComWrite.do")
	public String boardComWrite(CommentVo vo) {
		int res = biz.boardComWrite(vo);
		if(res>0) {
			return "redirect:boardDetail.do?board_no="+vo.getCom_pno();			
		} else {
			return "redirect:boardDetail.do?board_no="+vo.getCom_pno();			
		}
	}
	
	//댓글 수정
	@RequestMapping(value="/boardComUpdate.do")
	public String boardComUpdate(CommentVo vo, int com_pno) {
		int res = biz.boardComUpdate(vo);
		
		if(res>0) {
			return "redirect:boardDetail.do?board_no="+com_pno;			
		} else {
			return "redirect:boardDetail.do?board_no="+com_pno;			
		}
	}
	
	//댓글 삭제
	@RequestMapping(value="/boardComDelete.do")
	public String boardComDelete(int board_no, int com_no) {
		int res = biz.boardComDelete(com_no);
		
		if(res>0) {
			return "redirect:boardDetail.do?board_no="+board_no;			
		} else {
			return "redirect:boardDetail.do?board_no="+board_no;			
		}
	}
	
	// < 하나경 파트  끝 > 
	//------------------------------------------------------------------------------------------------------------------------------------
	
}
