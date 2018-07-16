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
    val conf = new SparkConf().setAppName("twitter popularity")

    // batch interval determines how often Spark creates an RDD out of incoming data
    val ssc = new StreamingContext(conf, Seconds(samplingFrequency))
    val stream = TwitterUtils.createStream(ssc, None)
   
    // extract desired data from each status during sample period as class "TweetData", store collection of those in new RDD
    val tweetData = stream.map(status => (status.getId, status.getUser.getScreenName, status.getText))

    val hashTagCounts = tweetData.flatMap({case (id, author, tweet) => (tweet.split(" ").filter(_.startsWith("#")))  })
                        .map((_, 1)).reduceByKey(_+_).map{case (a, b) => (b, a)}
                        .transform(_.sortByKey(false))
                        .map{case (a, b) => (b, a)}

    val tagAuthor = tweetData.map({case (id, author, tweet) => (author, tweet.split(" ").filter(_.startsWith("#")))})
                    .flatMap{ case (key, values) => values.map((key, _)) }
                    .map{case (topic, count) => (count, topic)}
                    .map{case (tag, user) => (tag, List(user))}
                    .reduceByKey(_ ++ _)

    val tagMention = tweetData.map({case (id, author, tweet) => (tweet, tweet.split(" ").filter(_.startsWith("#")))})
                    .flatMap({ case (key, values) => values.map((key, _)) })
                    .map{case (tweet, tag) => (tag, tweet.split(" ").filter(_.startsWith("@")).toList)}

    val tagAuthor_Count = tagAuthor.join(hashTagCounts)
                          .map{case (tag, (users, count)) => (count, (tag, users))}
                          .transform(_.sortByKey(false))

    val tagMention_Count = tagMention.join(hashTagCounts)
                          .map{case (tag, (mentioned, count)) => (count, (tag, mentioned))}
                          .transform(_.sortByKey(false))

    //print outputs
    tagAuthor_Count.foreachRDD(rdd => {println(s"Authors using popular tags over time period ${samplingFrequency}s: ${rdd.take(10).mkString(" ")}")})
    tagMention_Count.foreachRDD(rdd => {println(s"Users mentioned in popular tags over time period ${samplingFrequency}s: ${rdd.take(10).mkString(" ")}")})

    //collect windowed streams
    val windowed_tagAuthor_Count = tagAuthor_Count.window(Seconds(duration))
    val windowed_tagMention_Count = tagMention_Count.window(Seconds(duration))

    // start consuming stream
    ssc.start
    ssc.awaitTerminationOrTimeout(duration * 1000)
    ssc.stop(true, true)

    println(s"============ Exiting ================")
    System.exit(0)
}
