package pes.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.ReplyVO;
import pes.mapper.ReplyMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {pes.config.RootConfig.class,
		pes.config.SecurityConfig.class})
@Log4j2
public class ReplyTests {
	@Setter(onMethod_ = { @Autowired })
	private ReplyMapper replymapper;

	Long rno = (long) 27;
	
	@Test
	public void test_insert() {
		ReplyVO rvo = new ReplyVO((long) 7,"new","new");
		replymapper.insert(rvo);
	}
	
	@Test
	public void test_read() {
		replymapper.read(rno);
	}
	
	@Test
	public void test_delete() {
		replymapper.delete(rno);;
	}
	
	@Test
	public void test_update() {
		ReplyVO rvo = new ReplyVO((long) 8,"change2","8");
		rvo.setRno(rno);
		replymapper.update(rvo);
	}
	
	@Test
	public void test_getList() {
		Long bno = (long) 8;
		replymapper.getList(bno);
	}
}
