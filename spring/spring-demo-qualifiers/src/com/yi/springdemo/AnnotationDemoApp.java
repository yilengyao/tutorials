package com.yi.springdemo;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AnnotationDemoApp {
    public static void main(String[] args) {

        // read spring config file
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // Retrieve bean from spring container
        Coach tennisCoach = context.getBean("tennisCoach", Coach.class);

        // call get daily fortune method
        System.out.println(tennisCoach.getDailyFortune());

        // Close context
        context.close();
    }
}
