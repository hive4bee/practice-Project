package org.hive.bee.service;

import java.util.List;

import org.hive.bee.dao.BoardsDAO;
import org.hive.bee.dto.BoardsDTO;
import org.hive.bee.dto.StartDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardsServiceImpl implements BoardsService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardsDAO dao;
	
	@Override
	public List<BoardsDTO> boardsList(StartDTO startDTO) throws Exception {
		log.info("startDTO : " +startDTO);
		return dao.boardsList(startDTO);
	}
	
	@Override
	public int getTotal() throws Exception {
		return dao.getTotal();
	}
}
