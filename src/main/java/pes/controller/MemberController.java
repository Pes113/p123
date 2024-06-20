package pes.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.java.Log;
import pes.domain.AuthVO;
import pes.domain.BoardAttachVO;
import pes.domain.MemberVO;
import pes.service.BoardService;
import pes.service.MemberService;

@Controller
@RequestMapping("/member/*")
@Log
public class MemberController {
	@Setter(onMethod_ = { @Autowired })
	private MemberService memberService;

	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;
	
	@RequestMapping("/")
	public String main() {
		return "/home";
	}
	
	@GetMapping("/example")
	public String r_example() {
		return "/member/example";
	}
	
	@GetMapping("/login")
	public String getLogin() {
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String PostLogin(MemberVO vo, HttpSession session ,RedirectAttributes rttr) {
		AuthVO avo = new AuthVO();
		String userURI;
		try {
			avo = memberService.authenticate(vo);
			session.setAttribute("auth", avo);
			userURI = (String)session.getAttribute("userURI");
			if(userURI != null) {
				return "redirect:"+userURI;
			}
		} catch (Exception e) {
			rttr.addFlashAttribute("error", e.getMessage());
			rttr.addFlashAttribute("vo", vo);
			return "redirect:/member/login";
		}
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String getLogout(HttpSession session, RedirectAttributes rttr) {
		session.removeAttribute("auth"); 
		rttr.addFlashAttribute("msg", "logout");
		return "/home";
	}
	
//	@PostMapping("/logout")
//	public String postLogout(HttpSession session ,RedirectAttributes rttr) {
//		session.removeAttribute("auth"); 
//		return "/home";
//	}
	
	@GetMapping("/signup")
	public String getSignup() {
		return "/member/signup";
	}
	
	
	@PostMapping("/signup")
	public String setSignup(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		String pw = vo.getUser_pw();
		// signup 함수에서 pw 값이 암호화 되었기 때문에, DB에서 다시 호출하면 원래 값을 알 수 없음
		memberService.signup(vo);
		vo.setUser_pw(pw);
		try {
			AuthVO avo = memberService.authenticate(vo);
			session.setAttribute("auth", avo);
		} catch (Exception e) {
			rttr.addFlashAttribute("error",e.getMessage());
			rttr.addFlashAttribute("vo", vo);
			return "redirect:/member/login";
		}
		return "redirect:/";
	}
	
	@GetMapping("/mypage")
	public String get_mypage() {
		return "member/mypage";
	}
	
	@PostMapping("/mypage")
	public String modify_mypage(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		String user_id = ((AuthVO) session.getAttribute("auth")).getUser_id();
		MemberVO prev_vo = memberService.select_Id(user_id);
		if(vo.getUser_name() == "") {	}
		else {	//	이름 변경
			prev_vo.setUser_name(vo.getUser_name());
		}
		if(vo.getLocation() == "-선택-") {	}
		else {	//	지역 변경
			prev_vo.setUser_name(vo.getUser_name());
		}
		prev_vo.setUser_pw(vo.getUser_pw());
		memberService.modify_sign(prev_vo);
		session.removeAttribute("auth");
		return "redirect:/";
	}
	
	@PostMapping("/remove")
	public String sign_remove( HttpSession session, RedirectAttributes rttr) {
		AuthVO avo = (AuthVO)session.getAttribute("auth");
		session.removeAttribute("auth");
		boardService.user_board_remove(avo.getUser_id());
		memberService.delete_sign(avo.getUser_id());
		return "/home";
	}
}
