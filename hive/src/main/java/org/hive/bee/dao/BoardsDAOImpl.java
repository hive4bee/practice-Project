package org.hive.bee.dao;

import java.util.List;

import org.hive.bee.dto.BoardsDTO;
import org.hive.bee.dto.StartDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class BoardsDAOImpl implements BoardsDAO {
	@Setter(onMethod_ = @Autowired)
	private SqlSessionTemplate session;
	
	public static String namespace="BoardsMapper";
	
	@Override
	public List<BoardsDTO> boardsList(StartDTO startDTO) throws Exception {
		log.info("startDTO : " + startDTO);
		return session.selectList(namespace+".boardsList", startDTO);
	}
	
	@Override
	public int getTotal() throws Exception {
		return session.selectOne(namespace+".getTotal");
	}
}
