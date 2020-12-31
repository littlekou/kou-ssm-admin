package com.ssmAdmin.entity.sqlEntity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class Member {

    private Long id;
    private String cname;
    private String loginName;
    private Integer roleId;
    private String password;
    private String rate;
	private String token;
    private Integer status;
    private String freezeBalance;
    private String balance;
    private Date addTime;
    private Date modifyTime;
    private Long createBy;
    private Long agentId;
    private String ips;
    private String payPassword;
    private String googleSecretKey;
    private String phone;

}
