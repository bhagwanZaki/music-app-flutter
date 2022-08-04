class MusicResponse<T> {
  late Status status;
  late T data;
  late String msg;

  MusicResponse.loading(this.msg) : status = Status.LOADING;
  MusicResponse.completed(this.data) : status = Status.COMPLETED;
  MusicResponse.error(this.msg) : status = Status.ERROR;

  @override
  String toString(){
    return "Status : $status \n Message : $msg \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
