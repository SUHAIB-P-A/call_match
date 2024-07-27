class Url {
  String baseUrl = "http://10.0.2.2:8000/";

  String agentList = "all_agents/";
  String normaluserList = "all_users/";
  String updateptofile = "update_profile/";
  String walletdetails = "wallet/";
  String loginnumber = "login_user/";
  String sendMessage = "send_message/";
  //String getChat = "get_chat/${1}/${2}";
  // Method to construct getChat URL
  String getChat(int user1, int user2) => "get_chat/$user1/$user2";
}
