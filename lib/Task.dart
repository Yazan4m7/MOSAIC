class Task {
  int id;
  int order_id;
  String patient_name;
  DateTime deliver_date;
  String milled;
  String milled_by;
  String current_status;
  String total_status;
  String hidden;
  int made_by;
  int doctor_id;
  int lab_id;
  int service_id;
  int app_id;

  Task ({this.id,this.order_id,this.patient_name,this.deliver_date,this.milled,this.milled_by,this.current_status,this.total_status,this.hidden,
    this.made_by,this.doctor_id,this.lab_id,this.service_id,this.app_id});

  factory Task.fromJson(Map<String,dynamic> json){
    print ('id is ${json['id']}');
    return Task(
      id: int.parse(json['id']) ,
      order_id:int.parse(json['order_id']) ,
      patient_name:json['patient_name'] as String,
      deliver_date:DateTime.parse(json['deliver_date']),
      milled:json['milled'] ,
      milled_by:json['milled_by'] as String,
      current_status:json['current_status'] as String,
      total_status:json['total_status'] as String,
      hidden:json['hidden'],
      made_by:int.parse(json['made_by']),
      doctor_id:int.parse(json['doctor_id']),
      lab_id:int.parse(json['lab_id']),
      service_id:int.parse(json['service_id']),
      app_id:int.parse(json['app_id']),
    );

  }

}

