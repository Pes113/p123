package pes.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp redate;
	private Timestamp updatedate;
	
	private List<BoardAttachVO> attachList;	// 여러개의 파일 저장을 위해 LIST 선언
	
	public BoardVO() {
		
	}
	
	public BoardVO(String title, String content, String writer) {
		this.title = title;
		this.content = content;
		this.writer = writer;
	}
}
