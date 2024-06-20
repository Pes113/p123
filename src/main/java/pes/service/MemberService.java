package pes.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.AuthVO;
import pes.domain.MemberVO;
import pes.mapper.MemberMapper;

@Service
@Log4j2
public class MemberService{
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper membermapper;

	@Setter(onMethod_ = { @Autowired })
	private PasswordEncoder pwencoder;
	
	public int modify_sign(MemberVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		System.out.println(vo);
		return membermapper.modifyMember(vo);
	}
	
	public void signup(MemberVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		membermapper.insertMember(vo);
	}
	
	public int delete_sign(String user_id) {
		return membermapper.deleteMember(user_id);
	}
	
	public MemberVO select_Id(String user_id) {
		return membermapper.selectMemberByUserid(user_id);
	}
	
	public AuthVO authenticate(MemberVO vo) throws Exception {
		MemberVO re = membermapper.selectMemberByUserid(vo.getUser_id());
		if(re == null) {
			throw new Exception("id");
		}
		else if(!pwencoder.matches(vo.getUser_pw(), re.getUser_pw())) {
			throw new Exception("pw");
		}
		AuthVO avo = new AuthVO(re.getUser_id(), re.getUser_name());
		return avo;
	}

}
