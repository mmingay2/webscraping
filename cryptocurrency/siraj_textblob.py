import tweepy

from textblob import TextBlob

consumer_key = '0gAayYK2Vwe8F4iSXi2iH3Pab'
consumer_secret = 'fWflsGfauTizCsC8t7bCfcVLqm25MPEqmuKBmgDDLFALaZjzPK'
access_token = '771729361-bzOsfxYRYU9fiAgrm9X7vBisoDxJVs9ertkxidIt'
access_secret = 'uTUeYxTEvpVtzCJ0rqFinrBNYzJpNOYqVhakb80ArFrYC'
 
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

api = tweepy.API(auth)

public_tweets = api.search('bitcoin')

for tweet in public_tweets:
	print(tweet.text)
	analysis = TextBlob(tweet.text)
	print(analysis.sentiment)
