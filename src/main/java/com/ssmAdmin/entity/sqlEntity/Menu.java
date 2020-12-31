package com.ssmAdmin.entity.sqlEntity;

import lombok.Data;

import java.util.Date;

@Data
public class Menu {
    private Long menuId;

    private String menuName;

    private String menuAction;

    private String menuSeq;

    private Long pid;

    private Date createdTime;

    private Date updatedTime;

    private Long isEffective;

    private Integer menuType;

}