import '../../../../core/cubit/dio_interceptor.dart';
import 'tipmodel.dart';

class TipsService {
  Future<List<TipModel>> getDailyTips({int? week}) async {
    final response = await DioClient.dio.get(
      "/tips/daily",
      queryParameters: week != null ? {"week": week} : null,
    );

    final data = response.data as List;

    return data.map((e) => TipModel.fromJson(e)).toList();
  }
}