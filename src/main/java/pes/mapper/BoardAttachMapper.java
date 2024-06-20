package pes.mapper;

import java.util.List;

import pes.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);

	public List<BoardAttachVO> getAttachList(Long bno);
	
	public void remove(Long bno);
	
	public List<BoardAttachVO> getOldFiles(String uploadpath);
}
