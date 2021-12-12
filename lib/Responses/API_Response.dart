class API_Response {
  String message;
  int status;
  List<dynamic> error;
  List<dynamic> data;

  API_Response(
      {this.message, this.status, this.error = null, this.data = null});
}
