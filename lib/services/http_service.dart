import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fo/models/album.dart';
import 'package:fo/models/player.dart';
import 'package:fo/models/product_models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  // static var client = http.Client();
  static Future<List<ProductsModel>> fetchProducts() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<Album>> fetchAlbums(
      {String categoryid = "2", int page = 1}) async {
    debugPrint(
        dotenv.env['API_BASE_URL']! + "/albums/" + categoryid.toString());
    var response = await http.get(Uri.parse(dotenv.env['API_BASE_URL']! +
        "/albums/" +
        categoryid.toString() +
        "/" +
        page.toString()));
    if (response.statusCode == 200) {
      var data = response.body;
      return albumFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<Album> fetchAlbum(String id) async {
    // sleep(const Duration(seconds: 5));
    var response =
        await http.get(Uri.parse(dotenv.env['API_BASE_URL']! + "/album/" + id));
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<Player> fetchAudio(String id) async {
    // sleep(const Duration(seconds: 5));
    var response = await http
        .get(Uri.parse(dotenv.env['API_BASE_URL']! + "/fojing/" + id));
    if (response.statusCode == 200) {
      return Player.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<String> fetchLoginSMS(String phonenumber) async {
    var response = await http.post(
        Uri.parse(dotenv.env['API_BASE_URL']! + "/sendsms"),
        body: {'phonenumber': phonenumber});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  }

  static Future<String> login(String phonenumber) async {
    debugPrint('login post' + phonenumber);
    var response = await http.post(
        Uri.parse(dotenv.env['API_BASE_URL']! + "/login"),
        body: {'phonenumber': phonenumber, 'device_name': 'mobile'});
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return response.body;
    } else {
      throw Exception();
    }
  }

  static Future<Album> search(String keyword) async {
    // sleep(const Duration(seconds: 5));
    var response = await http.post(
        Uri.parse(dotenv.env['API_BASE_URL']! + "/search"),
        body: {'keyword': keyword});
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
