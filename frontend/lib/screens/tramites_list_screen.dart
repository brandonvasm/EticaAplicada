import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';
import '../l10n/app_localizations.dart';

class TramitesListScreen extends StatelessWidget {
  final String institutionCode;
  final String institutionName;

  const TramitesListScreen({
    super.key,
    required this.institutionCode,
    required this.institutionName,
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: Text("${l10n.navServices}: $institutionName"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.getTramitesPorInstitucion(institutionCode, currentLang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0D5C58)),
            );
          }

          final tramites = snapshot.data ?? [];

          if (tramites.isEmpty) {
            return Center(
              child: Text(
                currentLang == 'quc'
                    ? "Ma k'o taj patanib'al e k'o chanim."
                    : "No hay trámites disponibles para esta entidad.",
                style: const TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tramites.length,
            itemBuilder: (context, index) {
              final t = tramites[index];
              final int id = t['id'];
              final String titulo = t['titulo'];

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF0D5C58)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          tramiteId: id,
                          institutionName: institutionName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}