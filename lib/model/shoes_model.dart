class ShoesModel {
  int? id;
  String? name;
  String? image;
  int? price;

  List<String>? category;
  List<String>? gender;
  List<double>? size;

  ShoesModel(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.category,
      this.gender,
      this.size});

  ShoesModel.fromJson(Map<String, dynamic> json) {
    image = json['grid_picture_url'];
    id = json['id'];
    name = json['name'];
    price = json['retail_price_cents'];
    var categoryFromJson = json['category'];
    category = new List<String>.from(categoryFromJson);
    var genderFromJson = json['gender'];
    gender = new List<String>.from(genderFromJson);
    var sizeFromJson = json['size_range'];
    size = new List<double>.from(sizeFromJson);

    // category = json['category'];
    // gender = json['gender'];
    // size = json['size_range'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['grid_picture_url'] = this.image;
    data['id'] = this.id;
    data['name'] = this.name;
    data['retail_price_cent'] = this.price;
    data['category'] = this.category;
    data['gender'] = this.gender;
    data['size_range'] = this.size;
    return data;
  }
}
