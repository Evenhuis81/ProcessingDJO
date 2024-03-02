void mousePressed() {
    if (button.inside()) button.press();
}

void mouseReleased() {
    if (button.pressed) {
        button.release();
        
        if (button.inside()) startPhase(1);
    }
}

void startPhase(int phase) {
    if (phase == 1) {
        if (phaseRunning) return;
        phaseRunning = true;
    }
}

void launcher() {
    Particle particle = new Particle(launchX, height + 5);
    particle.vel.y = -10;
    particle.applyForce(new PVector(0, 0.1));
    particleList.add(particle);

    launchX -= launchXCorrection;
    if (launchX < 0) phaseRunning = false;
}