package pes.service;

import java.util.*;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j2;
import pes.domain.ImageVO;

@Service
@Log4j2
public class ImageService {
	public List<ImageVO> getImageList(){
		List<ImageVO> list = new ArrayList<>();
		for(int i = 0; i < 11; i++) {
			ImageVO ivo = new ImageVO("/resources/img/its"+i+".jpg","이츠"+i,""+i);
			list.add(ivo);
		}
		return list;
	}
}
