import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ayura/constants/constants.dart';
import 'package:ayura/provider/models/community_model.dart';
import 'package:ayura/provider/models/post_model.dart';

class CommunityProvider extends ChangeNotifier {
  bool isLoading = false; // For Loading animation
  final requestBaseUrl = AppUrls.baseUrl;
  CommunityModel _communityModel = CommunityModel(
    id: "",
    communityName: "",
    communityDescription: "",
    isPublic: true,
    categories: [],
    members: [],
  );
  List<CommunityModel> _communityList = [];
  List<PostModel> _postsList = [];

  PostModel _postModel = PostModel(
      id: "",
      caption: "",
      imageUrl: "",
      authorId: "",
      communityId: "",
      authorName: "");
  // Getters
  CommunityModel get communityModel => _communityModel;
  PostModel get postModel => _postModel;
  List<CommunityModel> get communityList => _communityList;
  List<PostModel> get postsList => _postsList;
  String get id => _communityModel.id;
  String get communityName => _communityModel.communityName;
  String get communityDescription => _communityModel.communityDescription;
  bool get isPublic => _communityModel.isPublic;
  List get categories => _communityModel.categories;
  List get members => _communityModel.members;

  void updateCommunityInfo(CommunityModel community) {
    _communityModel.id = community.id;
    _communityModel.communityName = community.communityName;
    _communityModel.communityDescription = community.communityDescription;
    _communityModel.isPublic = community.isPublic;
    _communityModel.categories = community.categories;
    _communityModel.members = community.members;
    notifyListeners();
  }

  //Get the communities from database
  Future<void> getCommunitiesList() async {
    final url = '$requestBaseUrl/api/communities';
    isLoading = true;
    notifyListeners();
    try {
      print('Inside getCommunitiesList');
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(req.body);
      print('API Response: $res');
      print('Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        _communityList = List<CommunityModel>.from(res.map<CommunityModel>(
          (communityData) => CommunityModel.fromJson(communityData),
        ));
        print('Community List Fetched: $_communityList');
        isLoading = false;
        notifyListeners();
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //Create community
  Future<void> createCommunity(CommunityModel community) async {
    final url = '$requestBaseUrl/api/communities/create';

    try {
      final body = community.toJson(); // Convert the community model to JSON
      print('JSON Body: ${json.encode(body)}');
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      final res = json.decode(req.body);
      print('Create Community Response: $res');
      print('Create Community Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        await getCommunitiesList(); // Fetch the updated community list
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
    notifyListeners();
  }

  //Get the community by id
  Future<void> getCommunityById(String communityId) async {
    final url = '$requestBaseUrl/api/communities/$communityId';
    isLoading = true;
    notifyListeners();
    try {
      print('Inside getCommunitiesList');
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(req.body);
      print('API Response: $res');
      print('Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        _communityModel = CommunityModel.fromJson(res);
        print('Community Fetched: $_communityModel');

        print('Community List Fetched: $_communityList');
        isLoading = false;
        notifyListeners();
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Submit Post
  Future<void> submitPost(PostModel newPost) async {
    final url = '$requestBaseUrl/api/communities/post';

    try {
      final body = newPost.toJson(); // Convert the community model to JSON
      print('JSON Body: ${json.encode(body)}');
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      final res = json.decode(req.body);
      print('Create POST Response: $res');
      print('Create POST Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        await getPostsList(newPost.communityId); // Fetch the updated posts list
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
    notifyListeners();
  }

  Future<void> getPostById(String postId) async {
    final url = '$requestBaseUrl/api/communities/post/$postId';
    isLoading = true;
    notifyListeners();
    try {
      print('Inside getCommunitiesList');
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(req.body);
      print('API Response: $res');
      print('Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        _postModel = PostModel.fromJson(res);
        print('Community Fetched: $_postModel');

        print('Community List Fetched: $_postModel');
        isLoading = false;
        notifyListeners();
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getPostsList(communityId) async {
    final url = '$requestBaseUrl/api/communities/posts/$communityId';
    isLoading = true;
    notifyListeners();
    try {
      print('Inside getPostsList');
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(req.body);
      print('API Response: $res');
      print('Status Code: ${req.statusCode}');

      if (req.statusCode == 200 || req.statusCode == 201) {
        _postsList = List<PostModel>.from(res.map<PostModel>(
          (postData) => PostModel.fromJson(postData),
        ));
        print('Posts List Fetched: $_postsList');
        isLoading = false;
        notifyListeners();
      } else {
        print("Error Occurred $res");
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
