package pes.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.MemberVO;
import pes.mapper.MemberMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {pes.config.RootConfig.class,
		pes.config.SecurityConfig.class})
@Log4j2
public class MemberTests {
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper membermapper;
	
	@Test
	public void testMemberInsert() {
		MemberVO vo = new MemberVO("8","박","1234","서울","남성");
		membermapper.insertMember(vo);
	}
	
}
