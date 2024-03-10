class MortarShell extends Tail { // Flare -> (https://fireworks1.com/Fireworks-Dictionary.html)
    color colour = color(255, 0, 0, 255);
    
    MortarShell(float x, color col) {
        super(new PVector(x, height + 10), new PVector(0, -3), 100, 20, col); // pos, vel, tail length, size, color
        applyForce(new PVector(0, 0.01));
    }

    // void update() {
    //     //
    // }

    // void show() {
    //     //
    // }
}

class MortarShell2 extends Tail {
    int count = 0;
    int explodeCount = 90;
    boolean exploded = false;

    MortarShell2(PVector pos, float angle, int radius) { // parameterized constructor
        super(pos, PVector.fromAngle(angle).mult(5), (int) random(15, 30), radius); // pos, vel, tail length, size
        applyForce(new PVector(0, 0.022)); // gravity
    }

    void update() {
        if (!exploded) super.update();

        if (count > explodeCount && !exploded) {
            exploded = true;
            explodeDahlia(15);
            stop();
        }

        if (exploded) {
            fadeOut();

            if (tail.size() == 0) toRemove.add(this);
        }

        count++;
    }

    void explodeDahlia(int amount) {
        Particle[] particles = new Tail[amount];

        for (int i = 0; i < particles.length; i++) {
            particles[i] = new TailExploded(pos, PVector.random2D().mult(2), (int) random(45, 90), 3, (int) random(2, 9));
            particles[i].applyForce(new PVector(0, 0.022));
        }
        
        toAdd.addAll(Arrays.asList(particles));
    }
}
