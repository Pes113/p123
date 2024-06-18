package pes.mapper;

import java.util.*;

import pes.domain.MemberVO;

public interface MemberMapper {
	
	public void insertMember(MemberVO vo);
	
	public MemberVO selectMemberByUserid(String user_id);
	
	public List<MemberVO> selectMember();
	
	public void updateMember(MemberVO vo, int user_id);
	
	public void deleteMember(int user_id);
	
}
