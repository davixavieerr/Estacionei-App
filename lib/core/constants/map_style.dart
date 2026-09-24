class MapStyle {
  static const String darkMapJson = '''
[
  {"elementType": "geometry", "stylers": [{"color": "#0a1128"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#8ea2c6"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#070c1a"}]},
  {"featureType": "administrative.country", "elementType": "geometry.stroke", "stylers": [{"color": "#233760"}]},
  {"featureType": "landscape.man_made", "elementType": "geometry.stroke", "stylers": [{"color": "#162544"}]},
  {"featureType": "poi", "elementType": "geometry", "stylers": [{"color": "#111f3d"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#1a2c54"}]},
  {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#203a70"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#050914"}]}
]
''';
}
