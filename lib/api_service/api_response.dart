class ApiResponse<T> {
  int? status;
  List<String>? message;
  T? data;
  T? error;

  ApiResponse({this.status, this.message, this.data, this.error});

  @override
  String toString() {
    // TODO: implement toString
    return '${error ?? ''}';
  }
}
