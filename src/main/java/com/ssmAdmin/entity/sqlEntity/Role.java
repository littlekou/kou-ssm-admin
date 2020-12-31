package com.ssmAdmin.entity.sqlEntity;

import lombok.Data;

import java.util.Date;

@Data
public class Role {
    private Long roleId;

    private String roleName;

    private Date updatedTime;

    private Date createdTime;

    private Long createdBy;

    private Long updatedBy;

    private Long isEffective;

}