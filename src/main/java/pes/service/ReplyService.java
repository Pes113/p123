package pes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import pes.domain.Criteria;
import pes.domain.ReplyPageDTO;
import pes.domain.ReplyVO;
import pes.mapper.ReplyMapper;

@Service
@Log4j2
public class ReplyService {
	@Setter(onMethod_ = { @Autowired })
	private ReplyMapper replymapper;
	
	public void register(ReplyVO rvo) {
		replymapper.insert(rvo);
	}
	
	public int register2(ReplyVO rvo) {
		return replymapper.insert2(rvo);
	}
	
	public ReplyVO get(Long rno) {
		return replymapper.read(rno);
	}
	
	public int remove(Long rno) {
		return replymapper.delete(rno);
	}

	public int modify(ReplyVO rvo) {
		return replymapper.update(rvo);
	}
	
	public List<ReplyVO> get_list(Long rno) {
		return replymapper.getList(rno);
	}

	public ReplyPageDTO get_List(Criteria criteria, Long bno) {
		int replyCnt = replymapper.getTotalCount(bno);
		List<ReplyVO> list  = replymapper.getListWithPaging(criteria, bno);
		return new ReplyPageDTO(replyCnt, list);
	}
	
	public int get_reply_cnt(Long bno) {
		return replymapper.getTotalCount(bno);
	}
}
