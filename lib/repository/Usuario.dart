class Usuario {
  String _codigo="";
  String _email = "";
  String _senha = "";
  int _isCadastrado =0;

 int get isCadastrado => this._isCadastrado;

 set isCadastrado(int value) => this._isCadastrado = value;

  Usuario();
 String get codigo => this._codigo;

 set codigo(String value) => this._codigo = value;

  get email => this._email;

 set email( value) => this._email = value;

  get senha => this._senha;

 set senha( value) => this._senha = value;

  Usuario.fromJson(Map<String,dynamic> json)
    : _codigo = json['codigo'],
      _email = json['email'],
      _senha = json['senha'],
      _isCadastrado = json['isCadastrado'];
}