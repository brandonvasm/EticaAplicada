import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onNavigateToServices;

  const HomeScreen({
    super.key,
    this.onNavigateToServices,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Estado para controlar si ya se aceptó el aviso de privacidad
  bool _privacyAccepted = false;

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // --- ENCABEZADO CON LOGO DE INFOG ---
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D5C58),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFFD97706),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appTitle,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D5C58),
                      ),
                    ),
                    const Text(
                      "SERVICIOS PÚBLICOS",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD97706),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TÍTULO PRINCIPAL
            Text(
              l10n.homeWelcome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 20),

            // SELECCIONA TU IDIOMA
            Row(
              children: [
                const Icon(Icons.language, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  l10n.selectLanguage,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // BOTONES ESPAÑOL Y K'ICHE'
            Row(
              children: [
                GestureDetector(
                  onTap: () => localeProvider.setLocale(const Locale('es')),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: currentLang == 'es'
                          ? Colors.white
                          : const Color(0xFFF7F9FA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: currentLang == 'es'
                            ? const Color(0xFF0D5C58)
                            : Colors.grey.shade300,
                        width: currentLang == 'es' ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "Español",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentLang == 'es'
                            ? const Color(0xFF0D5C58)
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => localeProvider.setLocale(const Locale('quc')),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: currentLang == 'quc'
                          ? Colors.white
                          : const Color(0xFFF7F9FA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: currentLang == 'quc'
                            ? const Color(0xFF0D5C58)
                            : Colors.grey.shade300,
                        width: currentLang == 'quc' ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "K'iche'",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentLang == 'quc'
                            ? const Color(0xFF0D5C58)
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // --- TARJETA DIRECTORIO DE APOYO ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.supportDirectory,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.supportDirectorySub,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D5C58),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (widget.onNavigateToServices != null) {
                        widget.onNavigateToServices!();
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.white, size: 20),
                    label: Text(
                      l10n.searchServices,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- AVISO DE PRIVACIDAD (SOLO APARECE SI NO SE HA ACEPTADO) ---
            if (!_privacyAccepted) ...[
              const Divider(height: 32, thickness: 1, color: Colors.black12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.privacyNoticeTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF3D6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Color(0xFFB45309), size: 16),
                    ),
                    onPressed: () {
                      setState(() {
                        _privacyAccepted = true;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.privacyNoticeBody,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.privacyNoticeDetail,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                l10n.securityTitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D5C58),
                ),
              ),
              const SizedBox(height: 12),

              _buildSecurityItem(l10n.securityRule1),
              _buildSecurityItem(l10n.securityRule2),
              _buildSecurityItem(l10n.securityRule3),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D5C58),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() {
                    _privacyAccepted = true;
                  });
                },
                icon: const Icon(Icons.check_box_outlined, color: Colors.white),
                label: Text(
                  l10n.acceptAndContinue,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D32),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}