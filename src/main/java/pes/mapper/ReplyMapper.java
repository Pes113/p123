package pes.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;

import pes.domain.Criteria;
import pes.domain.ReplyVO;

public interface ReplyMapper {
	public void insert(ReplyVO rvo);

	public int insert2(ReplyVO rvo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO rvo);
	
	public List<ReplyVO> getList(Long bno);
	
	public List<ReplyVO> getListWithPaging(@Param("criteria") Criteria criteria
			,@Param("bno") Long bno);

	public int getTotalCount(Long bno);
}
