import 'package:morse/models/usersconversations.dart';
import 'package:morse/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Conversations{
  Future<bool> sendmessages(params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Services servicesApi = new Services(prefs.getString('sessionid'));

    var result = await servicesApi.callAPI('put', 'api/mensagem/', params);
    if (result['status_api'] == true) {
      prefs.setString('msg_api', result['msg']);
      await prefs.commit();
      return true;
    } else {
      prefs.setString('msg_api', result['msg']);
      await prefs.commit();
      return false;
    }
  }

  Future<List<ConversationsList>> listConversations(limit, offset) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Services servicesApi = new Services(prefs.getString('sessionid'));

    print(prefs.getString('sessionid'));

    var params = {
      'limit': '${limit}',
      'page': '${offset == 0 ? 1 : offset}'
    };
    var responseBody = await servicesApi.callAPI('get', 'api/usuarios/', params);
    return ConversationsList.fromJsonList(responseBody['troca_mensagem']);
  }

}