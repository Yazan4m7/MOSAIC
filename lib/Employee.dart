class Employee {
  String id;
  String firstName;
  String lastName;

  Employee({this.id,this.firstName,this.lastName});

  factory Employee.fromJson(Map<String,dynamic>json){
  Employee emp= Employee(
    id: json['id'] as String,
    firstName:json['first_name'] as String,
    lastName:json['last_name'] as String,
  );
  //print ("emp to string ${emp.toString()}");


  return emp;
  }
  String toString(){

    return  (id  + firstName + lastName);
  }
}