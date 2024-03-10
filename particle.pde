class Particle { // Aerial Projectile
    PVector pos = new PVector(); // no params = { x: 0, y: 0 }
    PVector vel = new PVector();
    PVector acc = new PVector();
    int red = (int) random(256);
    int green = (int) random(256);
    int blue = (int) random(256);
    int alpha = 255;
    int radius = 4;

    Particle() {} // default constructor

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
        stroke(red, green, blue, alpha);
        strokeWeight(radius * 2);
        point(pos.x, pos.y);
    }
}

class Tail extends Particle {
    ArrayList<PVector> tail = new ArrayList<PVector>();
    float tailAlpha = 255;
    int maxAlpha = 255;
    int length = 0;

    Tail(PVector pos, PVector vel, int length, int radius) {
        this.pos.set(pos);
        this.vel.set(vel);
        this.length = length;
        this.radius = radius;
    }

    void stop() {
        if (tail.size() == 0) return;

        alpha = 0;
    }

    void update() {
        tail.add(pos.copy());

        super.update();

        if (tail.size() > length) tail.remove(0);
    }

    void fadeOut() {
        if (tail.size() == 0) return;

        tail.remove(0);
    }

    void show() {
        super.show();

        for (int i = tail.size(); i > 0; i--) {
            PVector hPos = tail.get(i-1);
            
            tailAlpha = (float) i / (tail.size() + 1) * maxAlpha; // + 1 = include particle

            stroke(red, green, blue, tailAlpha);
            point(hPos.x, hPos.y);
        }
    }
}

class TailExploded extends Tail {
    float step;

    TailExploded(PVector pos, PVector vel, int length, int radius, int step) {
        super(pos, vel, length, radius);

        this.step = step;

        println(step); 
    }

    void update() {
        super.update();

        maxAlpha -= step;

        alpha = maxAlpha;

        if (maxAlpha < 1) toRemove.add(this);
    }
}
