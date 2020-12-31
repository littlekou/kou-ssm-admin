package com.ssmAdmin.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;
@Data
public class ScriptPage {
	private List rows = new ArrayList();
	private Integer total = -1;
	private String msg;
}
