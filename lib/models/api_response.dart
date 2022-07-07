class ApiResponse <T>{
  T data;
  bool error;
  String errorMessage;

  ApiResponse({
    required this.data ,
    this.error = false,
    this.errorMessage = ''
  });
}