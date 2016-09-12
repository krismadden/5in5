int x;
int speed;

void setup(){ //setup() "updates" only once
  size(300,300);
  //background(#88CBC6); //if background is in setup() any 'animation' in draw() will leave a trail
  rectMode(CENTER); // makes x/y reference point to center of object
  x = 150;
  speed = 5;
}

void draw(){ //draw() updates on defaut 60x per second
  background(#88CBC6); //background in draw() eliminates the tail
  line(2, 2, 300, 150); //(x1,y1,x2,y2) or (start point, end point) x= left/right y=up/down
  rect(150,150,100,100); // (x,y,width,height)
  fill(#131ABF);
  ellipse(x, mouseY, 100, 100); // (x, y, w, h) draws from center on default
  x = x + speed; // +1 moves to right. -1 moves to left. #is speed. 
  if(x > 250){
    speed = -speed;
  }
  if(x < 50){
    speed = -speed;
  }
}