class Sequencer {
    boolean started = false;
    float timePassed = 0;
    float currentMillis = 0;

    Sequencer() {}

    void start() {
        currentMillis = millis();
        statistics.addText(1, "Time passed: " + millis());
        started = true;
    }

    void update() {
        if (started) {
            timePassed = millis() - currentMillis;
            statistics.setText(1, "Time passed: " + timePassed);
        }

        if (timePassed > 3000) 
    }
}
