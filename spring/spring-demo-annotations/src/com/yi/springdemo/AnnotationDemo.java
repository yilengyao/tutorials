package com.yi.springdemo;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AnnotationDemo {
    public static void main(String[] args) {
        // Read Spring config file
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // Get the bean from Spring container
        Coach tennisCoach = context.getBean("tennisCoach", Coach.class);

        // Call a method on the bean
        System.out.println(tennisCoach.getDailyWorkout());

        // Close the context
        context.close();
    }
}
