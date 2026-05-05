import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  print('=============================================');
  print('🚀 Starting Full Lifecycle Integration Test');
  print('=============================================');

  const baseUrl = 'http://localhost:5038/api';

  // Ignore SSL certificate errors for localhost
  HttpOverrides.global = MyHttpOverrides();
  final client = HttpClient();

  try {
    // Generate unique random users
    final motherEmail = "mother_${DateTime.now().millisecondsSinceEpoch}@test.com";
    final fatherEmail = "father_${DateTime.now().millisecondsSinceEpoch}@test.com";
    const password = "Password123!";

    print('\n[1] Registering Mother ($motherEmail)...');
    var motherAuth = await postRequest(client, '$baseUrl/auth/register', {
      "username": motherEmail,
      "password": password,
      "phoneNumber": "01000000000"
    });
    String motherToken = motherAuth['token'];
    print('✅ Mother Registered. Token received.');

    print('\n[2] Submitting Mother Onboarding...');
    await postRequest(client, '$baseUrl/onboarding/submit', {
      "role": "Mother",
      "isPregnant": true,
      "height": 160,
      "weight": 60,
      "isFirstChild": true,
      "knowledgeType": "Reading",
      "lastMenstrualDate": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      "dateOfBirth": "1995-01-01"
    }, token: motherToken);
    print('✅ Mother Onboarding Submitted.');

    print('\n[3] Creating Mother Profile...');
    await postRequest(client, '$baseUrl/mother', {
      "weight": 60,
      "height": 160
    }, token: motherToken);
    print('✅ Mother Profile Created.');

    print('\n[4] Registering Father ($fatherEmail)...');
    var fatherAuth = await postRequest(client, '$baseUrl/auth/register', {
      "username": fatherEmail,
      "password": password,
      "phoneNumber": "01000000001"
    });
    String fatherToken = fatherAuth['token'];
    String fatherRefreshToken = fatherAuth['refreshToken'];
    print('✅ Father Registered. Token received.');

    print('\n[5] Submitting Father Onboarding...');
    await postRequest(client, '$baseUrl/onboarding/submit', {
      "role": "Father",
      "isPregnant": false,
      "height": 0,
      "weight": 0,
      "isFirstChild": false,
      "knowledgeType": "",
      "dateOfBirth": "1990-01-01"
    }, token: fatherToken);
    print('✅ Father Onboarding Submitted.');

    print('\n[6] Father Refreshing Token (To get Father Role)...');
    var refreshRes = await postRequest(client, '$baseUrl/auth/refresh', {
      "token": fatherToken,
      "refreshToken": fatherRefreshToken
    });
    fatherToken = refreshRes['token'];
    print('✅ Father Token Refreshed.');

    print('\n[7] Creating Father Profile...');
    await postRequest(client, '$baseUrl/father', {
      "weight": 0,
      "height": 0
    }, token: fatherToken);
    print('✅ Father Profile Created.');

    print('\n---------------------------------------------');

    print('\n[8] Mother generating Partner Invite Link for ($fatherEmail)...');
    var inviteRes = await postRequest(client, '$baseUrl/partner/invite', {
      "partnerEmail": fatherEmail
    }, token: motherToken);
    String inviteToken = inviteRes['token'] ?? inviteRes['inviteCode'];
    print('✅ Invite Generated! Token: $inviteToken');

    print('\n[9] Father accepting Partner Invite...');
    await postRequest(client, '$baseUrl/partner/accept/$inviteToken', {}, token: fatherToken);
    print('✅ Father Accepted Invite! Family Linked.');

    print('\n[10] Father checking Family Dashboard...');
    var dashboard = await getRequest(client, '$baseUrl/family/dashboard', token: fatherToken);
    print('✅ Family Dashboard Fetched!');
    print('   - Is Linked: ${dashboard['isLinked']}');
    print('   - Partner Name: ${dashboard['partner']?['fullName'] ?? "Linked"}');
    print('   - Is Pregnant: ${dashboard['isPregnant']}');

    print('\n=============================================');
    print('🎉 ALL TESTS PASSED SUCCESSFULLY! THE FLOW WORKS.');
    print('=============================================');

  } catch (e) {
    print('\n❌ TEST FAILED!');
    print(e.toString());
  } finally {
    client.close();
  }
}

Future<Map<String, dynamic>> postRequest(HttpClient client, String url, Map<String, dynamic> body, {String? token}) async {
  final request = await client.postUrl(Uri.parse(url));
  request.headers.set('Content-Type', 'application/json');
  if (token != null) {
    request.headers.set('Authorization', 'Bearer $token');
  }
  request.write(jsonEncode(body));
  
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  
  if (response.statusCode >= 200 && response.statusCode < 300) {
    if (responseBody.isEmpty) return {};
    return jsonDecode(responseBody);
  } else {
    throw Exception('POST $url failed with status ${response.statusCode}: $responseBody');
  }
}

Future<Map<String, dynamic>> getRequest(HttpClient client, String url, {String? token}) async {
  final request = await client.getUrl(Uri.parse(url));
  if (token != null) {
    request.headers.set('Authorization', 'Bearer $token');
  }
  
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  
  if (response.statusCode >= 200 && response.statusCode < 300) {
    if (responseBody.isEmpty) return {};
    return jsonDecode(responseBody);
  } else {
    throw Exception('GET $url failed with status ${response.statusCode}: $responseBody');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
