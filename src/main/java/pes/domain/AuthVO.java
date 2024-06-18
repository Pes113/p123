package pes.domain;

import lombok.Data;

@Data
public class AuthVO {
	private String user_id;
	private String user_name;
	
	public AuthVO () {
		
	}
	
	public AuthVO (String user_id, String user_name) {
		this.user_id = user_id;
		this.user_name = user_name;
	}
}
