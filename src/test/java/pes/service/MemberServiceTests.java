package pes.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.config.*;
import pes.domain.MemberVO;
import pes.service.MemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class, SecurityConfig.class})
@Log4j2
public class MemberServiceTests {
	@Setter(onMethod_ = { @Autowired })
	private MemberService memberservice;

	@Test
	public void testMemberInsert() {
		MemberVO vo = new MemberVO("user7","s","1234","대구","남성");
		memberservice.signup(vo);
	}
	
}
