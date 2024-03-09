/* autogenerated by Processing revision 1292 on 2024-03-09 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.Arrays;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class fireworks extends PApplet {



ArrayList<Particle> particleList = new ArrayList<Particle>();
ArrayList<Particle> toRemove = new ArrayList<Particle>();
ArrayList<Particle> toAdd = new ArrayList<Particle>();
Statistics statistics = new Statistics();
LaunchPad launchPad = new LaunchPad();
Sequencer seq = new Sequencer();
Button startButton;

public void setup() {
    /* size commented out by preprocessor */;
    startButton = new Button("start", width-120, 20);
}

public void draw() {
    background(0);

    for (Particle p : particleList) {
        p.update();
        p.show();
    }

    seq.update();

    particleList.removeAll(toRemove);
    particleList.addAll(toAdd);

    toRemove.clear();
    toAdd.clear();

    startButton.show();

    statistics.update();
    statistics.show();
}
class Button {
    int x, y, w, h, r, s, fillC, strokeC; // r: rounded corner, s: textSize
    float textDesc; // correction for vertical alignment
    String txt;
    boolean pressed;

    Button() { // default constructor
        txt = "Button";
        x = 0;
        y = 0;
        w = 100;
        h = 40;
        r = 5;
        s = 30;
        fillC = 0;
        strokeC = 255;
        textSize(s);
        textDesc = 0.6f * textDescent();
        pressed = false;
    }

    Button(String buttonText, int x, int y) {
        this();
        txt = buttonText;
        this.x = x;
        this.y = y;
    }

    public boolean inside() {
        return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    }

    public void press() {
        pressed = true;
        fillC = 100;
    }

    public void release() {
        fillC = 0;
        pressed = false;
    }

    public void show() {
        stroke(strokeC);
        strokeWeight(2);
        fill(fillC);
        rect(x, y, w, h, r);

        textAlign(CENTER, CENTER);
        textSize(s);
        fill(255);
        text(txt, x + w/2, y + h/2 - textDesc);

        // line to check middle of text for vertical alignment
        // strokeWeight(1);
        // line(x, y + h/2, x + w, y + h/2);
    }
}
class Fuse extends Tail {
    int count = 0;
    int explodeCount = 90;
    boolean exploded = false;

    Fuse(float x, float y, float angle, int radius) { // parameterized constructor
        super(new PVector(x, y), PVector.fromAngle(angle).mult(5), (int) random(15, 30), radius); // pos, vel and tail length
        applyForce(new PVector(0, 0.022f)); // gravity
    }

    public void update() {
        if (!exploded) super.update();

        if (count > explodeCount && !exploded) {
            exploded = true;
            explode(15);
            stop();
        }

        if (exploded) {
            fadeOut();

            if (tail.size() == 0) toRemove.add(this);
        }

        count++;
    }

    public void explode(int amount) {
        Particle[] particles = new Tail[amount];

        for (int i = 0; i < particles.length; i++) {
            particles[i] = new TailExploded(pos, PVector.random2D().mult(2), (int) random(45, 90), 3, (int) random(2, 9));
            particles[i].applyForce(new PVector(0, 0.022f));
        }
        
        toAdd.addAll(Arrays.asList(particles));
    }
}
public void mousePressed() {
    if (startButton.inside()) startButton.press();
}

public void mouseReleased() {
    if (startButton.pressed) {
        if (startButton.inside()) {
            launchPad.ignite();
        }

        startButton.release();
    }
}
float angleAdjust = 0.05f;
float angleFactor = 1.25f; // 225°, range = 1.25 - 1.75 * PI (225 - 315°)
float angle = (float) Math.PI * angleFactor;
int size = 5;

class LaunchPad {
    LaunchPad() {}

    public void ignite() {
        seq.start();
    }

    public void igniteOne() {
        toAdd.add(new Fuse(width/2, height + size / 2, angle, size)); // x, y, angle, radius

        angleFactor += angleAdjust;
        angle = (float) Math.PI * angleFactor;

        if (angleFactor > 1.70f || angleFactor < 1.30f) angleAdjust *= -1;
    }
}
class Particle {
    PVector pos = new PVector(); // no params = { x: 0, y: 0 }
    PVector vel = new PVector();
    PVector acc = new PVector();
    int red = (int) random(256);
    int green = (int) random(256);
    int blue = (int) random(256);
    int alpha = 255;
    int radius = 4;

    Particle() {} // default constructor

    public void applyForce(PVector force) {
        // F = M * A (force = mass * acceleration), mass ommited
        acc.add(force);
    }

    public void removeForce(PVector force) {
        acc.sub(force);
    }

    public void update() {
        vel.add(acc);
        pos.add(vel);
    }

    public void show() {
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

    public void stop() {
        if (tail.size() == 0) return;

        alpha = 0;
    }

    public void update() {
        tail.add(pos.copy());

        super.update();

        if (tail.size() > length) tail.remove(0);
    }

    public void fadeOut() {
        if (tail.size() == 0) return;

        tail.remove(0);
    }

    public void show() {
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

    public void update() {
        super.update();

        maxAlpha -= step;

        alpha = maxAlpha;

        if (maxAlpha < 1) toRemove.add(this);
    }
}
class Sequencer {
    boolean started = false;
    float timePassed = 0;
    float currentMillis = 0;

    Sequencer() {}

    public void start() {
        currentMillis = millis();
        statistics.addText(1, "Time passed: " + millis());
        started = true;
    }

    public void update() {
        if (started) {
            timePassed = millis() - currentMillis;
            statistics.setText(1, "Time passed: " + timePassed);
        }
    }
}
class Statistics {
    ArrayList<String> stats = new ArrayList<String>();

    Statistics() {
        addText(0, "Particles length: ");
        // addText(1, "Milliseconds: ");
        // addText(1, "xCor: ");
        // addText(2, "startX: ");
        // addText(3, "minX: ");
        // addText(4, "maxX: ");
    }

    public void addText(int i, String txt) {
        stats.add(i, txt);
    }

    public void setText(int i, String txt) {
        stats.set(i, txt);
    }

    public void update() {
        setText(0, "Particles length: " + particleList.size());
        // setText(1, "Milliseconds: " + millis());
        // setText(2, "startX: " + startX);
        // setText(3, "minX: " + minX);
        // setText(4, "maxX: " + maxX);
    }

    public void show() {
        for (int i = 0; i < stats.size(); i++) {
            textAlign(LEFT, TOP);
            textSize(26);
            fill(255);
            text(stats.get(i), 0, i * 30);
        }
    }
}


  public void settings() { size(800, 600); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fireworks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
