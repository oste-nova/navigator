import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navigator/Views/signin.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RemoteService {
  static const url = "https://softonauts.com/clients/Android/";

  errorHandler(error) {
    if (error.response == null) {
      throw Exception('No internet connection');
    }
    if (error.message != null) {
      throw Exception('Error in remote service: ' + error.message);
    }
    if (error.data['error']) {
      throw Exception(error.data['error']);
    }
  }

  Future<Response> httpRequestPost(endPoint, data) async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.post(
        url + endPoint,
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
      return errorHandler(response.data['error']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> httpRequestAuthPost(endPoint, data) async {
    Response response;
    var dio = Dio();

    response = await dio.post(url + endPoint,
        data: data,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MX0.By2r2BwheJsbrEGrHOaMQwrrmlY7wHVFzWtuEmv39fM',
          'content-type': 'application/json'
        }));
    return response;
  }

  Future register(first, middle, last, dob, gender, contact, email, add1, add2,
      city, state, zipcode, pass, ssn) async {
    const endPoint = 'register-user';
    var data = {
      'first_name': first,
      'middle_name': middle,
      'last_name': last,
      'dob': dob,
      'gender': gender,
      'contact_number': contact,
      'email': email,
      'address_one': add1,
      'address_two': add2,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'password': pass,
      'login_type': 'internal',
      'ssn_digits': ssn,
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }

  Future login(email, pass) async {
    const endPoint = 'users-login';
    var data = {
      'username': email,
      'password': pass,
      'fcm_id': '',
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }

  Future getkit() async {
    const endPoint = 'get-kit-request-navigator-list';
    var data = {
      'user_id': '96',
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }

  Future getsubmit() async {
    const endPoint = 'get-submit-sample-navigator-list';
    var data = {
      'user_id': '96',
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }

  Future getdrop() async {
    const endPoint = 'get-drop-in-navigator-list';
    var data = {
      'user_id': '96',
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }

  Future getslots() async {
    const endPoint = 'get-time-slots';
    var data = {
      'location_id': '16',
    };
    final response = await httpRequestAuthPost(endPoint, data);
  }
}
