import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

void setup()
{
    size(800,600);

    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("IHMBTPZ6QQ8T8HbetfkCo1XhZ");
    cb.setOAuthConsumerSecret("XlQ7DSjdD6CvMDVGyPYhAF9HDt59FQ0mGsfnI6p0bhW7kbOqC4");
    cb.setOAuthAccessToken("1292727498-tThPIkw5XralZs3lERnqeeaHGaaKcTZsU8LpWfA");
    cb.setOAuthAccessTokenSecret("ycrbtYQ0uwdfjqd0vRzlissjOsFD0H1KiJyibuIVwEYDV");

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();
}

void draw()
{

}

void tweet()
{
    try
    {
        Status status = twitter.updateStatus("Weeeeee! (with love, from Processing)");
        System.out.println("Status updated to [" + status.getText() + "].");
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