import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/data_state.dart';

final firebaseServiceProvider = Provider<FirebaseService>(
    (ref) => FirebaseService(firebaseFirestore: FirebaseFirestore.instance));

class FirebaseService {
  final FirebaseFirestore firebaseFirestore;

  FirebaseService({required this.firebaseFirestore});

  Future<DataState<String>> createBoard(BoardModel board) async {
    try {
      await firebaseFirestore
          .collection('boards')
          .doc(board.uid)
          .set(board.toJson());
      return const DataSuccess('Board created successfully');
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  Stream<List<BoardModel>> getBoards() {
    try {
      return firebaseFirestore.collection('boards').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => BoardModel.fromJson(doc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DataFailed(e);
    }
  }

  Stream<BoardModel> getBoard(String boardUid) {
    try {
      return firebaseFirestore
          .collection('boards')
          .doc(boardUid)
          .snapshots()
          .map((doc) {
        return BoardModel.fromJson(doc.data()!);
      });
    } on FirebaseException catch (e) {
      throw DataFailed(e);
    }
  }

  Future<DataState<String>> updateBoard(BoardModel board) async {
    try {
      await firebaseFirestore
          .collection('boards')
          .doc(board.uid)
          .update(board.toJson());
      return const DataSuccess('Board updated successfully');
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<String>> deleteBoard(String boardUid) async {
    try {
      await firebaseFirestore.collection('boards').doc(boardUid).delete();
      return const DataSuccess('Board deleted successfully');
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }
}
