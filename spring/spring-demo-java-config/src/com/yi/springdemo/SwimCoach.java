package com.yi.springdemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class SwimCoach implements Coach{

    private FortuneService fortuneService;

    public SwimCoach(FortuneService fortuneService ) {
        this.fortuneService = fortuneService;
    }
    @Override
    public String getDailyFortune() {
        return fortuneService.getFortune();
    }
}
