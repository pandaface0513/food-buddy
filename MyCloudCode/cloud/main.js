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
 
Parse.Cloud.define("findUser", function(request, response) {
  var query = new Parse.Query("UserDataBase");
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
 
Parse.Cloud.define("findFriendsPost", function(request, response) {
  var query = new Parse.Query("User");
  // query.get(request.params.username).then(function(result){
  //    var findResult = result.get("friends");
  //    Parse.Cloud.run("getFriendPost",{ friend:findResult[0]},{
  //     success :function(output){
  //       response.success(output);
  //     },
  //     error: function(error){
  //       response.error("empty");
  //     }
  //    });
  // });
   
 
    query.get(request.params.username).then(function(result){
     var findResult = result.get("friends");
     var find = findResult.split(",");
     Parse.Cloud.run("getFriendPost",{ friend:find},{
      success :function(output){
        response.success(output);
      },
      error: function(error){
        response.error("empty");
      }
     });
    //response.success(find[0]);
    });
   
     
  //response.success(friendList);
   
   
});
 
Parse.Cloud.define("findPreference", function(request, response) {
  var query = new Parse.Query("PreferenceDataBase");
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
 
Parse.Cloud.define("getFriendPost", function(request,response) {
  var query = new Parse.Query("User");
  // var result = [];
  // for(var i = 0; i < 2; ++i){
     
  //   result.push(query.include(request.params.friend));
  // }
   
 
  query.containsAll("objectId", request.params.friend);
   query.find({
    success: function(results) {
      response.success(results);
    },
    error: function() {
      response.error("username lookup failed");
    }
  });
   
  //response.success(request.params.friend[0]);
});

  
Parse.Cloud.define("sample", function(request, response) {
  var arr = ["a", "b", "C"];
  response.success(arr[0]);
  
});