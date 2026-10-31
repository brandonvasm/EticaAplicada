import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';
import '../l10n/app_localizations.dart';

class InstitutionsScreen extends StatelessWidget {
  final String? categoryTitle;

  const InstitutionsScreen({super.key, this.categoryTitle});

  IconData _getIconForCode(String code) {
    switch (code) {
      case 'CONAMIGUA':
        return Icons.shield_outlined;
      case 'RENAP':
        return Icons.article_outlined;
      case 'IGM':
        return Icons.flight_takeoff;
      case 'MSPAS':
        return Icons.medical_services_outlined;
      case 'MINTRAB':
        return Icons.business_center_outlined;
      case 'SBS':
        return Icons.favorite_outline;
      default:
        return Icons.account_balance_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: Text(categoryTitle ?? l10n.navInstitutions),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.getInstituciones(currentLang),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0D5C58)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                currentLang == 'quc'
                    ? 'Sachoj xk’ulwachij ruk’ utzukuxik rutzijol:\n${snapshot.error}'
                    : 'Error al conectar con el servidor:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final instituciones = snapshot.data ?? [];

          if (instituciones.isEmpty) {
            return Center(
              child: Text(
                currentLang == 'quc'
                    ? "Ma xriqitaj taj le moloj."
                    : "No se encontraron instituciones.",
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: instituciones.length,
            itemBuilder: (context, index) {
              final inst = instituciones[index];
              final codigo = inst['codigo'] as String;
              final nombre = inst['nombre'] as String;
              final descripcion = inst['descripcion'] as String;

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F2F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconForCode(codigo),
                          color: const Color(0xFF0D5C58),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nombre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              descripcion,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      institutionCode: codigo,
                                      institutionName: nombre,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    currentLang == 'quc' ? "Rilik nik'aj chik" : "Ver más",
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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