class NasaEdpoints {
  NasaEdpoints._();

  static String apod({required String apiKey, required String date}) => 'https://api.nasa.gov/planetary/apod?api key=$apiKey&date=$date';
}
