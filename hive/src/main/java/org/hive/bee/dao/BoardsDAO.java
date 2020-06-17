package org.hive.bee.dao;

import java.util.List;

import org.hive.bee.dto.BoardsDTO;
import org.hive.bee.dto.StartDTO;

public interface BoardsDAO {
	public List<BoardsDTO> boardsList(StartDTO startDTO) throws Exception;

	public int getTotal() throws Exception;
}
