class Sequencer {
    boolean started = false;
    boolean maxTime = false;
    float timePassed = 0;
    float currentMillis = 0;
    int timeThreshold = 1000;
    int timeGap = 200;


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

        if (timePassed > timeThreshold && !maxTime) {
            mortar.igniteOne();

            timeThreshold += timeGap;

            if (timeThreshold > 3000) maxTime = true;
        }

        // 1. left -> right
        // 2. timedelay
        // 3. right -> left
        // 4. new

        // encapsulate timer into new class / array
        // multiple sequencer, die on end
    }
}
