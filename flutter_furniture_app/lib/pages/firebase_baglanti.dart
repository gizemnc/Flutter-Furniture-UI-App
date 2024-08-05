import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseBaglanti extends StatelessWidget {
   FirebaseBaglanti({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Connection Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Firestore bağlantısını test edin
              await FirebaseFirestore.instance.collection('test').get();
              if (kDebugMode) {
                print('Firebase bağlantısı başarılı.');
              }
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Firebase bağlantısı başarılı.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } catch (e) {
              if (kDebugMode) {
                print('Firebase bağlantısı başarısız: $e');
              }
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text('Firebase bağlantısı başarısız: $e'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text('Test Firebase Connection'),
        ),
      ),
    );
  }

  Scaffold analyticsConnection() {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Firebase Connection Test'),
    ),
    body: Center(
      child: ElevatedButton(
        onPressed: () async {
          await analytics.logEvent(
            name: 'test_event',
            parameters: <String, dynamic>{
              'string': 'test',
              'int': 42,
            },
          );
          if (kDebugMode) {
            print('Firebase Analytics olayı günlüğe kaydedildi.');
          }
        },
        child: const Text('Test Firebase Connection'),
      ),
    ),
  );
  }
  }
