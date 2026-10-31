import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../l10n/app_localizations.dart';
import 'institutions_screen.dart';

class SituationScreen extends StatelessWidget {
  const SituationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLang = localeProvider.locale.languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        title: Text(
          l10n.situationTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSituationCard(
            context: context,
            icon: Icons.flight_takeoff,
            title: l10n.situationExtranjeroTitle,
            subtitle: l10n.situationExtranjeroSub,
            categoryKey: 'extranjero',
          ),
          const SizedBox(height: 12),
          _buildSituationCard(
            context: context,
            icon: Icons.home_outlined,
            title: l10n.situationRetornadoTitle,
            subtitle: l10n.situationRetornadoSub,
            categoryKey: 'retornado',
          ),
          const SizedBox(height: 12),
          _buildSituationCard(
            context: context,
            icon: Icons.people_outline,
            title: l10n.situationFamiliarTitle,
            subtitle: l10n.situationFamiliarSub,
            categoryKey: 'familiar',
          ),
        ],
      ),
    );
  }

  Widget _buildSituationCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String categoryKey,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F2F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF0D5C58)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF0D5C58)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstitutionsScreen(
                categoryTitle: title,
              ),
            ),
          );
        },
      ),
    );
  }
}