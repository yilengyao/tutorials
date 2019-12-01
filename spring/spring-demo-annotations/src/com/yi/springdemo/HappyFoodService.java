package com.yi.springdemo;

import org.springframework.stereotype.Component;

@Component
public class HappyFoodService implements FoodService {
    @Override
    public String getMenu() {
        return "Daily menu is hamberger and fries.";
    }
}
