

import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;
 
TwitterStream twitterStream;

float t = 0;
float food = 1.4; // 1.4
float lastTime = 0;
int count2 = 0;

void setup() {     
  size(500,500);
  fill(#131ABF);
  stroke(255);
  strokeWeight(2); 
 lastTime = millis();
openTwitterStream();
}  
 
 
void draw() {     
  background(100);
   if ( (millis() - lastTime >2000) && (food > 0.82) ) { // 1000 = 1 second
      food = food - 0.02;
      lastTime = millis();
    }
  
  
  translate(width / 2, height / 2); //centers item
  
  beginShape();
  for(float theta = 0; theta <= 2 * PI; theta += 0.01){
    float rad = r(theta,
    food * sin(t) * 0.5 + 0.5, // a
    food * 2, // b
    food * 700, // m
    food * sin(t) * 0.5 + 3.5, // n1
    food * sin(t) * 0.5 + 0.5, // n2
    food * cos(t) * 0.5 + 1.5 // n3
    );
    float x = food * rad * cos(theta) * 50;
    float y = food * rad * sin(theta) * 50;
    vertex(x,y);
  }
  
  endShape();
  
  t += 0.1;
}  

float r(float theta, float a, float b, float m, float n1, float n2, float n3){
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + 
    pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
}
 

// Stream it
void openTwitterStream() {  
 

  //Credentials
ConfigurationBuilder cb = new ConfigurationBuilder();
cb.setOAuthConsumerKey("IHMBTPZ6QQ8T8HbetfkCo1XhZ");
cb.setOAuthConsumerSecret("XlQ7DSjdD6CvMDVGyPYhAF9HDt59FQ0mGsfnI6p0bhW7kbOqC4");
cb.setOAuthAccessToken("1292727498-tThPIkw5XralZs3lERnqeeaHGaaKcTZsU8LpWfA");
cb.setOAuthAccessTokenSecret("ycrbtYQ0uwdfjqd0vRzlissjOsFD0H1KiJyibuIVwEYDV");
 
  //the stream object
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
 

    
  // filter is used to pass querys to the stream
  // see twitter4j's java doc
  FilterQuery filtered = new FilterQuery();
 
  // if you enter keywords here it will filter, otherwise it will sample
  String keywords[] = {
    "protista"
  };
 
  //track is like "search"... well kind of
  // for a better explanation go 
  // dev.twitter.com/streaming/overview/request-parameters"
  filtered.track(keywords);
 
  // the StatusListener interface is where the magic happens
  // code there will be executed upon tweets arriving
  // so we want to attach one to our stream
  twitterStream.addListener(listener);
 
  if (keywords.length==0) {
    // sample() method internally creates a thread which manipulates TwitterStream 
    // and calls these adequate listener methods continuously.
    // ref //dev.twitter.com/streaming/reference/get/statuses/sample
    // "Returns a small random sample of all public statuses"
    twitterStream.sample();
  } else { 
    twitterStream.filter(filtered);
  }
  println("connected");
} 
 
 
// Implementing StatusListener interface
// the methods are pretty much self explantory
// they will be called according to the messages arrived
// onStatus is probabbly what you are lookikng for...
StatusListener listener = new StatusListener() {
 
  //@Override
  public void onStatus(Status status) {
    System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
    if (food < 4.1){
      food = food + 0.4; //feed
    }
  }
 
  //@Override
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }
 
  //@Override
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }
 
  //@Override
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }
 
  //@Override
  public void onStallWarning(StallWarning warning) {
    System.out.println("Got stall warning:" + warning);
  }
 
  //@Override
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
};