import processing.video.*;

Capture cam;
Movie myMovie;







void setup() {
  size(1600, 1200);
  myMovie = new Movie(this, "Yoghurt_bacteria.mov");
  myMovie.loop();

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[15]); //15 or 0
    cam.start();     
  }      
}

void draw() {
  image(myMovie, 0, 0);
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

void movieEvent(Movie m) {
  m.read();
  tint(255, 240);  // Display at half opacity
}