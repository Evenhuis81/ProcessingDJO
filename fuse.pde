class Fuse extends Tail {
    int count = 0;
    int explodeCount = 90;
    boolean exploded = false;

    Fuse(float x, float y, float angle, int radius) { // parameterized constructor
        super(new PVector(x, y), PVector.fromAngle(angle).mult(5), (int) random(15, 30), radius); // pos, vel and tail length
        applyForce(new PVector(0, 0.022)); // gravity
    }

    void update() {
        if (!exploded) super.update();

        if (count > explodeCount && !exploded) {
            exploded = true;
            explode(15);
            stop();
        }

        if (exploded) {
            fadeOut();

            if (tail.size() == 0) toRemove.add(this);
        }

        count++;
    }

    void explode(int amount) {
        Particle[] particles = new Tail[amount];

        for (int i = 0; i < particles.length; i++) {
            particles[i] = new TailExploded(pos, PVector.random2D().mult(2), (int) random(45, 90), 3, (int) random(2, 9));
            particles[i].applyForce(new PVector(0, 0.022));
        }
        
        toAdd.addAll(Arrays.asList(particles));
    }
}
