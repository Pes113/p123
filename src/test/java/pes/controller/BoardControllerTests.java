package pes.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.java.Log;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {pes.config.RootConfig.class,
		pes.config.ServletConfig.class,
		pes.config.SecurityConfig.class})
@WebAppConfiguration
@Log
public class BoardControllerTests {
	@Setter(onMethod_ = { @Autowired })
	private WebApplicationContext context;
	
	private MockMvc mockmvc;
	
	@Before
	public void setup() {
		mockmvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void test1() throws Exception {
//		MultiValueMap<String, String> info = new LinkedMultiValueMap<>();
//		info.add("title", "title");
//		info.add("content", "content");
//		info.add("writer", "1234");
//		mockmvc.perform(MockMvcRequestBuilders.post("/board/register")
//				.params(info))
//		.andReturn().getModelAndView().getViewName();
		mockmvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "title9").param("content", "content9").param("writer", "writer9"))
		.andReturn().getModelAndView().getViewName();
	}

}
