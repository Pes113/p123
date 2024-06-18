package pes.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private Timestamp regdate;
	private Timestamp updatedate;
	
	public ReplyVO() {
		
	}
	
	public ReplyVO(Long bno, String reply, String replyer) {
		this.bno = bno;
		this.reply = reply;
		this.replyer = replyer;
	}
}
