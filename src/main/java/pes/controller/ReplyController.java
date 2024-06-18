package pes.controller;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import pes.domain.BoardVO;
import pes.domain.Criteria;
import pes.domain.PageDTO;
import pes.domain.ReplyPageDTO;
import pes.domain.ReplyVO;
import pes.service.ReplyService;

@RestController
@RequestMapping("/replies/*")
@AllArgsConstructor
@Log4j2
public class ReplyController {
	private ReplyService service;
	
	@GetMapping(value = "/page/{bno}",
			produces = { MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno) {
		List<ReplyVO> list = service.get_list(bno);
		log.info("\n list : " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/new", consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public void register(@RequestBody List<ReplyVO> list) {
		for(ReplyVO rvo : list)
			service.register(rvo);
	}
	
	@PostMapping(value = "/new2", consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register2(@RequestBody ReplyVO rvo) {
		return service.register2(rvo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{rno}",
			produces = { MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PatchMapping(value = "/{rno}", consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody ReplyVO rvo
			,@PathVariable("rno") Long rno) {
		return service.modify(rvo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> delete(@PathVariable("rno") Long rno) {
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/page/{bno}/{page}",
			produces = { MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReplyPageDTO> get_list_function(Model model,@PathVariable("bno") Long bno,@PathVariable("page") int page) {
		Criteria criteria = new Criteria(page,5);
		ReplyPageDTO reply_page = service.get_List(criteria, bno);
		return new ResponseEntity<>(reply_page, HttpStatus.OK);
	}
	
	@GetMapping(value = "/cnt",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> get_reply_cnt(@RequestParam(value="list[]") List<Long> list) {
		JsonObject jObj = new JsonObject();
		for(Long bno:list) {
			jObj.addProperty(String.valueOf(bno), service.get_reply_cnt(bno));
		}
		return new ResponseEntity<>(jObj.toString(), HttpStatus.OK);
	}
}
