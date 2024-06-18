package pes.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.BoardVO;
import pes.mapper.BoardMapper;
import pes.service.BoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {pes.config.RootConfig.class ,
		pes.config.SecurityConfig.class})
@Log4j2
public class BoardTests {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper boardmapper;
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardservice;
	
	@Test
	public void test_board_insert() {
		BoardVO bvo = new BoardVO("제목","내용","작성자");
		boardmapper.insert(bvo);
	}
	
	@Test
	public void test_board_register() {
		BoardVO bvo = new BoardVO("제목","내용","작성자");
		boardservice.register_board(bvo);
	}
}
