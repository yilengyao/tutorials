package com.yi.springdemo;

import org.springframework.stereotype.Component;

@Component
public class HappyTransportationService implements TransportationService {
    @Override
    public String getTransportation() {
        return "Transport by Car";
    }
}
