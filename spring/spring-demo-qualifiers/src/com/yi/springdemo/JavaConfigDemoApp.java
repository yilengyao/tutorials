package com.yi.springdemo;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class JavaConfigDemoApp {
    public static void main(String[] args) {

        // read spring config file
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(SportConfig.class);

        // Retrieve bean from spring container
        Coach tennisCoach = context.getBean("tennisCoach", Coach.class);

        // call get daily fortune method
        System.out.println(tennisCoach.getDailyFortune());

        // Close context
        context.close();
    }
}
