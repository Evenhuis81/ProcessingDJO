ArrayList<Particle> particleList = new ArrayList<Particle>();
boolean phaseRunning = false;

int backgroundColor = 0;
Button button;
int launchX;
int launchXCorrection = 10;

void setup() {
    size(800, 600);
    button = new Button("start", width-120, 20);

    launchX = width - 10;
}

int counter = 0;

void draw() {
    background(backgroundColor);

    updates();
    shows();

    if (phaseRunning) {
        counter++;

        if (counter % 2 == 0) {
            launcher();
            println(launchX);
        }
    }
}

void updates () {
    for (Particle p : particleList) {
        p.update();
    }
}

void shows() {
    button.show();

    for (Particle p : particleList) {
        p.show();
    }
}