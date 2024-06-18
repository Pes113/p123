package pes.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import pes.domain.AttachFileDTO;

@RestController
@Log4j2
public class UploadController {
	
	@PostMapping(value = "/uploadFileAjax",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachFileDTO>> uploadfile(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String upload_folder = "C:\\Users\\dmstk\\upload";
		
		String upload_folder_path = upload_polder_file_path();
		File upload_path = new File(upload_folder, upload_folder_path);
		
		if(!upload_path.exists()) {
			upload_path.mkdirs();
		}
		
		for(MultipartFile multi_file : uploadFile) {
			AttachFileDTO afdto = new AttachFileDTO();
			String file_name = multi_file.getOriginalFilename();
			file_name = file_name.substring(file_name.lastIndexOf("\\")+1);
			log.info("file name : "+file_name);
			afdto.setFilename(file_name);
			UUID uid = UUID.randomUUID();
			file_name = uid.toString() + "_" + file_name;
			try {
				File save_file = new File(upload_folder_path, file_name);
				multi_file.transferTo(save_file);
				afdto.setUuid(uid.toString());
				afdto.setUploadpath(upload_folder_path);
				if(check_image_type(save_file)) {
					afdto.setImage(true);
					FileOutputStream thumb_mail = new FileOutputStream(new File(upload_path, "s_" + file_name));
					Thumbnailator.createThumbnail(multi_file.getInputStream(), thumb_mail, 100, 100);
					thumb_mail.close();
				}
				list.add(afdto);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
 		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	private String upload_polder_file_path() {
		SimpleDateFormat simple_date = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String string_date = simple_date.format(date);
		String str = string_date.replace("-", File.separator);
		return str;
	}
	
	private boolean check_image_type(File save_file) {
		boolean result = false;
		try {
			String contentType = Files.probeContentType(save_file.toPath());
			System.out.println("c-=================" + contentType);
			result = contentType != null && contentType.startsWith("image");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value = "/display",
			produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> getFile(String filename) {
		ResponseEntity<byte[]> result = null;
		File file = new File("C:\\Users\\dmstk\\upload\\" + filename);
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<> (FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	  @DeleteMapping(value = "/deleteFile", consumes = "application/json")
	  public ResponseEntity<String> deleteFile(@RequestBody Map<String, String> param) {
		  System.out.println(param.keySet());
		  System.out.println(param.get("filename"));
		  //System.out.println(param.get("type"));
			try {
				String filename = URLDecoder.decode(param.get("filename"), "UTF-8");
				String file_path = "C:\\Users\\dmstk\\upload\\" + filename;
				String s_file_path = file_path.replaceFirst("s_", "");
				File file = new File(file_path);
				File s_file = new File(s_file_path);
				file.delete();
				s_file.delete();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		  return new ResponseEntity<>("delete", HttpStatus.OK);
	  }
	  
	  @GetMapping("/pdfviewer")
	  public ResponseEntity<Resource> pdfFileView(@RequestParam("filename") String filename) {
		  try {
			  String encodeFileName = URLEncoder.encode(filename, StandardCharsets.UTF_8.toString()).replaceAll("\\+",  "%20");
			  Resource resource = new FileSystemResource("C:\\Users\\dmstk\\upload\\" + filename);
			  File file = resource.getFile();
			  return ResponseEntity.ok()
					  .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + encodeFileName +"\"")
					  .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()))
					  .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PDF.toString())
					  .body(resource);
		  }
		  catch(FileNotFoundException e) {
			  e.printStackTrace();
			  return ResponseEntity.badRequest().body(null);
		  }
		  catch(IOException e) {
			  e.printStackTrace();
			  return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		  }
	  }
	  
	  @GetMapping(value = "/downloadFile", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	  public ResponseEntity<Resource> pdfFileDownload(@RequestHeader("User-Agent") String user_agent, @RequestParam("filename") String filename) {
		  Resource resource = new FileSystemResource("C:\\Users\\dmstk\\upload\\" + filename);
		  if(resource.exists() == false) {
			  return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		  }
		  String resource_name = resource.getFilename();
		  
		  String resource_original_name = resource_name.substring(resource_name.indexOf("_") + 1);
		  HttpHeaders headers = new HttpHeaders();
		  try {
			  boolean check_ie = (user_agent.indexOf("MSIE") > -1 || user_agent.indexOf("Trident") > -1);
			  String download_name = null;
			  if(check_ie) {
				  download_name = URLEncoder.encode(resource_original_name, "UTF8").replaceAll("\\+",  " ");
			  }
			  else {
				  if(user_agent.contains("Edge")) {
					  download_name = resource_original_name;
				  }
				  else {
					  download_name = new String(resource_original_name.getBytes("UTF-8"), "ISO-8859-1");
				  }
			  }
			  headers.add("Content-Disposition", "attachment; filename="+download_name);
		  }
		  catch(UnsupportedEncodingException e) {
			  e.printStackTrace();
		  }
		  return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	  }
}
