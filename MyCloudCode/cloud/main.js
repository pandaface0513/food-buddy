// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});
  
Parse.Cloud.define("findAllPost", function(request, response) {
  var query = new Parse.Query("PostDataBase");
  //query.equalTo("name", request.params.username);
  query.descending("createdAt");
  query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
 
  // getRestaurantInfo(request.params.username,{
  //   success: function(things) {
  //    var findResult = [];
  //    // for (var i = 0; i < results.length; ++i){
  //    //    findResult.push(results[i]);
  //    // }
  //     response.success(things);
  //   },
  //   error: function() {
  //     response.error("username lookup failed");
  //   }
  // });
});
 
Parse.Cloud.define("findTime", function(request, response) {
  var query = new Parse.Query("PostDataBase");
  query.lessThan("createdAt", request.params.date);
  query.descending("createdAt");
  query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
 
});
 
//Need to be tested
Parse.Cloud.define("findAllPost123", function(request, response) {
  var query = new Parse.Query("TestingDataBase");
  var query1 = new Parse.Object.extend("User");
  var followers = query1.get("follower");
   
  //query.equalTo("name", request.params.username);
  query.descending("createdAt");
  query.containedIn("objectId", followers);
  query.limit(10);
  query.find({
    success: function(results) {
    
      response.success(result);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
 
  // getRestaurantInfo(request.params.username,{
  //   success: function(things) {
  //    var findResult = [];
  //    // for (var i = 0; i < results.length; ++i){
  //    //    findResult.push(results[i]);
  //    // }
  //     response.success(things);
  //   },
  //   error: function() {
  //     response.error("username lookup failed");
  //   }
  // });
});
 
//need to be tested
Parse.Cloud.define("findTime123", function(request, response) {
  var query = new Parse.Query("TestingDataBase");
  var query1 = new Parse.Object.extend("User");
  var followers = query1.get("follower");
  query.lessThan("createdAt", request.params.date);
  query.descending("createdAt");
  query.containedIn("objectId", followers);
  query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
 
});
//need test
Parse.Cloud.define("findPost", function(request, response) {
  var query = new Parse.Query("PostDataBase");
  //query.equalTo("name", request.params.username);
  query.descending("updatedAt");
  query.limit(10);
  query.find({
    success: function(results) {
     var findPhotoResult ;
     var findCommentsResult ;
     var totalResult = [];
     for (var i = 0; i < results.length; ++i){
 
        Parse.Cloud.run('findPostPhoto', { PostId: results[i].id}, {
          success: function (result){
            findResult = result;
          },
          error: function(error){
          }
        });
 
        Parse.Cloud.run('findPostComments', { PostId: results[i].id}, {
          success: function (result){
            findResult = result;
          },
          error: function(error){
          }
        });
        totalResult.push([results[i],findPhotoResult,findCommentsResult]);
    }
      response.success(totalResult);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//working
Parse.Cloud.define("findUser", function(request, response) {
  var query = new Parse.Query("User");
  query.equalTo("username", request.params.username);
  //query.descending("updatedAt");
  //query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//should work...verify database name before using
Parse.Cloud.define("findPostPhoto", function(request, response) {
  var query = new Parse.Query("PhotoDataBase");
  query.equalTo("PostId", request.params.PostId);
  // query.descending("updatedAt");
  // query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//need test
Parse.Cloud.define("findFeaturePost", function(request, response) {
  var query = new Parse.Query("RestaurantDataBase");
  query.equalTo("name", request.params.username);
  query.descending("updatedAt");
  query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//working
Parse.Cloud.define("findFriends", function(request, response) {
  var query = new Parse.Query("User");
  query.get(request.params.username).then(function(result){
 
    //test with string
 
     // var findResult = result.get("friendsList");
     // var find = findResult.split(",");
     // Parse.Cloud.run("getFriendPost",{ friend:find},{
     //  success :function(output){
     //    response.success(output);
     //  },
     //  error: function(error){
     //    response.error("hi");
     //  }
     // });
     //response.success(find);
 
     //test with array
 
     var findResult = result.get("friends");
      
     Parse.Cloud.run("getFriendPost",{ friend:findResult},{
      success :function(output){
        response.success(output);
      },
      error: function(error){
        response.error("hi");
      }
     });
 
     //response.success(findResult);
 
  });
   
});
 
//not yet constructed
Parse.Cloud.define("findPreference", function(request, response) {
  var query = new Parse.Query("RestaurantDataBase");
  query.equalTo("name", request.params.username);
  //query.descending("updatedAt");
  //query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//need test
Parse.Cloud.define("getLocation", function(request, response) {
  var query = new Parse.Query("RestaurantDataBase");
   
    //response.success(result.get("geoLocation"))
 
  query.equalTo("name", request.params.username);
  // // // query.descending("updatedAt");
  // // // query.limit(10);
  // query.find({
  //   success: function(results) {
  //     var location = results[0].get("geoLocation");
  //     response.success(location);
  //   },
  //   error: function() {
  //     response.error("username lookup failed");
  //   }
  // });
 
  query.find().then(function(result){
    var location = result[0].get("geoLocation");
    Parse.Cloud.run("findNearestLocation",{ restaurantLoc:location},{
      success :function(output){
        response.success(output);
      },
      error: function(error){
        response.error("hi");
      }
    });
    //response.success(location);
  });
   
});
//need test
Parse.Cloud.define("findNearestLocation", function(request,response) {
  var query = new Parse.query(RestaurantDataBase);
  // query.near("geoLocation", request.params.restaurantLoc)
  // query.limit(10);
  // query.find({
  //   success :function(output){
  //       response.success(output);
  //     },
  //     error: function(error){
  //       response.error("hi");
  //     }
  // });
    response.success(request.params.restaurantLoc);
});
 
//need test
Parse.Cloud.define("addFollowing", function(request, response) {
  var query = new Parse.Query("FriendDataBase");
  query.equalTo("name", request.params.username);
  query.descending("updatedAt");
  query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
 
//working..need to change database name
Parse.Cloud.define("findPostComments", function(request, response) {
  var query = new Parse.Query("CommentsDataBase");
  query.equalTo("PostId", request.params.PostId);
  // query.descending("updatedAt");
  // query.limit(10);
  query.find({
    success: function(results) {
     var findResult = [];
     for (var i = 0; i < results.length; ++i){
        findResult.push(results[i]);
     }
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
});
//working
Parse.Cloud.define("getFriendPost", function(request,response) {
  var query = new Parse.Query("User");
  
  query.containedIn("objectId", request.params.friend);
   query.find({
    success: function(results) {
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
   
  //response.success(request.params.friend);
});
 
  
Parse.Cloud.define("sample", function(request, response) {
  var arr = ["a", "b", "C"];
  response.success(arr[0]);
  
});




//****************************************************************************************************
Parse.Cloud.define("findRandomRestaurant",function(request,response){
  var query = new Parse.Query("RestaurantDataBase");
  var geoLocation = request.params.geoLocation;
  var rangeKiloRadius = request.params.rangeKiloRadius;
  if (rangeKiloRadius==null)
      rangeKiloRadius=40;
  restaurantquery.withinKilometers("geoLocation",geoLocation,rangeKiloRadius);
  query.find().then(
    function(results){
      var arrayLength = results.length;
      var random = Math.floor(Math.random()*array.lenth);
      response.success(results[random]);
    },function(error){
      response.error("error getting randomr restaurant");
    }
  )
})

Parse.Cloud.define("findBestSuitedRestaurants",function(request,response){
  //get all prefreference for every user here
  var preferenceCount = {}
  var restaurantList = []
  var rangeKiloRadius = 40;
  var preferencequery = new Parse.Query(Parse.User);
  preferencequery.containedIn("objectId", request.params.userIds)
  preferencequery.find().then(
    function(results){
      var preferenceCount = {};
      for (var i = 0; i < results.length; i++){
        //for (var j = 0; j<results[i]["preference"].length;j++)
        for (preference in results[i]["preference"]){
          if (preferenceCount[preference]==null)
            preferenceCount[preference] = 1;
          else
            preferenceCount[preference] += 1;
        }
      }
      return preferenceCount;
    },function(error){
      response.error("error finding preferenceCount");
    }
  ).then(function(results){

  //get all restaurants thats near
    var restaurantquery = new Parse.Query("RestaurantDataBase");
    var geoLocation = request.params.geoLocation;
    rangeKiloRadius = request.params.rangeKiloRadius;
    if (rangeKiloRadius==null)
      rangeKiloRadius=40;
    restaurantquery.withinKilometers("geoLocation",geoLocation,rangeKiloRadius)
    return restaurantquery.find().then(
      function(results){
        restaurantList = results;
        return results;
      },function(error){
        response.error("error finding restaurantList");
      }
    )
  }).then(function(results){
    var userLocation = request.params.geoLocation;
    var resultList = []
    for (var i =0;i<restaurantList.length;i++){
    //for (var restaurant in restaurantList){
      var restaurant = restaurantList[i];
      var distance = userLocation.kilometersTo(restaurant.get("geoLocation"));
      var score = scoreCalculator(restaurant,preferenceCount,distance,rangeKiloRadius);
      var name = restaurant.get("name");
      var objectId = restaurant.id;
      var imageUrl = restaurant.get("imagePFFile").url();

      var result = {
        "objectId":objectId,
        "name":name,
        "distance":distance,
        "score":score,
        "imageUrl":imageUrl
      };

      resultList.push(result);
    }

    //conclude analysis
    resultList.sort(function(a,b) {return b["score"]-a["score"]});
    response.success(resultList);
  },function(error){
    response.error("not able to perform analysis")
  })
})

function scoreCalculator(restaurant, preferenceCount,distance,range){
  var preference;
  var preferenceMatch=0;
  var userRating=0;
  var score=0;
  if(!preferenceCount){
    if (restaurant.hasOwnProperty("preference")){
      preference = restaurant["preference"];
      preferenceMatch=0;
      for (var key in preferenceCount){
        if (preferenceCount.hasOwnProperty(key)){
          preferenceMatch=preferenceMatch+preferenceCount[key];
        }
      }
    }
  }
  if (restaurant.hasOwnProperty("rating"))
    userRating=restaurant["rating"];
  score = preferenceMatch * 5 + (range-distance) / 5 + userRating * 5;
  return score;
}