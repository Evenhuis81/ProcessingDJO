class Particle {
    PVector pos = new PVector(); // no params = { x: 0, y: 0 }
    PVector pos = new PVector();
    PVector pos = new PVector();
    int red = random(256);
    int green = random(256);
    int blue = random(256);
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
    ArrayList<PVector> history = new ArrayList<PVector>();
    int trailLength;

    ParticleWithTrail(int length) { // parameterized constructor
        trailLength = length;
    }

    if (!exploded) history.add(pos.copy());
        
        if (history.size() > trailLength || exploded) {
            history.remove(0);

            if (history.size() == 0) toRemove.add(this);
        }

    void update() {}

    void show() {
        
        for (int i = history.size(); i > 0; i--) {
            PVector hPos = history.get(i-1);
            
            float alpha = (float) i / history.size() * 255;

            stroke(red, green, blue, alpha);
            point(hPos.x, hPos.y);
        }
    }
}
