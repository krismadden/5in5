

import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;
 
TwitterStream twitterStream;
Twitter twitter;
 
void setup() {     
  size(100, 100);    
  background(0); 
  openTwitterStream();
 // openTwitterStream2();
  
}  
 
int food = 1;

void draw() {     
  background(0);
  ellipse(50, 50, food, food);
  
}  
 
/*void openTwitterStream2(){
   ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("lWiYzJUpWzWSCiUH20pIVUqiM");
    cb.setOAuthConsumerSecret("W6734Mebzbby7uBPIwtO7VvI7I6bF7qWCRuIrUYpGPqPJ0625b");
    cb.setOAuthAccessToken("773096503250448385-1oPKOinCwsqV2Mh08vvWoMn1CAplhE5");
    cb.setOAuthAccessTokenSecret("xh2Jpu5HQcu28tLXvZbhBJgRUQW1K2XQKqtOgkFRa21Gh");

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();
} */


// Stream it
void openTwitterStream() {  
 

  //Credentials
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("lWiYzJUpWzWSCiUH20pIVUqiM");
    cb.setOAuthConsumerSecret("W6734Mebzbby7uBPIwtO7VvI7I6bF7qWCRuIrUYpGPqPJ0625b");
    cb.setOAuthAccessToken("773096503250448385-1oPKOinCwsqV2Mh08vvWoMn1CAplhE5");
    cb.setOAuthAccessTokenSecret("xh2Jpu5HQcu28tLXvZbhBJgRUQW1K2XQKqtOgkFRa21Gh");
   
   String bob = "b.build()";
   
   //tweeting
   TwitterFactory tf = new TwitterFactory(bob);

    twitter = tf.getInstance();
 
  //the stream object
  TwitterStream twitterStream = new TwitterStreamFactory(bob).getInstance();
 
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
    food = food + 1;
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



int t = 0;
int count = 0;
void tweet()
{
    try
    {
        if(t == 0){
          Status status = twitter.updateStatus("Testeasdfasdfr 1 #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 1;
        count = count + 1;
        }
        else if (t == 1){
          Status status = twitter.updateStatus(" lalaadsfadsfllala #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 2;
        count = count + 1;
        }
        else if (t == 2){
          Status status = twitter.updateStatus(" heheadsfassheheheh! #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 3;
        count = count + 1;
        }
        else{
          Status status = twitter.updateStatus(" waaaeeeeeeeeaaaaa! #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 0;
        count = count + 1;
        }
    }
    catch (TwitterException te)
    {
        System.out.println("Error: "+ te.getMessage());
    }
}

void keyPressed()
{
    tweet();
}