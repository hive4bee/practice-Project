package org.hive.bee;

import java.util.List;

import org.hive.bee.dto.BoardsDTO;
import org.hive.bee.dto.PageDTO;
import org.hive.bee.dto.StartDTO;
import org.hive.bee.service.BoardsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/boards/*")
@AllArgsConstructor
public class BoardsController {
	@Setter(onMethod_ = @Autowired)
	private BoardsService service;
	
	@GetMapping("/list")
	public void boardsList(StartDTO startDTO, Model model) throws Exception {
		log.info("==========================");
		log.info("startDTO : " + startDTO);
		log.info("==========================");
		List<BoardsDTO> list = service.boardsList(startDTO);
		log.info("==========================");
		model.addAttribute("list", list);
		log.info("==========================");
		int total = service.getTotal();
		model.addAttribute("pageMaker", new PageDTO(startDTO, total));
	}
}
