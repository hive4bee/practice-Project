package org.hive.bee.dto;

import lombok.Data;

@Data
public class StartDTO {
	private int page;
	private int startRecord;
	private int amount;
	public StartDTO() {
		this(1, 10);
	}
	public StartDTO(int page, int amount) {
		this.page=page;
		this.amount=amount;
		this.startRecord=(page-1)*amount;
	}
}
