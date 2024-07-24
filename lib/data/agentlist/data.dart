import 'dart:developer';

import 'package:call_match/data/agentlist/url.dart';
import 'package:call_match/data/model_agent_list/model_agent_list.dart';
import 'package:call_match/data/wallet_details/wallet_details.dart';
import 'package:dio/dio.dart';

abstract class ApiCalls {
  Future<List<ModelAgentList>> getAgentModelList();
  Future<WalletDetails> getWalletDetails();
}

class ApiCallFunctions extends ApiCalls {
  final dio = Dio();
  final url = Url();

// singleton ctration start
  ApiCallFunctions._internal();
  static ApiCallFunctions instance = ApiCallFunctions._internal();
  ApiCallFunctions factory() {
    return instance;
  }
// singleton end

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
}
