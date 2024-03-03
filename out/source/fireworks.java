import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
LaunchPad launchPad;
Button startButton;
int bkgrdC = 0;

public void setup() {
    
    startButton = new Button("start", width-120, 20);
    launchPad = new LaunchPad();
}

public void draw() {
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

        strokeWeight(1);

        // line to check middle of text for vertical alignment
        // line(x, y + h/2, x + w, y + h/2);
    }
}
public void mousePressed() {
    if (startButton.inside()) startButton.press();
}

public void mouseReleased() {
    if (startButton.pressed) {
        if (startButton.inside()) launchPad.start();

        startButton.release();
    }
}
class LaunchPad {
    boolean started = false;

    LaunchPad() {
        println("LaunchPad created");
    }

    public void start() {
        if (started) return;

        started = true;

        particleList.add(new Fuse1(width - 10, height + 5, -20));
    }
}

class Fuse1 extends Particle {
    float startX, speed, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
    boolean added = false;

    Fuse1(float x, float y, float xCor) {
        // this.id = id;
        pos.set(x, y);
        this.xCorrection = xCor;
        startX = x + xCorrection;
        applyForce(new PVector(0, 0.1f));
        vel.y = -10;

        println("Fuse" + "asdf" + " created");
    }

    public void update() {
        super.update();

        if (vel.y > 2) {
            // particleList.remove(id);
            toRemove.add(this);
        }

        if (pos.y < height - 50 && !added) {
            // particleList.add(new Fuse1(startX, height + 5, -20));
            toAdd.add(new Fuse1(startX, height + 5, xCorrection));
            added = true;
        }

        if (startX <= 10 || startX >= width - 10 ) xCorrection *= -1;
    }
}
class Particle {
    PVector pos, vel, acc;
    int strokeC = color(255);
    int size = 10;

    Particle() { // default constructor
        pos = new PVector(); // no values = x: 0, y: 0
        vel = new PVector();
        acc = new PVector();

        println("Particle created");
    }

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
        stroke(strokeC);
        strokeWeight(size);
        point(pos.x, pos.y);
    }
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fireworks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
