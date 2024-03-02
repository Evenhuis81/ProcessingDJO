class Particle {
    PVector pos, vel, acc;
    color colour = color(255);
    int size = 10;

    Particle(float x, float y) {
        pos = new PVector(x, y);
        vel = new PVector();
        acc = new PVector();
    }

    void applyForce(PVector force) {
        // F = M * A (force = mass * acceleration) Mass ommited for now
        acc.add(force);
    }

    void update() {
        vel.add(acc);
        pos.add(vel);
    }

    void show() {
        stroke(colour);
        strokeWeight(size);
        point(pos.x, pos.y);
    }
}
