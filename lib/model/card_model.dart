class CardModel {
  int number;
  String itemcount;
  get getNumber => this.number;

  set setNumber(number) => this.number = number;

  get getItemcount => this.itemcount;

  set setItemcount(itemcount) => this.itemcount = itemcount;

  CardModel({required this.number, required this.itemcount});
}
