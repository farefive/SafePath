Act as an expert Flutter developer. I need you to write the complete, clean, and well-structured Dart code for a Flutter application named "Safe Path" (طريقك آمن). This app is a community service initiative designed to guide and assist Hajj and Umrah pilgrims. 

### Core Requirements:
1. **UI Architecture**: The main screen should use a `GridView` (2 columns) to display 5 main categories. The design must be highly accessible, featuring large tap targets, clear typography, and universally understood icons (suitable for elderly users).
2. **Offline-First**: The content (health tips and crowd instructions) must be hardcoded within the app so it works perfectly without an internet connection in crowded areas.
3. **Packages Needed**: Use the `url_launcher` package to handle phone calls and opening web links.

### Grid Categories & Content:

**1. Emergency Numbers (أرقام الطوارئ) 🚑**
- Action: When tapped, navigate to a new screen showing a `ListView` of emergency contacts. Each contact should have a button that directly opens the phone's dialer using `url_launcher` (scheme: `tel:`).
- Data:
  - Security (العمليات الأمنية): 911
  - Ambulance (الهلال الأحمر): 997
  - Civil Defense (الدفاع المدني): 998
  - Hajj Ministry (وزارة الحج والعمرة): 1966
  - Health Consultations (الصحة): 937

**2. Health Prevention (الوقاية الصحية) 💧**
- Action: Navigate to a screen with visually appealing `Card` widgets displaying short health tips.
- Data:
  - Sunstroke: Use an umbrella and avoid direct sun between 11 AM - 3 PM.
  - Hydration: Drink at least 2 liters of water daily; don't wait until you're thirsty.
  - Exhaustion: Rest frequently between rituals. Don't walk long distances at once.
  - Hygiene: Wash hands regularly and wear a mask in crowded areas.

**3. Crowd Guidelines (إرشادات الزحام) 🚶‍♂️**
- Action: Navigate to a screen with `Card` widgets displaying crowd safety tips.
- Data:
  - Follow Paths: Stick to designated pedestrian paths and signs.
  - No Sudden Stops: Do not stop suddenly. Move to the edges if you need to rest.
  - Go with the Flow: Never walk against the direction of the moving crowd.
  - Luggage: Carry only a small backpack; avoid large luggage that restricts movement.

**4. Spatial Guide (الدليل المكاني) 📍**
- Action: Open a bottom sheet or a simple dialog with buttons that open Google Maps URLs using `url_launcher` (scheme: `https:`).
- Links to include (use placeholder URLs for now, e.g., 'https://maps.google.com'):
  - Nearest Health Center (أقرب مركز صحي)
  - Lost & Found Centers (مراكز إرشاد التائهين)
  - Restrooms & Facilities (دورات المياه والمرافق)

**5. Rate the Service (تقييم الخدمة) ⭐**
- Action: Directly open a Google Forms URL using `url_launcher` when the grid item is tapped. (Use 'https://forms.google.com' as a placeholder).
- Visuals: Use a distinct color for this grid item to make it stand out.

### Technical Constraints & Configuration Setup:
- Write the UI strings in Arabic.
- Break down the code into clean, reusable widgets (e.g., `CategoryGridItem`, `TipCard`, `EmergencyContactTile`).
- Ensure the theme is clean, using a color palette suitable for a medical/guidance app (e.g., Greens, Whites, and Blues).
- **CRITICAL - url_launcher setup**: Along with the `main.dart` code, you MUST explicitly provide the exact configuration code blocks needed for:
  1. `pubspec.yaml` (dependencies).
  2. `android/app/src/main/AndroidManifest.xml` (Provide the exact `<queries>` tags needed for `tel` and `https` intents).
  3. `ios/Runner/Info.plist` (Provide the exact `LSApplicationQueriesSchemes` array needed for `tel` and `https`).

Please output the complete code and setup instructions clearly.