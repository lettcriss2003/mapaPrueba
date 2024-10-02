import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  LatLng _center = LatLng(-3.9867, -79.2026); // Centro de Loja
  final double _initialZoom = 13.0;

  final Map<String, List<Map<String, dynamic>>> _poiData = {
    'Restaurantes': [
      {'name': 'Restaurante La Toscana', 'lat': -3.9965, 'lon': -79.2015},
      {'name': 'El Rincón de Borgoña', 'lat': -3.9810, 'lon': -79.3001},
      {'name': 'Mama Lola', 'lat': -3.9880, 'lon': -79.1990},
      {'name': 'Tacos & Grill', 'lat': -3.9925, 'lon': -79.2080},
      {'name': 'La Cascada', 'lat': -3.9850, 'lon': -79.2040},
      {'name': 'Pizzería Roma', 'lat': -3.9890, 'lon': -79.1970},
      {'name': 'Sushi Bar Loja', 'lat': -3.9940, 'lon': -79.2100},
    ],
    'Escuelas': [
      {'name': 'Escuela La Dolorosa', 'lat': -3.9860, 'lon': -79.2010},
      {'name': 'Unidad Educativa Calasanz', 'lat': -3.9900, 'lon': -79.2070},
      {'name': 'Colegio Beatriz Cueva de Ayora', 'lat': -3.9930, 'lon': -79.1980},
      {'name': 'Escuela Julio María Matovelle', 'lat': -3.9870, 'lon': -79.2050},
      {'name': 'Unidad Educativa San Francisco', 'lat': -3.9950, 'lon': -79.2030},
    ],
    'Iglesias': [
      {'name': 'Catedral de Loja', 'lat': -3.9960, 'lon': -79.2020},
      {'name': 'Iglesia San Sebastián', 'lat': -3.9920, 'lon': -79.2060},
      {'name': 'Iglesia Santo Domingo', 'lat': -3.9890, 'lon': -79.2000},
      {'name': 'Santuario El Cisne', 'lat': -3.9940, 'lon': -79.2090},
      {'name': 'Iglesia San José', 'lat': -3.9870, 'lon': -79.1970},
    ],
    'Gimnasios': [
      {'name': 'Gimnasio Power Fit', 'lat': -3.9880, 'lon': -79.2030},
      {'name': 'CrossFit Loja', 'lat': -3.9910, 'lon': -79.1990},
      {'name': 'Gym Body Perfect', 'lat': -3.9950, 'lon': -79.2070},
      {'name': 'Fitness Center Loja', 'lat': -3.9930, 'lon': -79.2010},
      {'name': 'Muscle Gym', 'lat': -3.9890, 'lon': -79.2050},
    ],
    'Universidades': [
      {'name': 'Universidad Técnica Particular de Loja', 'lat': -3.9867, 'lon': -79.2026},
      {'name': 'Universidad Nacional de Loja', 'lat': -4.0328, 'lon': -79.2023},
      {'name': 'Universidad Internacional del Ecuador', 'lat': -3.9900, 'lon': -79.2000},
      {'name': 'Instituto Tecnológico Superior Daniel Álvarez Burneo', 'lat': -3.9920, 'lon': -79.2040},
      {'name': 'ESPOL - Sede Loja', 'lat': -3.9940, 'lon': -79.1980},
    ],
    'Hoteles': [
      {'name': 'Grand Victoria Boutique Hotel', 'lat': -3.9970, 'lon': -79.2010},
      {'name': 'Hotel Libertador', 'lat': -3.9930, 'lon': -79.2050},
      {'name': 'Hostería Izhcayluma', 'lat': -3.9890, 'lon': -79.1980},
      {'name': 'Hotel Quo Vadis', 'lat': -3.9950, 'lon': -79.2030},
      {'name': 'Hostal Loja', 'lat': -3.9910, 'lon': -79.2070},
      {'name': 'Hotel Podocarpus', 'lat': -3.9880, 'lon': -79.2020},
    ],
    'Tiendas': [
      {'name': 'Centro Comercial La Pradera', 'lat': -3.9940, 'lon': -79.2060},
      {'name': 'Supermaxi Loja', 'lat': -3.9900, 'lon': -79.2010},
      {'name': 'Mercado Central', 'lat': -3.9960, 'lon': -79.2030},
      {'name': 'Plaza del Valle', 'lat': -3.9870, 'lon': -79.1990},
      {'name': 'Hipermercado Loja', 'lat': -3.9920, 'lon': -79.2080},
      {'name': 'Boutique La Moda', 'lat': -3.9950, 'lon': -79.2000},
    ],
    'Parques': [
      {'name': 'Parque Recreacional Jipiro', 'lat': -3.9760, 'lon': -79.2050},
      {'name': 'Parque Lineal La Tebaida', 'lat': -4.0020, 'lon': -79.2000},
      {'name': 'Parque Central de Loja', 'lat': -3.9960, 'lon': -79.2020},
      {'name': 'Parque Colinar Pucará', 'lat': -3.9890, 'lon': -79.1970},
      {'name': 'Parque Infantil', 'lat': -3.9930, 'lon': -79.2060},
    ],
    'Bares': [
      {'name': 'La Altura Bar', 'lat': -3.9950, 'lon': -79.2040},
      {'name': 'Coyote Bar', 'lat': -3.9920, 'lon': -79.2010},
      {'name': 'El Bufón Pub', 'lat': -3.9900, 'lon': -79.2070},
      {'name': 'La Cueva del Oso', 'lat': -3.9880, 'lon': -79.2030},
      {'name': 'Zaruma Pub', 'lat': -3.9940, 'lon': -79.1990},
    ],
    'Discotecas': [
      {'name': 'Nidia Disco Club', 'lat': -3.9930, 'lon': -79.2020},
      {'name': 'Zoom Discoteca', 'lat': -3.9960, 'lon': -79.2050},
      {'name': 'Level Club', 'lat': -3.9900, 'lon': -79.1980},
      {'name': 'La Purga Disco', 'lat': -3.9870, 'lon': -79.2060},
      {'name': 'Éxtasis Night Club', 'lat': -3.9940, 'lon': -79.2000},
    ],
    'Hospitales': [
      {'name': 'Hospital General Isidro Ayora', 'lat': -3.9920, 'lon': -79.2030},
      {'name': 'Hospital del IESS Loja', 'lat': -3.9890, 'lon': -79.2010},
      {'name': 'Clínica San Agustín', 'lat': -3.9950, 'lon': -79.2060},
      {'name': 'Hospital Universitario UTPL', 'lat': -3.9870, 'lon': -79.1990},
      {'name': 'Centro Médico Loja', 'lat': -3.9910, 'lon': -79.2080},
    ],
    'Piscinas': [
      {'name': 'Complejo Deportivo Ciudad de Loja', 'lat': -3.9880, 'lon': -79.2050},
      {'name': 'Balneario Víctor Manuel Palacios', 'lat': -3.9930, 'lon': -79.1970},
      {'name': 'Piscina Olímpica Municipal', 'lat': -3.9960, 'lon': -79.2040},
      {'name': 'Club de Natación Loja', 'lat': -3.9900, 'lon': -79.2020},
      {'name': 'Aqua Park Loja', 'lat': -3.9940, 'lon': -79.2090},
    ],
  };

  Map<String, bool> _selectedCategories = {};

  @override
  void initState() {
    super.initState();
    _selectedCategories = Map.fromIterable(_poiData.keys, value: (_) => false);
  }
  
  void _updateMarkers() {
    setState(() {
      _markers = [];
      _selectedCategories.forEach((category, isSelected) {
        if (isSelected) {
          _markers.addAll(_poiData[category]!.map((poi) => Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(poi['lat'], poi['lon']),
                builder: (ctx) => Tooltip(
                  message: poi['name'],
                  child: Icon(Icons.location_on, color: _getCategoryColor(category)),
                ),
              )));
        }
      });
    });
  }

  Color _getCategoryColor(String category) {
    final colors = {
      'Restaurantes': Colors.red,
      'Escuelas': Colors.blue,
      'Iglesias': Colors.cyan,
      'Gimnasios': Colors.yellow,
      'Universidades': Colors.purpleAccent,
      'Hoteles': Colors.black45,
      'Tiendas': Colors.amber,
      'Parques': Colors.brown,
      'Bares': Colors.redAccent,
      'Discotecas': Colors.grey,
      'Hospitales': Colors.greenAccent,
      'Piscinas': Colors.tealAccent,
      
    };
    return colors[category] ?? Colors.grey;
  }

  IconData _getCategoryIcon(String category) {
    final icons = {
      'Restaurantes': Icons.restaurant,
      'Escuelas': Icons.school,
      'Iglesias': Icons.church,
      'Gimnasios': FontAwesomeIcons.dumbbell,
      'Universidades': Icons.account_balance,
      'Hoteles': Icons.hotel,
      'Tiendas': Icons.store,
      'Parques': Icons.park,
      'Bares': FontAwesomeIcons.beer,
      'Discotecas': Icons.music_note,
      'Hospitales': Icons.local_hospital,
      'Piscinas': Icons.pool,
    };
    return icons[category] ?? Icons.help;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
          'Mapa de Loja',
          style: TextStyle(
            fontSize: 28.0,  // Aumentar el tamaño del texto
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            color: const Color.fromARGB(255, 30, 170, 149),  // Color del texto
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 217, 201, 201),
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 30, 28, 28)),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  'Categorías',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              ..._selectedCategories.keys.map((String key) {
                return CheckboxListTile(
                  title: Row(
                    children: [
                      Icon(_getCategoryIcon(key), color: Colors.white),
                      SizedBox(width: 10),
                      Text(key, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  value: _selectedCategories[key],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedCategories[key] = value!;
                      _updateMarkers();
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.green,
                );
              }).toList(),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _center,
            zoom: _initialZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: _markers),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AuthService>(context, listen: false).logout();
        },
        child: Icon(Icons.logout, color: Colors.white),
        backgroundColor: Colors.red,
        tooltip: 'Cerrar Sesión',
      ),
    );
  }
}
