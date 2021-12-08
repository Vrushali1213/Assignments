

class Parameter {
  String Name;
  String Image;
  String DateOfBirth;

  Parameter({
    this.Name,
    this.Image,
    this.DateOfBirth
  });

  Parameter.fromJson(Map<String, dynamic> json) {
    Name = json["name"];
    Image = json["img"];
    DateOfBirth = json["birthday"];
  }
}