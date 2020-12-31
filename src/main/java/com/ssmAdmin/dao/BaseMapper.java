package com.ssmAdmin.dao;


import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
public class BaseMapper<T> extends SqlSessionDaoSupport{
	private Class<T> entityClass;

	/**
	 * Autowired 必须要有
	 */
	@Autowired
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory){

		super.setSqlSessionFactory(sqlSessionFactory);
	}
	/**
	 * 通过反射获取子类确定的泛型类
	 */
	public BaseMapper() {
		Type[] params = ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments();
		entityClass = (Class) params[0];
	}
	/**
	 * 分页条件查询
	 * @param mapperName
	 * @param map
	 * @return
	 */
	public List<T> getAllByPage(String mapperName,Map<String, Object> map){
		List<T> sysUserList = getSqlSession().selectList(mapperName,map);
		return sysUserList;
	}
	/**
	 * 条件查询总数
	 * @param mapperName
	 * @param map
	 * @return
	 */
	public int getCountByPage(String mapperName,Map<String, Object> map){
		int count = (Integer) getSqlSession().selectOne(mapperName, map);
		return count;
	}
	
	public int getCount(String mapperName,T obj){
		return (Integer)getSqlSession().selectOne(mapperName,obj);
	}
	/**
	 * 保存对象信息
	 * @param mapperName
	 * @param obj
	 * @return
	 */
	public int saveInfo(String mapperName,T obj){
		int num=getSqlSession().insert(mapperName, obj);
		return num;
	}
	
	/**
	 * 查询全部
	 * @param mapperName
	 * @return
	 */
	public List<T> getAllInfo(String mapperName){
		List<T> sysUserList = getSqlSession().selectList(mapperName);
		return sysUserList;
	}
	/**
	 * 根据ID查询
	 * @param mapperName
	 * @param id
	 * @return
	 */
	public T getInfoById(String mapperName,Long id){
		return (T)getSqlSession().selectOne(mapperName, id);
	}
	
	public T getInfoById(String mapperName,Object id){
		return (T)getSqlSession().selectOne(mapperName, id);
	}
	/**
	 * 根据条件查询
	 * @param mapperName
	 * @param map
	 * @return
	 */
	public List<T> getInfoById(String mapperName,Map<String,Object> map){
		return getSqlSession().selectList(mapperName, map);
	}
	
	
	/**
	 * 根据ID删除
	 * @param mapperName
	 * @param id
	 * @return
	 */
	public int delById(String mapperName,Long id){
		return getSqlSession().delete(mapperName, id);
	}
	
	/**
	 * 根据ID删除
	 * @param mapperName
	 * @param id
	 * @return
	 */
	public int delById(String mapperName,Object id){
		return getSqlSession().delete(mapperName, id);
	}
	
	/**
	 * 根据条件删除
	 * @param mapperName
	 * @param map
	 * @return
	 */
	public int delByIf(String mapperName,Map<String,Object> map){
		return getSqlSession().delete(mapperName, map);
	}
	
	/**
	 * 修改对象
	 * @param mapperName
	 * @param id
	 * @return
	 */
	public int updateById(String mapperName,T obj){
		return getSqlSession().update(mapperName, obj);
	}
	
	
	/**
	 * 根据条件修改对象
	 * @param mapperName
	 * @param id
	 * @return
	 */
	public int updateByIf(String mapperName,Map<String,Object> map){
		return getSqlSession().update(mapperName,map);
	}
	
	
}