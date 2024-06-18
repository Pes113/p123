package pes.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.BoardVO;
import pes.service.BoardService;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {pes.config.RootConfig.class ,
		pes.config.SecurityConfig.class})
@Log4j2
public class BoardServiceTests {
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardservice;
	
	@Test
	public void test_board_register() {
//		for(int i = 100; i < 1000; i++) {
//			BoardVO bvo = new BoardVO(i+"",i+"","2@2");
//			boardservice.register_board(bvo);
//		}
		BoardVO bvo = new BoardVO("n","n","2@2");
		boardservice.register_board(bvo);
	}
	
	@Test
	public void test_board_select() {
		List<BoardVO> bvo = boardservice.get_List();
		for(BoardVO vo : bvo) {
			System.out.println("=====================================");
			System.out.println(vo.getContent());
			System.out.println(vo.getTitle());
			System.out.println(vo.getWriter());
			System.out.println(vo.getBno());
			System.out.println(vo.getRedate());
			System.out.println(vo.getUpdatedate());
			System.out.println("=====================================");
		}
	}
}
