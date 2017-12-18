import gifAnimation.*;

GifMaker gifExport;

int shapeSize;
float squareMod;
int cX;
int cY;
int generations;

int frames;
float scaling;

void setup() {

  rectMode(CENTER);
  frameRate(30);

  noStroke();
  size(512, 512);

  frames = 100;
  shapeSize = 100;
  squareMod = 0.7;
  generations = 5;

  scaling = (width / 2.0) / float(frames);

  cX = width / 2;
  cY = height / 2;

  gifExport = new GifMaker(this, "../gifs/diagsquares.gif");
  gifExport.setRepeat(0);
  gifExport.setTransparent(255, 255, 255);
  gifExport.setDelay(1000/30);
}

void splitter(int posX, int posY, int shSize, int gen, int mod) {
  if (gen == 0) {
    drawShape(posX, posY, shSize);
  } else {
    int newSize = int(shSize * squareMod);
    int ngen = gen - 1;
    int nmod = mod / 2;
    splitter(posX - nmod, posY - nmod, newSize, ngen, nmod);
    splitter(posX + nmod, posY - nmod, newSize, ngen, nmod);
    splitter(posX + nmod, posY + nmod, newSize, ngen, nmod);
    splitter(posX - nmod, posY + nmod, newSize, ngen, nmod);
  }
}

void drawShape(int posX, int posY, int shSize) {
  rect(posX, posY, shSize, shSize);
}

void draw() {

  background(255);

  int loopCount = (frameCount % frames);
  float loopVar = (loopCount / float(frames));
  int mod = int(loopCount * scaling);
  int gen = int(loopVar * generations);

  fill(20, 200, 50 + int(loopVar * 200));
  splitter(cX - mod, cY - mod, shapeSize, gen, mod);
  splitter(cX + mod, cY - mod, shapeSize, gen, mod);
  splitter(cX + mod, cY + mod, shapeSize, gen, mod);
  splitter(cX - mod, cY + mod, shapeSize, gen, mod);
  gifExport.addFrame();

  if (frameCount == frames) gifExport.finish();
}
