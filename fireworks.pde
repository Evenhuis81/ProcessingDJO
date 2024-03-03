ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Particle> toRemove = new ArrayList<Particle>();
ArrayList<Particle> toAdd = new ArrayList<Particle>();
LaunchPad launchPad;
Button startButton;
int bkgrdC = 0;

void setup() {
    size(800, 600);
    startButton = new Button("start", width-120, 20);
    launchPad = new LaunchPad();
}

void draw() {
    background(bkgrdC);

    // for (int i = 0; i < particleList.size(); i++)
    for (Particle p : particleList) {
        p.update();
        p.show();
    }

    particleList.removeAll(toRemove);
    particleList.addAll(toAdd);

    toRemove.clear();
    toAdd.clear();



    startButton.show();
}
