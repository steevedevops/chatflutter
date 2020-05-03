class Mensagem {
  String model;
  int pk;
  FieldsMensagem fields;

  Mensagem({this.model, this.pk, this.fields});

  Mensagem.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields =
        json['fields'] != null ? new FieldsMensagem.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fields != null) {
      data['fields'] = this.fields.toJson();
    }
    return data;
  }
}

class FieldsMensagem {
  int menId;
  int menEnviado;
  String menMensagem;
  String menDatacriacao;
  String menDatalido;
  String menDataalterado;
  int menFrom;
  int menDest;

  FieldsMensagem(
      {
      this.menId,
      this.menEnviado,
      this.menMensagem,
      this.menDatacriacao,
      this.menDatalido,
      this.menDataalterado,
      this.menFrom,
      this.menDest});

  FieldsMensagem.fromJson(Map<String, dynamic> json) {
    menId = json['men_id'];
    menEnviado = json['men_enviado'];
    menMensagem = json['men_mensagem'];
    menDatacriacao = json['men_datacriacao'];
    menDatalido = json['men_datalido'];
    menDataalterado = json['men_dataalterado'];
    menFrom = json['men_from'];
    menDest = json['men_dest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['men_id'] = this.menId;
    data['men_enviado'] = this.menEnviado;
    data['men_mensagem'] = this.menMensagem;
    data['men_datacriacao'] = this.menDatacriacao;
    data['men_datalido'] = this.menDatalido;
    data['men_dataalterado'] = this.menDataalterado;
    data['men_from'] = this.menFrom;
    data['men_dest'] = this.menDest;
    return data;
  }
}
