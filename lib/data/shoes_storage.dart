import 'package:firebase_database/firebase_database.dart';
import 'package:learnflutternew/model/shoes_model.dart';

abstract class ShoesStorage {
  Future<List<ShoesModel>> load();
}

class AssetShoesStorage extends ShoesStorage {
  @override
  Future<List<ShoesModel>> load() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = (await databaseReference.once()).snapshot;

    List<ShoesModel> shoesList = [];
    dynamic snapshotValue = snapshot.value;

    // Kiểm tra xem snapshotValue có phải là null không trước khi sử dụng
    if (snapshotValue != null && snapshotValue is List) {
      List<dynamic> values = snapshotValue;
      values.forEach((value) {
        shoesList.add(ShoesModel.fromJson(value));
      });
    }
    // Kiểm tra xem shoesList có rỗng không trước khi trả về
    if (shoesList.isNotEmpty) {
      return shoesList;
    } else {
      // Nếu không có dữ liệu, bạn có thể trả về một giá trị mặc định hoặc một danh sách trống
      return []; // hoặc return null; tùy thuộc vào yêu cầu của bạn
    }
  }
}
