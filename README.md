# -iTunes-Search
Appetiser Mobile Coding Challenge

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


![](README%20Assets/Sample.gif)


### Requirements
```
iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
Xcode 10.1+
Swift 4.2+
```

### Installing

A step by step series of examples that tell you how to get a development env running

1. Clone or download the project. GO to directory and run Pod Install 

```
pod install
```

2. After you install all the dependency branch out to one of the branch below:

```
develop
release-1.0
```

3. Build and run

## Built With

* [Alamofire](https://github.com/Alamofire/Alamofire) - a HTTP networking library written in Swift.
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category

## Project information

In this project I tried to follow all the requirements based on the document Appetiser Provided:

* [Appetiser Mobile Coding Challenge](https://paper.dropbox.com/doc/Appetiser-Mobile-Coding-Challenge--AUkAzIn5_CxesHwwCHL_IMXIAg-CXlFaaY0PLqbl03RkHqkg)

For this project I used the MVC architecture pattern and userdefaults to save local copy of all the items on the watchlist tab once the user decided to close the application. I also used Alamofire to handle the network request and SDWebImage Library to handle the image caching. This is the only 3rd party dependency I used for this project.

Also I didn't use the Mainstoryboard for this project, just to showoff 🤣. I used XIB files to make some of the UI views and bind them programmatically. 





