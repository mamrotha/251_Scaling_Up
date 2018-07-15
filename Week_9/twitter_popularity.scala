import org.apache.spark.streaming.Seconds
import org.apache.spark.SparkConf
import org.apache.spark.streaming.twitter._

import com.datastax.spark.connector.streaming._
import com.datastax.spark.connector.SomeColumns

import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.streaming.StreamingContext._


object Twitter_Popularity extends App {

    //take arguments from the user
    if (args.length != 3) {
        System.err.println("\n\n\tUsage: twitter_popularity <duration in minutes> <sampling frequency seconds> <number of samples to take>")
        System.exit(1)
     }

    //set up run time values and top values
    val Array(firstarg,secondarg,thirdarg) = args.take(3)
    val duration = firstarg.toInt * 60
    val samplingFrequency = secondarg.toInt
    val samplingNumber = thirdarg.toInt

    //add your creds below
    System.setProperty("twitter4j.oauth.consumerKey", "")
    System.setProperty("twitter4j.oauth.consumerSecret", "")
    System.setProperty("twitter4j.oauth.accessToken", "")
    System.setProperty("twitter4j.oauth.accessTokenSecret", "")

    // create SparkConf
    val conf = new SparkConf().setAppName("mids tweeteat")

    // batch interval determines how often Spark creates an RDD out of incoming data
    val ssc = new StreamingContext(conf, Seconds(samplingFrequency))
    val stream = TwitterUtils.createStream(ssc, None)

    // extract desired data from each status during sample period as class "TweetData", store collection of those in new RDD
    val tweetData = stream.map(status => TweetData(status.getId, status.getUser.getScreenName, status.getText))
    val hashTags = tweetData.foreachRDD(rdd => {println(s"A sample of tweets I gathered over ${samplingFrequency}s: ${rdd.take(10).mkString(" ")} (total tweets fetched: ${rdd.count()})")})

    val hashTags = stream.flatMap(status => status.getText.split(" ").filter(_.startsWith("#")))
    hashTags.foreachRDD(rdd => {println(s"Hashtags are: ${rdd.take(10).mkString(" ")}")
                                var file = rdd.saveAsTextFile("/root/output/file1")})
    
    
                                
    // start consuming stream
    ssc.start
    ssc.awaitTerminationOrTimeout(duration * 1000)
    ssc.stop(true, true)

    println(s"============ Exiting ================")
    System.exit(0)
}

case class TweetData(id: Long, author: String, tweet: String)
