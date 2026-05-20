import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';

/// An interactive, animated grid item designed for Hajj & Umrah pilgrims.
/// Features high contrast, large tap targets, and smooth micro-animations.
class CategoryGridItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isFeatured; // Used to highlight "Rate the Service"

  const CategoryGridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isFeatured = false,
  });

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = widget.isFeatured ? AppTheme.secondaryGold : AppTheme.surfaceWhite;
    final contentColor = widget.isFeatured ? AppTheme.textLight : AppTheme.primaryGreen;
    final textColor = widget.isFeatured ? AppTheme.textLight : AppTheme.textDark;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isFeatured 
                  ? AppTheme.secondaryGold 
                  : AppTheme.primaryGreen.withValues(alpha: 0.15),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (widget.isFeatured ? AppTheme.secondaryGold : AppTheme.primaryGreen)
                    .withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Soft background geometric accent
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Icon(
                    widget.icon,
                    size: 100,
                    color: contentColor.withValues(alpha: widget.isFeatured ? 0.15 : 0.05),
                  ),
                ),
                // Core Item Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: widget.isFeatured 
                            ? AppTheme.surfaceWhite.withValues(alpha: 0.2) 
                            : AppTheme.accentMint,
                        child: Icon(
                          widget.icon,
                          size: 30,
                          color: widget.isFeatured ? AppTheme.surfaceWhite : AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A visually appealing, high-contrast Card widget for tips.
class TipCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const TipCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppTheme.accentMint,
          width: 1.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppTheme.surfaceWhite,
              AppTheme.accentMint.withValues(alpha: 0.1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.accentMint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(width: 16),
              // Content (Title & Description)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textDark,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A custom, high-visibility list tile for emergency numbers.
class EmergencyContactTile extends StatelessWidget {
  final String label;
  final String number;
  final IconData icon;

  const EmergencyContactTile({
    super.key,
    required this.label,
    required this.number,
    required this.icon,
  });

  Future<void> _makeCall(BuildContext context) async {
    final Uri url = Uri.parse('tel:$number');
    try {
      // Bypassing canLaunchUrl since it returns false on iOS/Android emulators
      // launchUrl itself returns false or throws if dialing is unsupported.
      final success = await launchUrl(url);
      if (!success) {
        throw 'Launch failed';
      }
    } catch (e) {
      // Fallback: Copy to clipboard and show an informative snackbar
      await Clipboard.setData(ClipboardData(text: number));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم نسخ الرقم $number 📋 (المحاكيات لا تدعم الاتصال الهاتفي)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppTheme.primaryGreen,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.alertRed.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.alertRed.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _makeCall(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: Row(
              children: [
                // Contact Details
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppTheme.alertRed.withValues(alpha: 0.1),
                        child: Icon(
                          icon,
                          color: AppTheme.alertRed,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              number,
                              textDirection: TextDirection.ltr, // Display digits properly
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: AppTheme.textDark.withValues(alpha: 0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Giant High-Contrast Dialer Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: AppTheme.textLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    minimumSize: const Size(80, 48),
                  ),
                  onPressed: () => _makeCall(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_in_talk, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'اتصال',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
