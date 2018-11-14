import java.util.Collections;
final int BIRD_SIZE = 1000;

Bird[] bird = new Bird[BIRD_SIZE];
static ArrayList<Bird> birds = new ArrayList<Bird>();
IntList textPoints;
float targetX = 0, targetY = 0;

void setup() {
  size(1500,550);
  //fullScreen();
  noStroke();
  fill(255);

  for (int i=0; i<BIRD_SIZE; i++) {
    bird[i] = new Bird(random(0, width), random(0, height), 0.1, 0.05, color(random(0,255), random(0,255), random(0,255), 255));
    birds.add(bird[i]);
  }
  mappingFont("str");
  background(0);
}

void draw() {
  background(0);
  fill(0, 10);
  rect(0, 0, width, height);

  String str = "" + (hour() >= 10 ? hour() : "0"+hour()) 
    + ":" + (minute() >= 10 ? minute() : "0"+minute()) 
    + ":" + (second() >= 10 ? second() : "0"+second());
    view(str);

  if (textPoints.size() != 0) {
    for (long i=0; i<BIRD_SIZE; i++) {
      //int p = textPoints.get((int)(i * textPoints.size() / BIRD_SIZE));
      int p = textPoints.get( constrain((int)(i * 80000 / BIRD_SIZE),1,(textPoints.size()-1)));
      targetX = p % width;
      targetY = p / width;

      bird[(int)i].update(targetX, targetY);
      if(p != textPoints.get(textPoints.size()-1)) bird[(int)i].display();
    }
  }
}

String prestr = "";
void view(String str) {
  if (!prestr.equals(str)) {
    prestr = str;
    //Collections.shuffle(birds);
    bird =(Bird[])birds.toArray(new Bird[birds.size()]);
    if (!str.equals("")) mappingFont(str);
  }
}


void mappingFont(String str) {
  PGraphics buf = createGraphics(width, height);
  buf.beginDraw();
  buf.background(0);
  buf.fill(255, 255, 255);
  buf.textAlign(CENTER, CENTER);
  buf.textSize(300);
  buf.text(str, width/2, height/2);

  buf.loadPixels();
  textPoints = new IntList();
  for (int i=0; i<width; i++) {
    for(int j=0; j< height; j++){
      if (buf.pixels[j*width + i] == color(255, 255, 255)) {
  
        textPoints.append(j*width + i);
      }
    }
  }
  buf.endDraw();

  //println(textPoints.size());
}
