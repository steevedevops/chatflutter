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

  // Future<bool> delete(int pk) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Services servicesApi = new Services(prefs.getString('sessionid'));

  //   var jsonDelete = {'pk': '${pk}'};
  //   var result = await servicesApi.callAPI(
  //       'delete', 'api/proprietario/mensagem/', jsonDelete);
  //   if (result['status_api'] == true) {
  //     prefs.setString('msg_api', result['msg']);
  //     await prefs.commit();
  //     return true;
  //   } else {
  //     print(result['msg']);
  //     prefs.setString('msg_api', result['msg']);
  //     await prefs.commit();
  //     return false;
  //   }
  // }

}