package pes.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import pes.domain.BoardAttachVO;
import pes.domain.BoardVO;
import pes.domain.Criteria;
import pes.mapper.BoardAttachMapper;
import pes.mapper.BoardMapper;

@Service
public class BoardService {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper boardmapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachmapper;
	
	/*
	 * @Transactional public void register(BoardVO vo) { boardmapper.insert(vo);
	 * 
	 * List<BoardAttachVO> list = vo.getAttachList(); if(list==null ||
	 * list.isEmpty()) { return; } for(BoardAttachVO attach : list) {
	 * attach.setBno(vo.getBno()); attachmapper.insert(attach); } }
	 */
	
	@Transactional
	public void insert_board(BoardVO bvo) {
		boardmapper.insert(bvo);
		
		List<BoardAttachVO> list = bvo.getAttachList();
		if(list==null || list.isEmpty()) {
			return;
		} for(BoardAttachVO attach : list) {
			attach.setBno(bvo.getBno());
			attachmapper.insert(attach);
		}
	}
	
	public void register_board(BoardVO bvo) {
		boardmapper.insert(bvo);
	}
	
	public List<BoardVO> get_List() {
		return boardmapper.select_all();
	}
	
	public BoardVO get_board(Long bvo) {
		return boardmapper.get_board(bvo);
	}
	
	@Transactional
	public List<BoardAttachVO> modify_board(BoardVO bvo) {
		boardmapper.modify_board(bvo);
		attachmapper.remove(bvo.getBno());
		
		List<BoardAttachVO> list = bvo.getAttachList();
		if(list==null || list.isEmpty()) {
			return null;
		} for(BoardAttachVO attach : list) {
			attach.setBno(bvo.getBno());
			attachmapper.insert(attach);
		}
		
		return list;
	}

	@Transactional
	public boolean board_remove(Long bno) {
		attachmapper.remove(bno);
		return boardmapper.board_remove(bno);
	}

	public List<BoardVO> get_List(Criteria criteria) {
		return boardmapper.getListWithPaging(criteria);
	}
	
	public int get_Total(Criteria criteria) {
		return boardmapper.getTotalCount(criteria);
	}

	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachmapper.getAttachList(bno);
	}

	public int user_board_remove(String user_id) {
		return boardmapper.user_board_delete(user_id);
	}
}
