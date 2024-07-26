class Url {
  String baseUrl = "http://192.168.1.2:8000/";

  String agentList = "all_agents/";
  String normaluserList = "all_users/";
  String walletdetails = "wallet/${1}";
  String loginnumber = "login_user/";
  //String getChat = "get_chat/${1}/${2}";
  // Method to construct getChat URL
  String getChat(int user1, int user2) => "get_chat/$user1/$user2";
}
