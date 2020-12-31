package com.ssmAdmin.util;

import com.alibaba.fastjson.JSON;
import com.zbjr.log.LogMgr;

import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class ResultUtil {

    /**
     * 私有化构造器
     */
    private ResultUtil(){}

    /**
     * 使用response输出JSON
     * @Author Sans
     * @CreateTime 2019/9/28 11:23
     * @Param  resultMap 数据
     * @Return void
     */
    public static void responseJson(ServletResponse response, Map<String,Object> map){
        PrintWriter out = null;
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            out = response.getWriter();
            out.println(JSON.toJSONString(map));
            out.flush();
        } catch (Exception e) {
            LogMgr.writeErrorLog(e);
        }finally{
            if(out!=null){
                out.flush();
                out.close();
            }
        }
    }
    /**
     * 返回成功示例
     * @Author Sans
     * @CreateTime 2019/9/28 11:29
     * @Param  resultMap  返回数据MAP
     * @Return Map<String,Object> 返回数据MAP
     */
    public static Map<String, Object> resultSuccess(){
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg","操作成功");
        resultMap.put("code", 200);
        return resultMap;
    }

    public static Map<String, Object> resultSuccess(Map<String, Object> resultMap){
        resultMap.put("msg","操作成功");
        resultMap.put("code", 200);
        return resultMap;
    }
    /**
     * 返回失败示例
     * @Author Sans
     * @CreateTime 2019/9/28 11:31
     * @Param  resultMap  返回数据MAP
     * @Return Map<String,Object> 返回数据MAP
     */
    public static Map<String, Object> resultError(String msg){
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg",msg);
        resultMap.put("code",500);
        return resultMap;
    }
    public static Map<String, Object> resultError(Map<String, Object> resultMap){
        resultMap.put("msg","操作失败");
        resultMap.put("code",500);
        return resultMap;
    }
    /**
     * 通用示例
     * @Author Sans
     * @CreateTime 2019/9/28 11:35
     * @Param  code 信息码
     * @Param  msg  信息
     * @Return Map<String,Object> 返回数据MAP
     */
    public static Map<String, Object> resultCode(Integer code,String msg){
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg",msg);
        resultMap.put("code",code);
        return resultMap;
    }

}