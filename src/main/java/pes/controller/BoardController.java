package pes.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.java.Log;
import pes.domain.BoardAttachVO;
import pes.domain.BoardVO;
import pes.domain.Criteria;
import pes.domain.PageDTO;
import pes.service.BoardService;

@Controller
@RequestMapping("/board/*")
@Log
public class BoardController {
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;
	
	@GetMapping("/register")
	public String get_register() {
		return "/board/register";
	}
	
	@GetMapping("/list")
	public String get_list(Model model, Criteria criteria) {
		get_list_function(model, criteria);
		return "board/list";
	}
	
	@PostMapping("/list")
	public String post_list(Model model, BoardVO bvo, Criteria criteria) {
		boardService.insert_board(bvo);
		get_list_function(model, criteria);
		return "board/list";
	}
	
	@GetMapping("/get")
	public String get_get(Model model, Long bno, Criteria criteria) {
		model.addAttribute("board", boardService.get_board(bno));
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String get_modify(Model model, Long bno, Criteria criteria) {
		model.addAttribute("board", boardService.get_board(bno));
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String post_modify(Model model, BoardVO bvo, Criteria criteria, RedirectAttributes rttr) {
		List<BoardAttachVO> list = boardService.modify_board(bvo);
		
		get_list_function(model, criteria);
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String get_remove(Model model, Long bno, Criteria criteria, RedirectAttributes rttr) {
		boardService.board_remove(bno);
		List<BoardAttachVO> attachList = boardService.getAttachList(bno);
		if(boardService.board_remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		get_list_function(model, criteria);
		 return "redirect:/board/list" + criteria.getListLink();
	}
	
	public void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		for(BoardAttachVO attach : attachList) {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadpath() + "\\" + attach.getUuid() + "_" + attach.getFilename());
				Files.delete(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadpath() + "\\s_" + attach.getUuid() + "_" + attach.getFilename());
					Files.delete(thumbNail);
				}
			}catch (Exception e) {
				System.out.println("delete file error" + e.getMessage());
			}
		}
	}

	void get_list_function(Model model, Criteria criteria) {
		List<BoardVO> list = boardService.get_List(criteria);
		model.addAttribute("list", list);
		int total = boardService.get_Total(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		log.info(list + " total : " + total + "   " + criteria.getListLink());
	}
	
	@ResponseBody
	@GetMapping(value="/getAttachList/{bno}",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BoardAttachVO>> get_attachList(@PathVariable("bno") Long bno) {
		List<BoardAttachVO> list = boardService.getAttachList(bno);
		log.info("list:" + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}
