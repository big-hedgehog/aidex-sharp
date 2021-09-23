package com.aidex;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class AiDexApplication
{
    public static void main(String[] args)
    {
        System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(AiDexApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  AiDex启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                "____  ______      __     ___        __   ____   _\n" +
                "    /  \\    (_    _) |    \\  \\    ___) \\  \\  /  / \n" +
                "   /    \\     |  |   |     |  |  (__    \\  \\/  /  \n" +
                "  /  ()  \\    |  |   |     |  |   __)    >    <   \n" +
                " |   __   |  _|  |_  |     |  |  (___   /  /\\  \\  \n" +
                " |  (__)  |_(      )_|    /__/       )_/  /__\\  \\_\n" );
    }
}
