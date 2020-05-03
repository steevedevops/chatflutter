class Usuario {
  String sessionid;
  String nomeCompleto;
  String email;
  bool logado;

  Usuario({this.sessionid, this.nomeCompleto, this.email, this.logado});

  Usuario.fromJson(Map<String, dynamic> json) {
    sessionid = json['sessionid'];
    nomeCompleto = json['nomeCompleto'];
    email = json['email'];
    logado = json['logado'];
  }

  Usuario.fromMap(Map json) {
    sessionid = json['sessionid'];
    nomeCompleto = json['nomeCompleto'];
    email = json['email'];
    logado = json['logado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['sessionid'] = this.sessionid;
    data['nomeCompleto'] = this.nomeCompleto;
    data['email'] = this.email;
    data['logado'] = this.logado;

    return data;
  }
}
