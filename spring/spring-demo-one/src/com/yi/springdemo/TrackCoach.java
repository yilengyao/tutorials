package com.yi.springdemo;

public class TrackCoach implements Coach {

    private FortuneService fortuneService;
    public TrackCoach() {

    }
    public TrackCoach(FortuneService theFortuneService) {
        this.fortuneService = theFortuneService;
    }

    @Override
    public String getDailyWorkout() {
        return "Run a hard 5k";
    }

    @Override
    public String getDailyFortune() {
        return "Just Do it" + fortuneService.getFortune();
    }

    // add an init method
    public void doMyStartupStuff() {
        System.out.println("TrackCoach: inside method doMyStartupStuff");
    }

    // add a destroy method
    public void doMyCleanupStuffYoYo() {
        System.out.println("TrackCoach:inside method doMyCleanupStuffYoYo");
    }
}
