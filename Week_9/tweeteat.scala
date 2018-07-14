import org.apache.spark.streaming.Seconds
import org.apache.spark.SparkConf
import org.apache.spark.streaming.twitter._

import com.datastax.spark.connector.streaming._
import com.datastax.spark.connector.SomeColumns

import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.streaming.StreamingContext._


object TweatEat  extends App {
    val batchInterval_s = 1
    val totalRuntime_s = 32
    //add your creds below

    System.setProperty("twitter4j.oauth.consumerKey", "")
    System.setProperty("twitter4j.oauth.consumerSecret", "")
    System.setProperty("twitter4j.oauth.accessToken", "")
    System.setProperty("twitter4j.oauth.accessTokenSecret", "")
    // create SparkConf
    val conf = new SparkConf().setAppName("mids tweeteat");

    // batch interval determines how often Spark creates an RDD out of incoming data

    val ssc = new StreamingContext(conf, Seconds(2))

    val stream = TwitterUtils.createStream(ssc, None)

    // extract desired data from each status during sample period as class "TweetData", store collection of those in new RDD
    val tweetData = stream.map(status => TweetData(status.getId, status.getUser.getScreenName, status.getText.trim))
     tweetData.foreachRDD(rdd => {
    // data aggregated in the driver
     println(s"A sample of tweets I gathered over ${batchInterval_s}s: ${rdd.take(10).mkString(" ")} (total tweets fetched: ${rdd.count()})")
    })
    
    // start consuming stream
    ssc.start
    ssc.awaitTerminationOrTimeout(totalRuntime_s * 1000)
    ssc.stop(true, true)

    println(s"============ Exiting ================")
    System.exit(0)
}

case class TweetData(id: Long, author: String, tweet: String)
