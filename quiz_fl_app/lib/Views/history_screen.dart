import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quiz_fl_app/Widgets/snackbar.dart';
import 'package:quiz_fl_app/l10n/app_localizations.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final loc = AppLocalizations.of(context);

    if (user == null) {
      return Scaffold(
        body: Center(child: Text(loc.userNotLoggedIn)),
      );
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('userPasswords')
            .where('uid', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return Center(
              child: Text(
                loc.noSavedPasswords,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final password = data['password'] ?? '';
              final note = data['note'] ?? '';
              final timestamp = data['createdAt'] as Timestamp?;
              final dateStr = timestamp != null
                  ? DateFormat('dd.MM.yyyy HH:mm').format(timestamp.toDate())
                  : loc.unknownDate;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              password,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: password));
                              showSnackBar(context, loc.passwordCopied);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final scaffoldMessenger = ScaffoldMessenger.of(context);
                              try {
                                await doc.reference.delete();
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text(loc.passwordDeleted)),
                                );
                              } catch (e) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text(loc.errorOccurred)),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (note.isNotEmpty)
                        Text("${loc.noteColon} $note"),
                      Text("${loc.createdAt} $dateStr"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
