import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim         minim;
AudioPlayer   vent;
AudioPlayer   vent2;
FFT           fft;

boolean strobe;
int fadeLength = 5;
int fade = 3;

void setup() {
  size(800, 600, P3D);  
  background(220);

  strokeCap(ROUND);
  minim = new Minim(this);

  vent = minim.loadFile("vent.wav");
  //vent2 = minim.loadFile("vent2.wav");
  vent.loop();

  // fft = new FFT(vent.bufferSize() , vent.sampleRate());
  /*
  for (int i = 0; i < width; i++) {
    fill(255 - (i / width) * 255, 2 + (i / width) * 15);
    noStroke();
    ellipse(width/2, height/2, i, i);
  }
  */
}

void draw() {
  //background(200);
  /*
  if(strobe && millis() % 4 == 0) {
   camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
   strobe = false;
   println("jo");
   }
   if(!strobe && millis() % 4 == 0) {
   camera(width/2, height/2, (height/2) / tan(PI/6) + 100, width/2, height/2, 0, 0, 1, 0);
   strobe = true;
   println("jol");
   }*/

  noiseSeed(0);

  float intensityL = vent.left.get(0);
  float intensityR = vent.right.get(0);

  float intensity = width * (intensityL + intensityR);

  float help = vent.position();
  float ventStart = map(help, 0, vent.length(), 0, 2 * PI);
/*
  float rX = random(-width / 2, width / 2);
  float rY = random(-height / 2, height / 2);
*/
  
  float rX = random(width / 2);
  float rY = random(height / 2);
  
  fade = (int) random(6);
  for (int i = 0; i < fade; i++) {
    float colorIntensity;
    stroke(170, 170, random(200, 255), 40 - (i/fade) * 20 );
    strokeWeight((int)random(6));                                    
    float line = map(intensityL, 0, 1, 0, 2 * PI);
    float offset = fadeLength + random(10);

    noFill();
    arc(width/2 + rX, height/2  + rY, intensity + i * offset, intensity + i * offset, ventStart, ventStart + line);
    //arc(width/2 + rX, height/2  + rY, intensity - i * fadeLength, intensity - i * fadeLength, ventStart, ventStart + line);
  }

  if ( mousePressed ) {
    saveFrame("images/wind-####.tif");
  }
}

