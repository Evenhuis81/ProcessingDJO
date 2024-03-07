import java.util.Arrays;

ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Particle> toRemove = new ArrayList<Particle>();
ArrayList<Particle> toAdd = new ArrayList<Particle>();
Statistics statistics = new Statistics();
LaunchPad launchPad = new LaunchPad();
// Button startButton;

void setup() {
    size(800, 600);

    // startButton = new Button("start", width-120, 20);

    // println(5/20*255);

    float iT = 5;
    int iS = 20;

    println(iT / iS);
}

void draw() {
    background(0);

    for (Particle p : particleList) {
        p.update();
        p.show();
    }

    particleList.removeAll(toRemove);
    particleList.addAll(toAdd);

    toRemove.clear();
    toAdd.clear();

    // startButton.show();

    statistics.update();
    statistics.show();
}
