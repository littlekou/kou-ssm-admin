package com.ssmAdmin.service.impl;

import com.ssmAdmin.dao.MemberDao;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member getMemberByMobile(String mobile, Integer status) {
		return memberDao.getMemberByMobile(mobile,status);
	}

	@Override
	public Member getMemberById(Long id) {
		return memberDao.getMemberById(id);
	}

	@Override
	public void updateMember(Member member) {
		memberDao.updateMember(member);
	}

	@Override
	public List<Member> getMerchantList(Map<String, Object> params) {
		return memberDao.getMerchantList(params);
	}

	@Override
	public String getParameterByParam(String param1, String param2, String param3) {
		return memberDao.getParameterByParam(param1,param2,param3);
	}

	@Override
	public void updateMemberParam(String param1, String param2, Long id) {
		memberDao.updateMemberParam(param1,param2,id);
	}

	@Override
	public void insertMember(Member member) {
		memberDao.insertMember(member);
	}

	@Override
	public void deleteUser(Long id) {
		memberDao.deleteUser(id);
	}
}

