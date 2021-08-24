class CountryModel {
  String id ;
  String name;
  List<String>City;
  CountryModel(this.id,this.name,this.City);
  CountryModel.fromJson(Map map){
    this.id =map['id'];
    this.name =map['name'];
    this.City =map['City'];
  }
}