class Particle {
    PVector pos = new PVector(); // no params = { x: 0, y: 0 }
    PVector vel = new PVector();
    PVector acc = new PVector();
    int red = (int) random(256);
    int green = (int) random(256);
    int blue = (int) random(256);
    int alpha = 255;
    int strokeColor = color(red, green, blue, alpha);
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
        stroke(strokeColor);
        strokeWeight(radius * 2);
        point(pos.x, pos.y);
    }
}

class ParticleWithTrail extends Particle {
    ArrayList<PVector> trail = new ArrayList<PVector>();
    int count, trailLength, trailAlpha;
    boolean stop = false;

    ParticleWithTrail() {}

    void update() {
        if (!stop) trail.add(pos.copy());

        super.update();

        if (trail.size() > trailLength || stop) trail.remove(0);

        if (stop && trail.size() == 0)  toRemove.add(this);
    }

    void show() { 
        super.show();

        for (int i = trail.size(); i > 0; i--) {
            PVector hPos = trail.get(i-1);
            
            trailAlpha = (float) i / trail.size() * 255;

            stroke(red, green, blue, alpha);
            point(hPos.x, hPos.y);
        }
    }
}
