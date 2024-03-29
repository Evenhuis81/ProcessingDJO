import java.util.Arrays;

ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Particle> toRemove = new ArrayList<Particle>();
ArrayList<Particle> toAdd = new ArrayList<Particle>();
Statistics statistics = new Statistics();
Mortar mortar = new Mortar();
Button startButton;
Sequencer seq = new Sequencer();

void setup() {
    size(800, 600);
    startButton = new Button("start", width-120, 20);
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

    startButton.show();

    seq.update();

    statistics.update();
    statistics.show();

}
