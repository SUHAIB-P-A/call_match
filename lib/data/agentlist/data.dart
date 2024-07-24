import 'dart:developer';
import 'package:call_match/data/agentlist/url.dart';
import 'package:call_match/data/login_with_number/login_with_number.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/model_agent_list/model_agent_list.dart';
import 'package:call_match/data/wallet_details/wallet_details.dart';
import 'package:dio/dio.dart';

abstract class ApiCalls {
  Future<LoginedUser> loginWithNumber(String data);
  Future<List<ModelAgentList>> getAgentModelList();
  Future<WalletDetails> getWalletDetails();
}

class ApiCallFunctions extends ApiCalls {
  final dio = Dio();
  final url = Url();

  // Singleton creation start
  ApiCallFunctions._internal();
  static final ApiCallFunctions instance = ApiCallFunctions._internal();
  factory ApiCallFunctions() {
    return instance;
  }
  // Singleton end

  @override
  Future<List<ModelAgentList>> getAgentModelList() async {
    try {
      // Fetch data from the API
      final response = await dio.get(url.baseUrl + url.agentList);

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON data and convert it to a list of ModelAgentList
        final List<dynamic> data = response.data;
        final listdata = data
            .map(
                (item) => ModelAgentList.fromJson(item as Map<String, dynamic>))
            .toList();
//log(listdata.toString());
        return listdata;
      } else {
        // Handle non-successful response
        throw Exception('Failed to load agent list');
      }
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to load agent list: $e');
    }
  }

  @override
  Future<WalletDetails> getWalletDetails() async {
    try {
      // Fetch data from the API
      final response = await dio.get(url.baseUrl + url.walletdetails);

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON data and convert it to a WalletDetails object
        final Map<String, dynamic> data = response.data;
        final walletDetails = WalletDetails.fromJson(data);
        return walletDetails;
      } else {
        // Handle non-successful response
        throw Exception('Failed to load wallet details');
      }
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to load wallet details: $e');
    }
  }

  @override
  Future<LoginedUser> loginWithNumber(String data) async {
    try {
    final response = await dio.post(
      '${url.baseUrl}${url.loginnumber}',
      data: {'mobile_no': data},
    );

    if (response.statusCode == 200) {
      log('Response data: ${response.data}'); // Log the entire response data
      // Parse the JSON response and return the LoginedUser object
      final loginWithNumber = LoginWithNumber.fromJson(response.data);
      if (loginWithNumber.user != null) {
        log('User ID: ${loginWithNumber.user!.customerId}');
        return loginWithNumber.user!;
      } else {
        throw Exception('User data is missing in the response');
      }
    } else {
      throw Exception('Failed to log in with number');
    }
  } catch (e) {
    log('Error in loginWithNumber: $e');
    rethrow;
  }
  }
}
