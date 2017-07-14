int[] simRes = {64,64};
static int windowWidth = 1280;
static int windowHeight = 720;


int[][] eField = new int[simRes[0]][simRes[1]];
Dipole mainAnt = new Dipole();
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
  int divs = 16; //Number of divisions to simulate the dipole with
  double frequency = 0.2f; //Frequency of the standing wave in hertz
  double time = 0.0f;
  
  
  Dipole() {
    
  }
  
  void simulate(double dt) {
    double[] divVoltages = new double[divs];
    time += dt;
    
    for(int div = 0; div < divs; div++) {
      divVoltages[div] = voltage * cos((PI / (float)divs) * ((float)div + 0.5f)) * sin((float)(frequency * TWO_PI * time));
      
      
      strokeWeight(3);
      stroke(constrain((float)((-divVoltages[div] / voltage) * 255.0f), 0.0f, 255.0f), constrain((float)((divVoltages[div] / voltage) * 255.0f), 0.0f, 255.0f), 0);
      line((float)(x * drawScale + XOffset), (float)(((y * drawScale + YOffset) - length / 2 * drawScale) + length / divs * div * drawScale), (float)(x * drawScale + XOffset), (float)(((y * drawScale + YOffset) - length / 2 * drawScale) + length / divs * (div + 1) * drawScale));
    }
  }
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
  strokeWeight(1.0f);
  stroke(80, 80, 80);
  
  for(int i = 0; i < simRes[1] + 1; i++) {
    line(XOffset, (float)(i * cellScale) + YOffset, (float)(simRes[1] * cellScale) + XOffset, (float)(i * cellScale) + YOffset);
  }
  for(int i = 0; i < simRes[0] + 1; i++) {
    line((float)(i * cellScale) + XOffset, YOffset, (float)(i * cellScale) + XOffset, (float)(simRes[1] * cellScale) + YOffset);
  }
  
  mainAnt.simulate(1.0f / 60.0f);
}