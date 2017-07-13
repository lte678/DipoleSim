int[] simRes = {64,64};

int[][] eField = new int[simRes[0]][simRes[1]];
float scale = 0.01f; //m per sim unit
float dt = 0.1f; //

double drawScale; //pixels per meter
double cellScale; //pixels per cell

class Dipole {
  double current = 1.0f;
  double voltage = 1.0f;
  float x = 0.32f;
  float y = 0.32f;
  float length = 0.2f;
}

void setup() {
  size(displayWidth, displayHeight);
 
  if(width <= height) {
    cellScale = (float)width / (float)simRes[0];
  } else {
    cellScale = (float)height / (float)simRes[1];
  }
  
  drawScale = cellScale * (1/scale);
}

void draw() {
  background(0, 0, 0);
  stroke(255, 255, 255);
  for(int i = 0; i < simRes[1] + 1; i++) {
    line(0, (float)(i * cellScale), (float)(simRes[1] * cellScale), (float)(i * cellScale));
  }
  for(int i = 0; i < simRes[0] + 1; i++) {
    line((float)(i * cellScale), 0, (float)(i * cellScale), (float)(simRes[1] * cellScale));
  }
  
  
}