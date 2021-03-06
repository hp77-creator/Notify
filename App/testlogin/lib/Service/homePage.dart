import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:http/http.dart' as http ; 
import 'dart:convert';

String _usrId;
String get usrId => _usrId;

Future<List<TestApi>> fetchTestApi() async {
  final String url = 'http://192.168.1.109:8000/auth/home/';
  final String tkn = TokenService.token;
  final response = 
      await http.get(
        url,
        headers: {'Authorization': 'Token $tkn'},
        );

  if (response.statusCode == 200){
    List<dynamic> body = jsonDecode(response.body);
    print('Success');
    print(response.body);
    List<TestApi> apis = body.map((dynamic item) => TestApi.fromJson(item)).toList();
    print(apis[0].userId);
    _usrId = apis[0].userId;
    return apis;
  } else{
    print('NO return');
  }
}

class TestApi{
  final String username;
  final String userId;

  TestApi({
    @required this.username, 
    @required this.userId,
    });

  factory TestApi.fromJson(Map<String, dynamic> json){
    return TestApi(
      username: json["username"],
      userId: json["userId"],
    );
  }
}