import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class DetailScreen extends StatelessWidget {
  final int? tramiteId;
  final String institutionCode;
  final String institutionName;

  const DetailScreen({
    super.key,
    this.tramiteId,
    this.institutionCode = 'RENAP',
    this.institutionName = 'RENAP',
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: Text(l10n.navServices),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: tramiteId != null
            ? ApiService.getTramitePorId(tramiteId!, currentLang)
            : ApiService.getTramitesPorInstitucion(institutionCode, currentLang).then(
                (list) => list.isNotEmpty ? list.first : null,
              ),
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
                    : 'Error al obtener información:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final tramite = snapshot.data as Map<String, dynamic>?;

          if (tramite == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  currentLang == 'quc'
                      ? "Ma xriqitaj taj rutzijol wa' jun patanib'al."
                      : "No se encontró información registrada para este trámite.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          final titulo = tramite['titulo'] ?? '';
          final requisitos = List<String>.from(tramite['requisitos'] ?? []);
          final documentos = List<String>.from(tramite['documentos'] ?? []);
          final telefono = tramite['contacto_telefono'] ?? '1517';
          final web = tramite['contacto_web'] ?? 'www.gob.gt';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3D6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              institutionName,
                              style: const TextStyle(
                                color: Color(0xFFB45309),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentLang == 'quc' ? "Q'atal tzij patanib'al" : "Servicio Oficial",
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (requisitos.isNotEmpty) ...[
                  Row(
                    children: [
                      const Icon(Icons.assignment_outlined, color: Color(0xFF0D5C58)),
                      const SizedBox(width: 8),
                      Text(
                        l10n.detailRequirements,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D5C58),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...requisitos.map((req) => _buildRequirementCard(req)),
                  const SizedBox(height: 24),
                ],
                if (documentos.isNotEmpty) ...[
                  Row(
                    children: [
                      const Icon(Icons.folder_open_outlined, color: Color(0xFF0D5C58)),
                      const SizedBox(width: 8),
                      Text(
                        l10n.detailProcedure,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D5C58),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...documentos.map((doc) => _buildBulletPoint(doc)),
                  const SizedBox(height: 24),
                ],
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2F1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentLang == 'quc' 
                            ? "B'e rech ch'a'wib'al q'atal tzij:" 
                            : "Canales de contacto oficial:",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D5C58),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0D5C58)),
                          const SizedBox(width: 8),
                          Text("${l10n.phone}: $telefono"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.language_outlined, size: 18, color: Color(0xFF0D5C58)),
                          const SizedBox(width: 8),
                          Text(web),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    currentLang == 'quc'
                        ? "Q'alajisam tzij pa uk'olib'al"
                        : "Información oficial en tiempo real",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequirementCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: Colors.orange),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}