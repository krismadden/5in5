void setup() {
  size(500,500);
  background(100);
  //noFill();
  stroke(#110B58);
  strokeWeight(2);
}

float t = 0;
float rot = 0;
void draw() {
  
  translate(mouseX,mouseY);
  fill(mouseX/2, mouseY/4, 255);
  //background(100);
  rotate(rot);
  beginShape();
  for(float theta = 0; theta <= 2 * PI; theta += 0.03){
    float rad = r(theta,
    sin(t) * 0.5 + 0.5, // a
    15, // b
    6, // m keep as an even number
    sin(t) * 0.5 + 3.9, // n1
    sin(t) * 0.5 + 0.5, // n2
    cos(t) * 0.5 + 0.9 // n3
    );
    float x = rad * cos(theta) * 35;
    float y = rad * sin(theta) * 35;
    vertex(x,y);
  }
  
  endShape();
  
  t += 0.1;
  rot += 0.0009;
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3){
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + 
    pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
}