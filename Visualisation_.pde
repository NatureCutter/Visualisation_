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
  size(800, 400, P3D);  
  
  minim = new Minim(this);
  
  vent = minim.loadFile("vent.wav");
  //vent2 = minim.loadFile("vent2.wav");
  vent.loop();
  
 // fft = new FFT(vent.bufferSize() , vent.sampleRate());
  
}

void draw() {
  //background(200);
  //ellipse(mouseX, mouseY, 40, 40);
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
  float ventStart = map(help, 0 , vent.length(), 0 ,2 * PI);
 
  noFill();
    float rX = random(width / 2);
    float rY = random(height / 2);
  for(int i = 0; i < fade; i++) {
    stroke(255, 70 - i );
    float line = map(intensityL, 0, 1, 0, 2 * PI);
    strokeCap(ROUND);

    arc(width/2 + rX, height/2  + rY, intensity + i * fadeLength, intensity + i * fadeLength, ventStart, ventStart + line);
    //arc(width/2 + rX, height/2  + rY, intensity - i * fadeLength, intensity - i * fadeLength, ventStart, ventStart + line);
  }
 
 if ( mousePressed ) {
  saveFrame("images/wind-####.tif");
} 
}
