class Particle {
    PVector pos, vel, acc;
    color strokeC = color(255);
    int size = 10;

    Particle() { // default constructor
        pos = new PVector(); // no values = x: 0, y: 0
        vel = new PVector();
        acc = new PVector();

        println("Particle created");
    }

    void applyForce(PVector force) {
        // F = M * A (force = mass * acceleration), mass ommited
        acc.add(force);
    }

    void removeForce(PVector force) {
        acc.sub(force);
    }

    void update() {
        vel.add(acc);
        pos.add(vel);
    }

    void show() {
        stroke(strokeC);
        strokeWeight(size);
        point(pos.x, pos.y);
    }
}
