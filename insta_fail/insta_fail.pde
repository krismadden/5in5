import com.francisli.processing.http.*;


 
PFont InstagramFont;
PImage backgroundimg;
PImage brand;
PImage userphoto;
PImage profilepicture;
 
String username;
String tag;
String[] tagStrings;
 
String comment;
 
com.francisli.processing.http.HttpClient client;
 
void setup() {
  size(580, 900);
  smooth();
  //backgroundimg = loadImage("globalgram_background.jpg");
  //brand = loadImage("iso.jpg");
 
  InstagramFont = loadFont("DialogInput-48.vlw");
 
  client = new com.francisli.processing.http.HttpClient(this, "api.instagram.com");
  client.useSSL = true;
 
 
}
 
void getGrams() {
    //// instantiate a new HashMap
  HashMap params = new HashMap();
  //// put key/value pairs that you want to send in the request
  params.put(" 523ac6294fe8474d8688b395c41c0609", "70614def9de24767b6d56bd203cf8768");
  params.put("count", "0");
  client.GET("/v1/tags/newyork/media/recent.json", params);
}
 
void responseReceived(com.francisli.processing.http.HttpRequest request, com.francisli.processing.http.HttpResponse response) {
  println(response.getContentAsString());
 
  //// we get the server response as a JSON object
  com.francisli.processing.http.JSONObject content = response.getContentAsJSONObject();
 
  //// get the "data" value, which is an array
  com.francisli.processing.http.JSONObject data = content.get("data");
 
  //// get the first element in the array
  com.francisli.processing.http.JSONObject first = data.get(0);
 
  //// the "user" value is another dictionary, from which we can get the "full_name" string value
  println(first.get("user").get("full_name").stringValue());
  //// the "caption" value is another dictionary, from which we can get the "text" string value
  //println(first.get("caption").get("text").stringValue());
  //// get profile picture
  println(first.get("user").get("profile_picture").stringValue());
  //// the "images" value is another dictionary, from which we can get different image URL data
  println(first.get("images").get("standard_resolution").get("url").stringValue());
 
  com.francisli.processing.http.JSONObject tags = first.get("tags");
  tagStrings = new String[tags.size()];
  for (int i = 0; i < tags.size(); i++) {
    tagStrings[i] = tags.get(i).stringValue();
  } 
 
  comment = first.get("caption").get("text").stringValue();
  username = first.get("user").get("full_name").stringValue();
 
  String profilepicture_url = first.get("user").get("profile_picture").stringValue();
  profilepicture = loadImage(profilepicture_url, "png");
 
  String userphoto_url = first.get("images").get("standard_resolution").get("url").stringValue();
  userphoto = loadImage(userphoto_url, "png");
 
 //noLoop();
}
 
 
void draw() {
  background(255);
  //imageMode(CENTER);
  //image(brand, 100, height/1.05);
 
  println(frameCount);
 
  if(frameCount % 1000 == 0){
    getGrams();
  }
 
  if (profilepicture != null) {
    image(profilepicture, 60, 70, 90, 90);
  }
  imageMode(CENTER);
  if (userphoto != null) {
    image(userphoto, width/2, height/2.25, 550, 550);
  }
 
  textFont(InstagramFont, 20);
  if (username != null) {
    text(username, 110, 115);
    fill(0);
  }
 
  textFont(InstagramFont, 15);
  if (comment != null) {
    text(comment, 15, 700, 550, 100);
    fill(0);
  }
 
 
}