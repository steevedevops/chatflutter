import 'package:morse/models/Usuario.dart';
import 'package:morse/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate {

  Future <Usuario> dologin(Map params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Services servicesApi = new Services('');
    prefs.clear();

    var result = await servicesApi.callAPI('post', 'api/login/',params);

    if (result['status_api'] == true) {
      prefs.setString('nomeCompleto', result['nomeCompleto']);
      prefs.setString('email', params['email']);
      prefs.setString('sessionid', result['sessionid']);
      prefs.setInt('pk_userlogado', result['pk']);
      await prefs.commit();
      return new Usuario.fromMap(result);
    } else {
      prefs.setString('msg_api', result['msg']);
      await prefs.commit();
      return null;
    }
  }

  Future <bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Services servicesApi = new Services(prefs.getString('sessionid'));
    var result = await servicesApi.callAPI('get', 'api/geral/logout/', '');
    if (result['status_api'] == true) {
      return true;
    }
    return false;
  }

}