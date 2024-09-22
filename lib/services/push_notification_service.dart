import 'dart:convert';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "isf-7bbaa",
      "private_key_id": "fc0b47faa24cb46d96375c86312122a2fa7da7bd",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDDNqWircSjXWz7\nHMaVGv7SkiaA5hTlRf1UmZ9R6PrLWruMi4wgkDR4fRtD80nLIC5MfOWa27TeLgXJ\nrc0ez1l3C/M7GYckUIpQRvFe6UPex8P7se6+Q22pVVUIyXvrmiy5j/ieTGRtMzty\n5YCrtaeEnnu4KPUHsLshijGMUASCgi/+0GWhHVLd9+syKh32HD6X9OPjk+TKyafW\nhNbEWtLsiFRDgzqXrTIf+zsRsfumG+ZzPhlG7GaxUCo+U5e6bNYLlR0+jg2wFKIj\nm+PYjvsm5laAhabGnW5j8yoGJ0HyNfKvNxvJib+Ih1CABro00uab6VnGJt1Tv3vA\nvYmUWgPhAgMBAAECggEAA90EACkyOA10R6/1GiRToLU1v91N0o/FCLSVm5hhxj6A\ncbKdTlOsRiorrPeWoUd8wxTBsoPgm3kLskcXRSHTYnDBGo1RyF0zr40H39n79t+7\nODL4R5msBOrkaO0b37jIY8++mttmLWcTKR3zovJQY2aDikx9NO7BdVN30ZAP1slV\n6ajZ9SsX6uKVoc59L0BkpBpH4SWKvztDPIryA7akD6rMyvUg5axYFMsGfH33XCFo\nkRnBo+PxQOI8+NuB5Vnd8fDD/G2evkkVsGO4NqEqZk4w+tmgGMuxQGCx23Wk2Kal\nH1VrL7PL4VRba+O0Jxoqx0Xs79gf0b3xOgCzzHcT1QKBgQD0W9ihKZws1YTC+1aE\nzkV0ti6Ux+9/wlL01Eid+tzsug4GcC3qnh86NnSkK6i59rolYy7Ut+qZfDsJPUKD\neR0k+0wo3+LWZJS5dubWmEzo97HuCYUW7vHtZo2w3yZHByrmIAVqruaNdWTL6Q/y\n1FqULvo+1EMG9UswhQKKjO01gwKBgQDMg28PRPcp/Bz/ehvXLwcq5PK5BBIoe4iR\nficwkIR1Cdhc38icM7vPBxyKwaER5n8Gowr6BOynWFD2jITKqS3hqCBPIC1zth42\nJptGBvGI6c7mL9OR7jZy9k0mORBQuDhLIe/cs2lyMqsnLlQha3XHlNznrAGCtPQB\nB6L0iO4HywKBgDjgH93zJ2ywDgSsJ4kl0bjGprTujGo6OsDNoFFVEJLxA06wUZ+o\nSjBseF2148HVEaKeIUpVvH8ZEUynO5IKYKQ48ZMZ+VxZcNxyNmyAanZXIMz83kNm\nPl05X4VpiylBG9UQYvJf3z3RszJa/uFQV/zhqlFxamB2O5gBfYPuJVAtAoGAQgDd\nNAFe/5bVSQKAv7b2yjovt9R/g78yuToMrdjGVvuBb5/tn7P2lf9Gj+Wj9SH9tweh\nwEUcl3miT5/UL4/gNebL3p2U7bZGE9Xr4PLWuwgydQnUb1GBEyM4jPB3uoVp7Z2b\nSxBAJNIDeNaz4kFLNsltbfuOVT/PTBHJ3r/eincCgYBA4KFuvsjq7FRv7iXe35C5\nhWrO2sckkMOnhEBxPYj4ku7uNJ9xcQvLDT9aLb2wkua4SFO3RjFMAe0mCXKynXK2\nLTrKaV0uWZc6Fv4wYSBl2U16yRp7gGVxEWMYerXdWRguYfapbHKsnr1YCJY+J31W\nEJCXCHZg4WqDxQLYJ5XF4g==\n-----END PRIVATE KEY-----\n",
      "client_email": "fcm-for-news-app@isf-7bbaa.iam.gserviceaccount.com",
      "client_id": "110614875803833363563",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/fcm-for-news-app%40isf-7bbaa.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = <String>[
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  sendNotificationToUsers(newsTitle) async {
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessagingEndpoint =
        'https://fcm.googleapis.com/v1/projects/isf-7bbaa/messages:send';

    Map<String, dynamic> message = {
      "message": {
        // "token": token,
        "topic": "allUsers",
        "notification": {
          "title": "New News",
          "body": newsTitle,
        },
        // "data": {
        //   "click_action": "FLUTTER_NOTIFICATION_CLICK",
        //   "id": "1",
        //   "status": "done",
        // },
      }
    };
    var response =
        await http.post(Uri.parse(endpointFirebaseCloudMessagingEndpoint),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $serverKey',
            },
            body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Notification sending failed with status: ${response.statusCode}');
    }
  }
}
