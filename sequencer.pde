class Sequencer {
    int[] thresholds;
    SequenceMethod[] methods;

    boolean started = false;
    boolean maxTime = false;
    float timePassed = 0;
    float currentMillis = 0;
    int timeThreshold = 1000;
    int timeGap = 200;
    int seqIndex = 0;

    // statistics.addText(1, "Time passed: " + millis());
    // statistics.setText(1, "Time passed: " + timePassed);
    Sequencer() {}

    void start() {
        currentMillis = millis();
        started = true;
    }

    void setSequence(int[] tholds, SequenceMethod[] mthods) {
        thresholds = tholds;
        methods = mthods;
    }

    void update() {
        if (!started) return;

        timePassed = millis() - currentMillis;

        if (timePassed > thresholds[seqIndex]) {
            // mortar.sequenceOne();
            methods[seqIndex].method();

            seqIndex++;

            if (seqIndex > thresholds.length - 1) started = false;

        //     timeThreshold += timeGap;

            // if (timeThreshold > 2000) started = false;
        }

        // 1. left -> right
        // 2. timedelay
        // 3. right -> left
        // 4. new

        // encapsulate timer into new class / array
        // multiple sequencer, die on end
    }
}
