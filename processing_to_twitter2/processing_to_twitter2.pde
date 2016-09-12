import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

void setup()
{
    size(200,200);

    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("lWiYzJUpWzWSCiUH20pIVUqiM");
    cb.setOAuthConsumerSecret("W6734Mebzbby7uBPIwtO7VvI7I6bF7qWCRuIrUYpGPqPJ0625b");
    cb.setOAuthAccessToken("773096503250448385-1oPKOinCwsqV2Mh08vvWoMn1CAplhE5");
    cb.setOAuthAccessTokenSecret("xh2Jpu5HQcu28tLXvZbhBJgRUQW1K2XQKqtOgkFRa21Gh");

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();
}

void draw()
{

}
int t = 0;
int count = 0;
void tweet()
{
    try
    {
        if(t == 0){
          Status status = twitter.updateStatus("asdfasdf? #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 1;
        count = count + 1;
        }
        else if (t == 1){
          Status status = twitter.updateStatus(" adsfasdftweet. Does it work? #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 2;
        count = count + 1;
        }
        else if (t == 2){
          Status status = twitter.updateStatus(" Thadsfadf tweet. weee? weee! #Protista " + count);
        System.out.println("Status updated to [" + status.getText() + "].");
        t = 3;
        count = count + 1;
        }
        else{
          Status status = twitter.updateStatus(" Whatasdfweet is this? Oh yes! #Protista " + count);
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