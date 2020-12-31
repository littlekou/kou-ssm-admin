package com.ssmAdmin.service;

import com.ssmAdmin.entity.sqlEntity.Member;

import java.util.List;
import java.util.Map;


public interface MemberService {
	Member getMemberByMobile(String mobile,Integer status);

	Member getMemberById(Long id);

	void updateMember(Member member);

	List<Member> getMerchantList(Map<String, Object> params);

	String getParameterByParam(String param1, String param2,String param3);

	void updateMemberParam(String param1, String param2,Long id);

	void insertMember(Member member);

	void deleteUser(Long id);

}

