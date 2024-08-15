import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseServiceProvider = Provider<FirebaseService>(
    (ref) => FirebaseService(firebaseFirestore: FirebaseFirestore.instance));

class FirebaseService {
  final FirebaseFirestore firebaseFirestore;

  FirebaseService({required this.firebaseFirestore});

  Future<String> createBoard(BoardModel board) async {
    try {
      await firebaseFirestore.collection('boards').add(board.toJson());
      return 'Board created successfully';
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<BoardModel>> getBoards() {
    return firebaseFirestore.collection('boards').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => BoardModel.fromJson(doc.data()))
          .toList();
    });
  }
}
