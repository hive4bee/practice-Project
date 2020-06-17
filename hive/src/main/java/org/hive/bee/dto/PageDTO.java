package org.hive.bee.dto;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;

	private int total;
	private StartDTO startDTO;
	public PageDTO(StartDTO startDTO, int total) {
		this.startDTO = startDTO;
	    this.total = total;
	    
	    this.endPage = (int) (Math.ceil(startDTO.getPage() / 10.0)) * 10;

	    this.startPage = this.endPage - 9;

	    int realEnd = (int) (Math.ceil((total * 1.0) / 10));

	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	}
}
