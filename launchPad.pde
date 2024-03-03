class LaunchPad {
    boolean started = false;

    LaunchPad() {
        println("LaunchPad created");
    }

    void start() {
        if (started) return;

        started = true;

        particleList.add(new Fuse1(width - 10, height + 5, -20));
    }
}

class Fuse1 extends Particle {
    float startX, speed, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
    boolean added = false;

    Fuse1(float x, float y, float xCor) {
        // this.id = id;
        pos.set(x, y);
        this.xCorrection = xCor;
        startX = x + xCorrection;
        applyForce(new PVector(0, 0.1));
        vel.y = -10;

        println("Fuse" + "asdf" + " created");
    }

    void update() {
        super.update();

        if (vel.y > 2) {
            // particleList.remove(id);
            toRemove.add(this);
        }

        if (pos.y < height - 50 && !added) {
            // particleList.add(new Fuse1(startX, height + 5, -20));
            toAdd.add(new Fuse1(startX, height + 5, xCorrection));
            added = true;
        }

        if (startX <= 10 || startX >= width - 10 ) xCorrection *= -1;
    }
}
