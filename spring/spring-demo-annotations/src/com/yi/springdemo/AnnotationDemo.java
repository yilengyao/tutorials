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

        // Call method to get the daily fortune
        System.out.println(tennisCoach.getDailyFortune());

        // Call method to get the daily menu
        System.out.println(tennisCoach.getDailyMenu());

        // Call method to get daily transport
        System.out.println(tennisCoach.getDailyTransportation());

        // Close the context
        context.close();
    }
}
