

class FAQSModel {
  bool? status;

  /// this data is a map in the rest api
  FAQSDataModel? data;

  FAQSModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FAQSDataModel.fromJson(json['data']);
  }
}


///======================== FAQSDataModel ================================
///=======================================================================

class FAQSDataModel {
  int? currentPage;
  List<DataModel> data = [];

  FAQSDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

///========================== DataModel ==================================
///======================================================================
class DataModel {
  int? id;
  String? question;
  String? answer;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
