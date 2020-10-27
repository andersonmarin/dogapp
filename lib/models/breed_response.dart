class BreedsResponse<T> {
  String status;
  T message;

  BreedsResponse({this.status, this.message});

  BreedsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
