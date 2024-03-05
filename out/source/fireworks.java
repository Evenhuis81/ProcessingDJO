/* autogenerated by Processing revision 1292 on 2024-03-05 */
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
// Button startButton;

public void setup() {
    /* size commented out by preprocessor */;
    // startButton = new Button("start", width-120, 20);
}

public void draw() {
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
class Fuse extends Particle {
    ArrayList<PVector> history = new ArrayList<PVector>();
    int historyLength = 20;

    Fuse(float x) {
        pos.set(x, height + size / 2);
        applyForce(new PVector(0, 0.015f)); // gravity
        vel.y = random(-4, -2); // launch speed
    }

    public void update() {
        history.add(pos.copy());
        if (history.size() > historyLength) history.remove(0);

        super.update();

        if (vel.y > 0) {
            toRemove.add(this);
            explode(30);
        }
    }

    public void show() {
        super.show();

        for (PVector h : history) point(h.x, h.y);
    }

    public void explode(int amount) {
        Particle[] sparks = new Particle[amount];

        for (int i = 0; i < sparks.length; i++) {
            sparks[i] = new Spark(pos);
        }
        
        toAdd.addAll(Arrays.asList(sparks));
    }
}


// class Fuse2 extends Particle {
//     float startX, speed, minX, maxX, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
//     // boolean added = false;

//     Fuse1(float x, float y, float minX, float maxX, float xCor) {
//         pos.set(x, y);
//         this.minX = minX;
//         this.maxX = maxX;
//         startX = x;
//         xCorrection = xCor;

//         // reposition when out of range and reverse xCorrection
//         if (startX < minX || startX > maxX ) {
//             xCorrection *= -1;
//             startX += xCorrection * 2;
//             pos.x = startX;
//         }

//         applyForce(new PVector(0, 0.3));
//         vel.y = random(-20, -16);
//     }

//     void update() {
//         super.update();

//         if (vel.y > 0) {
//             toRemove.add(this);
//             toAdd.add(new Fuse1(startX + xCorrection, height + 5, minX, maxX, xCorrection));
//             explode();
//         }
//     }

//     void explode() {
//         Particle[] sparks = new Particle[50];

//         for (int i = 0; i < sparks.length; i++) {
//             sparks[i] = new Spark(pos);
//         }
        
//         toAdd.addAll(Arrays.asList(sparks));
//     }
// }
public void mousePressed() {
    // if (startButton.inside()) startButton.press();
}

public void mouseReleased() {
    launchPad.ignite();
    // if (startButton.pressed) {
    //     if (startButton.inside()) launchPad.ignite();

    //     startButton.release();
    // }
}
class LaunchPad {
    boolean active = false;

    LaunchPad() {}

    public void ignite() {
        active = true;

        particleList.add(new Fuse(mouseX));
    }
}
class Particle {
    PVector pos, vel, acc;
    int strokeC = color(255, 255, 255, 255);
    int size = 8;

    Particle() { // default constructor
        pos = new PVector(); // no values = { x: 0, y: 0 }
        vel = new PVector();
        acc = new PVector();
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
class Spark extends Particle {
    int red, green, blue, opacity;

    Spark(PVector pos) {
        this.pos.set(pos.x, pos.y);
        vel.set(PVector.random2D());
        size = 5;
        opacity = 257;
        red = (int) random(256);
        green = (int) random(256);
        blue = (int) random(256);
        applyForce(new PVector(0.01f, 0.05f));
        strokeC = color(red, green , blue, opacity);
    }

    public void update() {
        super.update();

        strokeC = color(red, green , blue, opacity);

        opacity -= 2;
        if (opacity <= 0) toRemove.add(this);
    }
}
class Statistics {
    ArrayList<String> stats = new ArrayList<String>();

    Statistics() {
        addText(0, "Particles length: ");
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
        // setText(1, "xCor: " + xCorrection);
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
