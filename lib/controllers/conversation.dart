import 'package:morse/db/database-helper.dart';
import 'package:morse/models/mensagem.dart';
import 'package:morse/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProprietarioConversations{

  // Future<MensagemPaginator> list(limit, offset, imovel, imobiliaria) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Services servicesApi = new Services(prefs.getString('sessionid'));

  //   var params = {
  //     'limit': '${limit}',
  //     'page': '${offset == 0 ? 1 : offset}',
  //     'imobiliaria': '${imobiliaria}',
  //     'imovel': '${imovel}'
  //   };
  //   var responseBody = await servicesApi.callAPI('get', 'api/proprietario/mensagem/', params);

  //   if (responseBody['status_api'] == true) {
  //     return MensagemPaginator.fromJson(responseBody);
  //   }else{
  //     return null;
  //   } 
  // }

  // Future<List<MessagesList>> listConversations(limit, offset) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Services servicesApi = new Services(prefs.getString('sessionid'));

  //   var params = {
  //     'limit': '${limit}',
  //     'page': '${offset == 0 ? 1 : offset}'
  //   };

  //   print('Chamando vc como registro');
  //   var responseBody = await servicesApi.callAPI('get', 'api/proprietario/listmensagens/', params);
  //   return MessagesList.fromJsonList(responseBody['mensagens']);
  // }


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