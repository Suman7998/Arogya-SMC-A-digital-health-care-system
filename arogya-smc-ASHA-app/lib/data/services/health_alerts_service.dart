import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';
import '../../data/models/models.dart';

class HealthAlertsService {
  Future<List<AlertModel>> fetchSolapurHealthAlerts() async {
    try {
      // Use Google News RSS feed searching for Solapur health/disease topics
      final url = Uri.parse('https://news.google.com/rss/search?q=Solapur+health+OR+disease+OR+outbreak+OR+dengue&hl=en-IN&gl=IN&ceid=IN:en');
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        final List<AlertModel> alerts = [];
        
        for (var item in items) {
          final title = item.findElements('title').firstOrNull?.innerText ?? 'Public Health Alert';
          final link = item.findElements('link').firstOrNull?.innerText ?? '';
          final pubDateStr = item.findElements('pubDate').firstOrNull?.innerText ?? '';
          final source = item.findElements('source').firstOrNull?.innerText ?? 'News Feed';
          final description = item.findElements('description').firstOrNull?.innerText ?? 'No detailed description available.';

          // Only include if it actually mentions Solapur or nearby keywords (Google News sometimes includes broad matches)
          if (!title.toLowerCase().contains('solapur') && !description.toLowerCase().contains('solapur')) {
            continue;
          }

          DateTime pubDate = DateTime.now();
          try {
            // PubDate format: Thu, 04 Jan 2024 10:20:00 GMT
            final format = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz');
            pubDate = format.parse(pubDateStr);
          } catch (_) {
            pubDate = DateTime.now();
          }

          final severity = _determineSeverity(title + " " + description);
          final diseasesType = _determineDiseaseType(title + " " + description);

          // We map 'articleUrl' to 'titleHindi' and 'source' to 'titleMarathi' to avoid DB migrations temporarily, 
          // or we can add them to the model properly if schema is updated.
          
          alerts.add(AlertModel(
            id: DateTime.now().microsecondsSinceEpoch.toString() + (alerts.length.toString()),
            type: diseasesType, // map disease type to type
            severity: severity,
            wardCode: 'Solapur',
            title: title.replaceAll(RegExp(r' - .*$'), ''), // Clean " - Source" from Google News titles
            description: 'Source: $source\n\nTo read the full public health advisory or news report, click the button below.',
            generatedAt: pubDate,
            status: 'active',
            isRead: false,
            // We use these fields to store URL and Source safely without database schema changes
            descriptionHindi: link, 
            descriptionMarathi: source,
          ));
        }

        return alerts;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching alerts: $e');
      return [];
    }
  }

  String _determineSeverity(String text) {
    text = text.toLowerCase();
    if (text.contains('outbreak') ||
        text.contains('rapid spread') ||
        text.contains('epidemic') ||
        text.contains('death') ||
        text.contains('emergency') ||
        text.contains('fatal') ||
        text.contains('surge')) {
      return 'high';
    } else if (text.contains('increasing') ||
        text.contains('seasonal') ||
        text.contains('vaccination drive') ||
        text.contains('cases rising') ||
        text.contains('alert')) {
      return 'medium';
    }
    return 'low';
  }

  String _determineDiseaseType(String text) {
    text = text.toLowerCase();
    if (text.contains('dengue')) return 'Dengue';
    if (text.contains('malaria')) return 'Malaria';
    if (text.contains('flu') || text.contains('influenza')) return 'Flu';
    if (text.contains('chickenpox')) return 'Chickenpox';
    if (text.contains('covid')) return 'COVID-19';
    if (text.contains('heatwave') || text.contains('heat wave')) return 'Heatwave';
    if (text.contains('waterborne') || text.contains('cholera')) return 'Waterborne Disease';
    if (text.contains('diabetes')) return 'Diabetes';
    if (text.contains('cancer')) return 'Cancer';
    return 'Public Health Advisory';
  }
}
