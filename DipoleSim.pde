int[] simRes = {64,64};
static int windowWidth = 1280;
static int windowHeight = 720;


int[][] eField = new int[simRes[0]][simRes[1]];
float scale = 0.01f; //m per sim unit
float dt = 0.1f; //

double drawScale; //pixels per meter
double cellScale; //pixels per cell
float XOffset;
float YOffset;

class Dipole {
  double current = 1.0f;
  double voltage = 1.0f;
  float x = 0.32f;
  float y = 0.32f;
  float length = 0.2f;
}

void changeScale(float factor) {
  cellScale *= factor;
  drawScale = cellScale * (1/scale);
  
  XOffset = (float)((width - cellScale * simRes[0])/2.0f);
  YOffset = (float)((height - cellScale * simRes[1])/2.0f);
}

void setup() {
  surface.setSize(windowWidth, windowHeight);
 
  if(width <= height) {
    cellScale = ((float)width - 1.0f) / (float)simRes[0];
  } else {
    cellScale = ((float)height - 1.0f) / (float)simRes[1];
  }
  
  drawScale = cellScale * (1/scale);
  
  changeScale(0.9f);
}

void draw() {
  background(20, 20, 20);
  stroke(80, 80, 80);
  
  for(int i = 0; i < simRes[1] + 1; i++) {
    line(XOffset, (float)(i * cellScale) + YOffset, (float)(simRes[1] * cellScale) + XOffset, (float)(i * cellScale) + YOffset);
  }
  for(int i = 0; i < simRes[0] + 1; i++) {
    line((float)(i * cellScale) + XOffset, YOffset, (float)(i * cellScale) + XOffset, (float)(simRes[1] * cellScale) + YOffset);
  }
  
  
}