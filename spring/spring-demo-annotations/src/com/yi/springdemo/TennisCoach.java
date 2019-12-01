package com.yi.springdemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TennisCoach implements Coach {
    private FortuneService fortuneService;
    private FoodService foodService;

    // Constructor dependency injection
    @Autowired
    public TennisCoach(FortuneService fortuneService) {
        this.fortuneService = fortuneService;
    }

    // Setter dependency injectjion
    @Autowired
    public void setFoodService(FoodService foodService) {
        this.foodService = foodService;
    }

    public String getDailyFortune() {
        return fortuneService.getFortune();
    }

    public String getDailyMenu() {
        return foodService.getMenu();
    }

    @Override
    public String getDailyWorkout() {
        return "Practice your backhand volley";
    }
}
