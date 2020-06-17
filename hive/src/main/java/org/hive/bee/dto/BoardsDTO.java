package org.hive.bee.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardsDTO {
	private int fno;
	private String mid;
	private String subject;
	private String content;
	private int hit;
	private int replycnt;
	private Date f_indate;
}
