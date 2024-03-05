// import java.util.Arrays;
import java.util.Arrays;

ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Particle> toRemove = new ArrayList<Particle>();
ArrayList<Particle> toAdd = new ArrayList<Particle>();
Statistics statistics = new Statistics();
LaunchPad launchPad;
Button startButton;
int bkgrdC = color(0);

void setup() {
    size(800, 600);
    startButton = new Button("start", width-120, 20);
    launchPad = new LaunchPad();

    statistics.addText(0, "Particles length: " + particleList.size());
    statistics.addText(1, "xCor: ");
    statistics.addText(2, "startX: ");
    statistics.addText(3, "minX: ");
    statistics.addText(4, "maxX: ");
}

void draw() {
    background(bkgrdC);

    for (Particle p : particleList) {
        p.update();
        p.show();
    }

    particleList.removeAll(toRemove);
    particleList.addAll(toAdd);

    toRemove.clear();
    toAdd.clear();

    startButton.show();

    statistics.setText(0, "Particles length: " + particleList.size());
    statistics.show();
}


X x, x2;

x = new X();
x2 = new X();

println(x);

class X {
    float x = 20;
}
