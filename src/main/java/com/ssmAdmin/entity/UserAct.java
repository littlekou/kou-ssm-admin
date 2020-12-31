package com.ssmAdmin.entity;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class UserAct extends AjaxPage {

	private Integer Id;
	private String userName;
	private String action;
	private String operation;
	private String info;
	private String detailInfo;
	private Timestamp createTime;
	
}
