class Fuse1 extends Particle {
    float startX, speed, minX, maxX, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
    // boolean added = false;

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

        applyForce(new PVector(0, 0.3));
        vel.y = random(-20, -16);

        statistics.setText(1, "xCor: " + xCorrection);
        statistics.setText(2, "startX: " + startX);
        statistics.setText(3, "minX: " + minX);
        statistics.setText(4, "maxX: " + maxX);
    }

    void update() {
        super.update();

        if (vel.y > 0) {
            toRemove.add(this);
            toAdd.add(new Fuse1(startX + xCorrection, height + 5, minX, maxX, xCorrection));
            explode();
        }
    }

    void explode() {
        Particle[] sparks = new Particle[50];

        for (int i = 0; i < sparks.length; i++) {
            sparks[i] = new Spark(pos);
        }
        
        toAdd.addAll(Arrays.asList(sparks));
    }
}
