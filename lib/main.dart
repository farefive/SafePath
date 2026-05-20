import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'widgets.dart';

void main() {
  runApp(const SafePathApp());
}

class SafePathApp extends StatelessWidget {
  const SafePathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طريقك آمن - دليل الحاج والمعتمر',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Configure Arabic as the default locale for full RTL support
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تعذر فتح الرابط: $urlString',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppTheme.alertRed,
          ),
        );
      }
    }
  }

  void _showSpatialGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom sheet drag handle
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, color: AppTheme.primaryGreen, size: 28),
                  SizedBox(width: 10),
                  Text(
                    'الدليل المكاني للمرافق 📍',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'اختر المرفق الذي تبحث عنه لفتحه في خرائط جوجل مباشرة ومساعدتك في الوصول إليه.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textDark.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              // Action Buttons
              _buildGuideButton(
                context,
                label: 'أقرب مركز صحي 🏥',
                url: 'https://maps.google.com',
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(height: 12),
              _buildGuideButton(
                context,
                label: 'مراكز إرشاد التائهين 🤝',
                url: 'https://maps.google.com',
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(height: 12),
              _buildGuideButton(
                context,
                label: 'دورات المياه والمرافق 🚻',
                url: 'https://maps.google.com',
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideButton(BuildContext context, {
    required String label,
    required String url,
    required Color color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color, width: 2),
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        Navigator.pop(context); // Close bottom sheet
        _launchUrl(context, url);
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('طريقك آمن 🕋'),
        leading: const Icon(Icons.security, size: 28),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 26),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'طريقك آمن',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.health_and_safety,
                  color: AppTheme.primaryGreen,
                  size: 48,
                ),
                children: const [
                  Text(
                    'تطبيق ريادي مصمم لخدمة ضيوف الرحمن وتوفير الإرشادات الطبية والوقائية اللازمة لتجربة حج وعمرة آمنة وميسرة.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(height: 1.4),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Spiritual Header banner
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryGreen, Color(0xFF004D26)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const Icon(
                    Icons.mosque_outlined,
                    size: 70,
                    color: AppTheme.secondaryGold,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'مرحباً بك يا ضيف الرحمن',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: AppTheme.textLight,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'دليلك الوقائي والصحي المتكامل لأداء المناسك بطمأنينة ويسر.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textLight.withValues(alpha: 0.85),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'الخدمات والإرشادات 🛠️',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Grid of 4 Main Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
                children: [
                  CategoryGridItem(
                    title: 'أرقام الطوارئ 🚑',
                    icon: Icons.phone_in_talk,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmergencyScreen()),
                      );
                    },
                  ),
                  CategoryGridItem(
                    title: 'الوقاية الصحية 💧',
                    icon: Icons.health_and_safety,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HealthScreen()),
                      );
                    },
                  ),
                  CategoryGridItem(
                    title: 'إرشادات الزحام 🚶‍♂️',
                    icon: Icons.groups,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CrowdScreen()),
                      );
                    },
                  ),
                  CategoryGridItem(
                    title: 'الدليل المكاني 📍',
                    icon: Icons.map,
                    onTap: () => _showSpatialGuide(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 5th Category - Featured, High-Contrast full-width card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CategoryGridItem(
                title: 'تقييم الخدمة والاستبيان ⭐',
                icon: Icons.star,
                isFeatured: true,
                onTap: () => _launchUrl(context, 'https://forms.google.com'),
              ),
            ),
            const SizedBox(height: 32),
            // Decorative footer note
            Text(
              'حجٌّ مبرور وسعيٌ مشكور وذنبٌ مغفور بإذن الله',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. Emergency Numbers Screen (أرقام الطوارئ)
// ==========================================
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أرقام الطوارئ الهامة 🚑'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: const [
          EmergencyContactTile(
            label: 'العمليات الأمنية الموحدة',
            number: '911',
            icon: Icons.local_police,
          ),
          EmergencyContactTile(
            label: 'الهلال الأحمر السعودي (الإسعاف)',
            number: '997',
            icon: Icons.medical_services,
          ),
          EmergencyContactTile(
            label: 'الدفاع المدني',
            number: '998',
            icon: Icons.local_fire_department,
          ),
          EmergencyContactTile(
            label: 'وزارة الحج والعمرة',
            number: '1966',
            icon: Icons.mosque,
          ),
          EmergencyContactTile(
            label: 'الاستشارات الطبية وزارة الصحة',
            number: '937',
            icon: Icons.support_agent,
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. Health Prevention Screen (الوقاية الصحية)
// ==========================================
class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الوقاية الصحية 💧'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: const [
          TipCard(
            title: 'ضربات الشمس وإجهاد الحرارة ☀️',
            description: 'استخدم المظلة الواقية وتجنب التعرض المباشر لأشعة الشمس بين الساعة 11 صباحاً و 3 مساءً لتفادي ضربات الشمس المباشرة.',
            icon: Icons.umbrella,
          ),
          TipCard(
            title: 'شرب السوائل والترطيب 💧',
            description: 'احرص على شرب ما لا يقل عن 2 لتر من المياه يومياً بانتظام، ولا تنتظر حتى تشعر بالعطش لمنع الجفاف المفرط.',
            icon: Icons.water_drop,
          ),
          TipCard(
            title: 'الإجهاد البدني والراحة 😴',
            description: 'خذ قسطاً كافياً من الراحة بشكل متكرر بين المناسك والخطوات، وتجنب السير لمسافات طويلة ومرهقة دفعة واحدة.',
            icon: Icons.hotel,
          ),
          TipCard(
            title: 'النظافة الشخصية والكمامات 😷',
            description: 'اغسل يديك بانتظام بالماء والصابون، وارتدِ الكمامة دائماً في الأماكن المزدحمة للوقاية من الأمراض التنفسية والمعدية.',
            icon: Icons.clean_hands,
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. Crowd Guidelines Screen (إرشادات الزحام)
// ==========================================
class CrowdScreen extends StatelessWidget {
  const CrowdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إرشادات الزحام والسلامة 🚶‍♂️'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: const [
          TipCard(
            title: 'التزام بالمسارات واللوحات 🔀',
            description: 'التزم بالمسارات المخصصة للمشاة واتبع اللوحات الإرشادية والتعليمات الرسمية الصادرة عن رجال الأمن بصرامة.',
            icon: Icons.alt_route,
          ),
          TipCard(
            title: 'تجنب التوقف المفاجئ 🛑',
            description: 'لا تتوقف بشكل مفاجئ أثناء التدفق العام للحشود لتفادي سقوط الآخرين، وتوجه بهدوء إلى الأطراف إذا أردت الاستراحة.',
            icon: Icons.do_not_disturb_on,
          ),
          TipCard(
            title: 'السير مع اتجاه الحشود ➡️',
            description: 'سر دائماً مع اتجاه حركة الحشد وتدفقهم، ولا تحاول السير بالاتجاه المعاكس لتجنب التدافع والاصطدام المباشر.',
            icon: Icons.group,
          ),
          TipCard(
            title: 'حقائب الظهر الصغيرة 🎒',
            description: 'احمل حقيبة ظهر صغيرة وخفيفة فقط لحفظ متعلقاتك المهمة، وتجنب حمل الحقائب الكبيرة التي تعيق الحركة وتبطئ مسيرتك.',
            icon: Icons.backpack,
          ),
        ],
      ),
    );
  }
}
