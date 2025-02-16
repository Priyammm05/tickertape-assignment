import 'dart:math';

class NewsUtils {
  static final List<String> _topics = [
    'technology',
    'sports',
    'politics',
    'entertainment',
    'health',
    'finance',
    'business',
    'science',
    'education',
    'travel',
    'food',
    'fashion',
    'gaming',
    'automobile',
    'music',
    'movies',
    'books',
    'startup',
    'economy',
    'history',
    'art',
    'space',
    'weather',
    'nature',
    'fitness',
    'cryptocurrency',
    'stocks',
    'medicine',
    'law',
    'psychology',
    'environment',
    'photography',
    'AI',
    'cybersecurity',
    'robotics',
    'software',
    'hardware',
    'cloud',
    'blockchain',
    'biotech',
    'genetics',
    'marine',
    'aviation',
    'architecture',
    'theatre',
    'philosophy',
    'social media',
    'sports analytics',
    'quantum computing',
    'geopolitics'
  ];

  /// Returns a random topic from the predefined list
  static String getRandomTopic() {
    final random = Random();
    return _topics[random.nextInt(_topics.length)];
  }
}
