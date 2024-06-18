package pes.domain;

import java.util.*;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor //기본 생성자를 만들어줌
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
	
	public ReplyPageDTO(int replyCnt, List<ReplyVO> list) {
		this.replyCnt = replyCnt;
		this.list = list;
	}
}
