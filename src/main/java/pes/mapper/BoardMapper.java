package pes.mapper;

import java.util.*;

import pes.domain.BoardVO;
import pes.domain.Criteria;

public interface BoardMapper {
	
	public void insert(BoardVO bvo);
	
	public List<BoardVO> select_all();

	public BoardVO get_board(Long bvo);

	public void modify_board(BoardVO bvo);

	public boolean board_remove(Long bno);

	public List<BoardVO> getListWithPaging(Criteria criteria);

	public int getTotalCount(Criteria criteria);
}
