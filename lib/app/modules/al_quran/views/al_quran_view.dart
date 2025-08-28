import 'package:belajar_getx/app/data/models/al_quran.dart';
import 'package:belajar_getx/app/modules/al_quran/controllers/al_quran_controller.dart';
import 'package:belajar_getx/app/modules/al_quran/views/alquran_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlquranView extends GetView<AlQuranController> {
  AlquranView({super.key});
   final AlQuranController controller = Get.put(AlQuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Al-Qur\'an',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        shadowColor: Colors.grey.withOpacity(0.1),
        actions: [
          IconButton(
            onPressed: controller.fetchAlquran,
            icon: Icon(Icons.refresh_rounded, color: Colors.green.shade600),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        if (controller.errorMessage.isNotEmpty) {
          return _buildErrorState();
        }

        final alqurans = controller.alqurans;
        if (alqurans.isEmpty) {
          return _buildEmptyState();
        }

        return _buildSurahList(alqurans);
      }),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Memuat Surah...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Harap tunggu sebentar',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage.value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.fetchAlquran,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Coba Lagi'),
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
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.book_outlined,
                size: 40,
                color: Colors.green.shade400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum Ada Data Surah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tidak ada data surah yang dapat ditampilkan saat ini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahList(alqurans) {
    return RefreshIndicator(
      onRefresh: () async { 
        await controller.fetchAlquran;
      },
      color: Colors.green.shade600,
      child: ListView.builder(
        key: ValueKey('surah_list_${alqurans.length}'), // Add unique key for ListView
        padding: const EdgeInsets.all(16),
        itemCount: alqurans.length,
        itemBuilder: (ctx, i) {
          final surah = alqurans[i];
          return _buildSurahItem(surah, i);
        },
      ),
    );
  }

  Widget _buildSurahItem(dynamic surah, int index) {
    // Create unique identifier that combines timestamp and index to avoid Hero tag conflicts
    final uniqueId = '${surah.nomor ?? index}_${DateTime.now().millisecondsSinceEpoch ~/ 1000}';
    
    return Container(
      key: ValueKey('surah_item_$uniqueId'), // Unique key for each item
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => AlquranDetailView(surah: surah)),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSurahIcon(surah, uniqueId),
                const SizedBox(width: 16),
                _buildSurahContent(surah),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahIcon(dynamic surah, String uniqueId) {
    return Hero(
      tag: 'surah_icon_$uniqueId', // Use unique ID for Hero tag
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade50,
                  Colors.green.shade100,
                ],
              ),
            ),
            child: Center(
              child: Text(
                '${surah.nomor ?? '?'}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahContent(dynamic surah) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSurahBadge(surah),
          const SizedBox(height: 8),
          _buildSurahTitle(surah),
          const SizedBox(height: 6),
          _buildSurahDetails(surah),
          const SizedBox(height: 12),
          _buildReadMoreSection(),
        ],
      ),
    );
  }

  Widget _buildSurahBadge(dynamic surah) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.green.shade200,
          width: 0.5,
        ),
      ),
      child: Text(
        'Surah #${surah.nomor ?? '?'}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.green.shade600,
        ),
      ),
    );
  }

  Widget _buildSurahTitle(dynamic surah) {
    return Text(
      '${surah.nama ?? 'Tidak Diketahui'} (${surah.asma ?? 'غير معروف'})',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
        height: 1.3,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSurahDetails(dynamic surah) {
    String surahType = 'N/A';
    if (surah.type == Type.MEKAH) {
      surahType = 'Makkiyah';
    } else if (surah.type == Type.MADINAH) {
      surahType = 'Madaniyah';
    }

    return Row(
      children: [
        Icon(
          Icons.format_list_numbered_outlined,
          size: 14,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Text(
          '${surah.ayat ?? 0} ayat',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        Icon(
          surah.type == Type.MEKAH ? Icons.location_city_outlined : Icons.mosque_outlined,
          size: 14,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Text(
          surahType,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildReadMoreSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Ketuk untuk membaca selengkapnya',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: Colors.green.shade400,
          ),
        ),
      ],
    );
  }
}