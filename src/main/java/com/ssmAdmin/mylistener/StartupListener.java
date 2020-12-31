package com.ssmAdmin.mylistener;

import com.alibaba.fastjson.JSONObject;
import org.opencv.core.Core;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class StartupListener implements ApplicationContextAware {


    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        try {
            System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        } catch (UnsatisfiedLinkError ignore) {
            //使用spring-dev-tools之后，上下文会被加载多次，所以这里会抛出链接库已被加载的异常。
            //有这个异常则说明链接库已被加载，直接吞掉异常即可
        }
    }



}
