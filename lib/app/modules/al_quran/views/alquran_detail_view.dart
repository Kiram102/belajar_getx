import 'package:belajar_getx/app/data/models/al_quran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AlquranDetailView extends StatelessWidget {
  final  surah; 

  const AlquranDetailView({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          _buildSurahInfoSection(),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[800],
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildGradientBackground(),
            _buildDecorativeElements(),
            _buildHeaderContent(),
          ],
        ),
      ),
      title: Text(
        surah.nama ?? "Unknown Surah",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showShareDialog(context),
          icon: const Icon(Icons.share_outlined),
          tooltip: 'Bagikan Surah',
        ),
        IconButton(
          onPressed: () => _showMoreOptions(context),
          icon: const Icon(Icons.more_vert),
          tooltip: 'Opsi Lainnya',
        ),
      ],
    );
  }

  Widget _buildGradientBackground() {
    return Hero(
      tag: 'surah_background_${surah.nomor}',
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade600,
              Colors.green.shade400,
              Colors.teal.shade400,
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeElements() {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          left: -30,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.03),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderContent() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSurahNumberCircle(),
          const SizedBox(height: 20),
          _buildSurahNames(),
          const SizedBox(height: 16),
          _buildSurahInfoChip(),
        ],
      ),
    );
  }

  Widget _buildSurahNumberCircle() {
    return Hero(
      tag: 'surah_icon_${surah.nomor}',
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '${surah.nomor ?? 0}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahNames() {
    return Column(
      children: [
        // Arabic name
        Text(
          surah.asma ?? 'غير معروف',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arabic',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Indonesian name
        Text(
          surah.nama ?? 'Tidak Diketahui',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSurahInfoChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${surah.ayat ?? 0} Ayat • ${_getSurahType()}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSurahInfoSection() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildSurahTypeBadge(),
              const Spacer(),
              _buildAyatCount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurahTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getSurahType(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAyatCount() {
    return Row(
      children: [
        Icon(
          Icons.format_list_numbered_outlined,
          size: 16,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Text(
          '${surah.ayat ?? 0} Ayat',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSurahTitle(context),
            const SizedBox(height: 24),
            _buildDivider(),
            const SizedBox(height: 24),
            _buildMeaningSection(context),
            const SizedBox(height: 24),
            _buildInfoCards(),
            const SizedBox(height: 32),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            _buildQuickFacts(),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahTitle(BuildContext context) {
    return Text(
      '${surah.nama ?? "Unknown"} (${surah.asma ?? "غير معروف"})',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
        height: 1.3,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 3,
      width: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade400],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildMeaningSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.translate_outlined,
                color: Colors.green.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Arti Surah',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            surah.arti ?? _getDefaultMeaning(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(child: _buildInfoCard(
          icon: Icons.format_list_numbered,
          value: '${surah.ayat ?? 0}',
          label: 'Ayat',
          color: Colors.blue,
        )),
        const SizedBox(width: 12),
        Expanded(child: _buildInfoCard(
          icon: surah.type == Type.MEKAH ? Icons.location_city : Icons.mosque,
          value: surah.type == Type.MEKAH ? 'Makkah' : 'Madinah',
          label: 'Diturunkan',
          color: Colors.orange,
        )),
        const SizedBox(width: 12),
        Expanded(child: _buildInfoCard(
          icon: Icons.tag,
          value: '${surah.nomor ?? 0}',
          label: 'Urutan',
          color: Colors.purple,
        )),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String value,
    required String label,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade100, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: value.length > 2 ? 14 : 20,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _copyToClipboard(context),
            icon: const Icon(Icons.copy_outlined),
            label: const Text('Salin Info'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.grey.shade300),
              foregroundColor: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _readFullSurah(context),
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('Baca Surah'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickFacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fakta Singkat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
          ),
          child: Column(
            children: [
              _buildFactRow('Nama Arab', surah.asma ?? 'غير معروف'),
              const Divider(height: 24),
              _buildFactRow('Nama Indonesia', surah.nama ?? 'Tidak Diketahui'),
              const Divider(height: 24),
              _buildFactRow('Jumlah Ayat', '${surah.ayat ?? 0} ayat'),
              const Divider(height: 24),
              _buildFactRow('Tempat Turun', _getSurahType()),
              const Divider(height: 24),
              _buildFactRow('Nomor Urut', 'Surah ke-${surah.nomor ?? 0}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFactRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ': ',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _getSurahType() {
    switch (surah.type) {
      case Type.MEKAH:
        return 'Makkiyah';
      case Type.MADINAH:
        return 'Madaniyah';
      default:
        return 'Tidak Diketahui';
    }
  }

  String _getDefaultMeaning() {
    final name = surah.nama ?? 'surah ini';
    final number = surah.nomor ?? 0;
    final ayatCount = surah.ayat ?? 0;
    final type = _getSurahType();
    
    return 'Surah $name adalah surah ke-$number dalam Al-Qur\'an yang terdiri dari $ayatCount ayat dan termasuk golongan surah $type.';
  }

  void _copyToClipboard(BuildContext context) {
    final text = '''
Surah: ${surah.nama ?? 'Tidak Diketahui'} (${surah.asma ?? 'غير معروف'})
Nomor: ${surah.nomor ?? 0}
Jumlah Ayat: ${surah.ayat ?? 0}
Tempat Turun: ${_getSurahType()}
Arti: ${surah.arti ?? _getDefaultMeaning()}
    ''';

    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Info surah berhasil disalin'),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _readFullSurah(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur baca surah ${surah.nama ?? "ini"} akan segera hadir'),
        backgroundColor: Colors.blue.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.share, color: Colors.green.shade600),
              const SizedBox(width: 8),
              const Text('Bagikan Surah'),
            ],
          ),
          content: Text(
            'Bagikan informasi surah:\n\n'
            '"${surah.nama ?? "Tidak Diketahui"} (${surah.asma ?? "غير معروف"})"\n\n'
            'Surah ke-${surah.nomor ?? 0} dengan ${surah.ayat ?? 0} ayat\n'
            'Golongan: ${_getSurahType()}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _copyToClipboard(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salin Info'),
            ),
          ],
        );
      },
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomSheetOption(
              icon: Icons.bookmark_outline,
              title: 'Simpan Surah',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar(context, 'Surah berhasil disimpan!', Colors.green);
              },
            ),
            _buildBottomSheetOption(
              icon: Icons.volume_up_outlined,
              title: 'Dengar Audio',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar(context, 'Fitur audio akan segera hadir!', Colors.orange);
              },
            ),
            _buildBottomSheetOption(
              icon: Icons.translate_outlined,
              title: 'Lihat Terjemahan',
              onTap: () {
                Navigator.pop(context);
                _showSnackBar(context, 'Fitur terjemahan akan segera hadir!', Colors.blue);
              },
            ),
            _buildBottomSheetOption(
              icon: Icons.info_outline,
              title: 'Info Surah',
              subtitle: '${surah.nama ?? "Tidak Diketahui"} - Surah ke-${surah.nomor ?? 0}',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
    );
  }

  void _showSnackBar(BuildContext context, String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}