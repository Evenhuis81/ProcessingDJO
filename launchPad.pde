class LaunchPad {
    boolean started = false;

    LaunchPad() {}

    void start() {
        if (started) return;

        started = true;

        float xCor = -((width - width * 0.1 * 2) / 10);

        particleList.add(new Fuse1(width * 0.9, height + 5, width * 0.1, width * 0.9, xCor));
    }
}

class Fuse1 extends Particle {
    float startX, speed, minX, maxX, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
    boolean added = false;

    Fuse1(float x, float y, float minX, float maxX, float xCor) {
        pos.set(x, y);
        this.minX = minX;
        this.maxX = maxX;
        startX = x;
        xCorrection = xCor;

        // reposition when out of range and reverse xCorrection
        if (startX < minX || startX > maxX ) {
            xCorrection *= -1;
            startX += xCorrection * 2;
            pos.x = startX;
        }

        applyForce(new PVector(0, 0.1));
        vel.y = -10;

        statistics.setText(1, "xCor: " + xCorrection);
        statistics.setText(2, "startX: " + startX);
        statistics.setText(3, "minX: " + minX);
        statistics.setText(4, "maxX: " + maxX);
    }

    void update() {
        super.update();

        if (vel.y > 0) {
            explode();
            toRemove.add(this);
        }

        if (pos.y < height * 0.9 && !added) {
            added = true;
            toAdd.add(new Fuse1(startX + xCorrection, height + 5, minX, maxX, xCorrection));
        }
    }

    void explode() {
        Particle[] sparks = new Particle[50];

        for (int i = 0; i < sparks.length; i++) {
            sparks[i] = new Spark(pos);
        }
        
        toAdd.addAll(Arrays.asList(sparks));
        // particleList.addAll();
    }
}

class Spark extends Particle {
    int opacity = 255;

    Spark(PVector pos) {
        this.pos.set(pos.x, pos.y);
        vel.set(PVector.random2D());
    }

    void update() {
        super.update();

    }
}