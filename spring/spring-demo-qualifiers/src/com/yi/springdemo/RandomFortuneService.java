package com.yi.springdemo;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class RandomFortuneService implements FortuneService {

    // Create an array of strings
    private String[] data = {
            "Baware of the wolf in sheep's clothing",
            "Diligence is the mother of good luck",
            "The journey is the reward"
    };

    // create a random number generator
    private Random myRandom = new Random();
    @Override
    public String getFortune() {
        // pick a random string from the array
        int index = myRandom.nextInt(data.length);
        return data[index];
    }
}
