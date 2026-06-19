import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  final double fontSizeScale;
  final ValueChanged<double> onFontSizeChanged;

  SettingsPage({
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.selectedColor,
    required this.onColorChanged,
    required this.fontSizeScale,
    required this.onFontSizeChanged,
  });

  final List<Map<String, dynamic>> colors = [
    {'name': 'Xanh lam', 'color': Colors.blue},
    {'name': 'Xanh mòng két', 'color': Colors.teal},
    {'name': 'Cam đất', 'color': const Color(0xFFD84315)},
    {'name': 'Tím', 'color': Colors.deepPurple},
    {'name': 'Lá cây', 'color': Colors.green},
  ];

  double _getSliderValue(double scale) {
    if (scale <= 0.85) return 0.0;
    if (scale >= 1.25) return 2.0;
    return 1.0;
  }

  double _getScaleValue(double sliderValue) {
    if (sliderValue < 0.5) return 0.85;
    if (sliderValue > 1.5) return 1.25;
    return 1.0;
  }

  String _getLabelText(double scale) {
    if (scale <= 0.85) return "Nhỏ";
    if (scale >= 1.25) return "Lớn";
    return "Vừa";
  }

  Widget _buildColorPicker(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  "Tông màu chủ đạo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: colors.map((item) {
                final color = item['color'] as Color;
                final name = item['name'] as String;
                final isSelected = selectedColor == color;

                return GestureDetector(
                  onTap: () => onColorChanged(color),
                  child: Tooltip(
                    message: name,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? (isDarkMode ? Colors.white : Colors.black87)
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withAlpha(102),
                                blurRadius: isSelected ? 8 : 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  size: 22,
                                )
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeCard(BuildContext context) {
    final double sliderValue = _getSliderValue(fontSizeScale);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  "Kích thước phông chữ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withAlpha(51),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withAlpha(38),
                ),
              ),
              child: const Text(
                "Đây là văn bản xem trước khi thay đổi kích thước phông chữ toàn cục.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.primary.withAlpha(61),
                thumbColor: Theme.of(context).colorScheme.primary,
                overlayColor: Theme.of(context).colorScheme.primary.withAlpha(31),
                valueIndicatorColor: Theme.of(context).colorScheme.primary,
                valueIndicatorTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              child: Slider(
                value: sliderValue,
                min: 0.0,
                max: 2.0,
                divisions: 2,
                label: _getLabelText(fontSizeScale),
                onChanged: (val) {
                  onFontSizeChanged(_getScaleValue(val));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nhỏ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: fontSizeScale <= 0.85 ? FontWeight.bold : FontWeight.normal,
                      color: fontSizeScale <= 0.85 ? Theme.of(context).colorScheme.primary : Colors.grey,
                    ),
                  ),
                  Text(
                    "Vừa",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: (fontSizeScale > 0.85 && fontSizeScale < 1.25) ? FontWeight.bold : FontWeight.normal,
                      color: (fontSizeScale > 0.85 && fontSizeScale < 1.25) ? Theme.of(context).colorScheme.primary : Colors.grey,
                    ),
                  ),
                  Text(
                    "Lớn",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: fontSizeScale >= 1.25 ? FontWeight.bold : FontWeight.normal,
                      color: fontSizeScale >= 1.25 ? Theme.of(context).colorScheme.primary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              title: const Text("Chế độ tối (Dark Mode)", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Thay đổi sắc thái hiển thị ứng dụng"),
              secondary: Icon(Icons.brightness_6, color: Theme.of(context).colorScheme.primary),
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),
          ),
          const SizedBox(height: 12),
          _buildColorPicker(context),
          const SizedBox(height: 12),
          _buildFontSizeCard(context),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
              title: const Text("Phiên bản ứng dụng", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Text("v1.0.0 Standard", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }
}