import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/stock_screen.dart';
import 'screens/prescriptions_screen.dart';
import 'screens/expiry_alerts_screen.dart';
import 'screens/sales_screen.dart';

void main() {
  runApp(const PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF00796B),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF00796B),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00796B),
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token != null && token.isNotEmpty) {
        // Vérifier la validité du token
        final isValid = await _validateToken(token);
        setState(() {
          _isAuthenticated = isValid;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isAuthenticated = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isAuthenticated = false;
        _isLoading = false;
      });
    }
  }

  Future<bool> _validateToken(String token) async {
    // TODO: Implémenter une validation réelle du token
    // Pour l'instant, on considère que le token est valide s'il existe
    return token.isNotEmpty;
  }

  void _logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
    setState(() {
      _isAuthenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF00796B),
          ),
        ),
      );
    }

    return _isAuthenticated
        ? MainNavigator(
            onLogout: _logout,
          )
        : LoginScreen(
            onLoginSuccess: () {
              setState(() {
                _isAuthenticated = true;
              });
            },
          );
  }
}

class MainNavigator extends StatefulWidget {
  final VoidCallback onLogout;

  const MainNavigator({super.key, required this.onLogout});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  String _userName = 'Admin';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = FlutterSecureStorage();
    final userData = await storage.read(key: 'user');
    if (userData != null) {
      // TODO: Parser les données utilisateur
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const StockScreen(),
    const PrescriptionsScreen(),
    const SalesScreen(),
    const ExpiryAlertsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showUserMenu(context);
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00796B),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Stock'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Prescriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.point_of_sale),
            label: 'Sales',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Alerts'),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Tableau de bord';
      case 1:
        return 'Gestion des stocks';
      case 2:
        return 'Ordonnances';
      case 3:
        return 'Ventes';
      case 4:
        return 'Alertes';
      default:
        return 'Pharmacy Management';
    }
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Icon(
              Icons.account_circle,
              size: 80,
              color: Color(0xFF00796B),
            ),
            const SizedBox(height: 8),
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Administrateur',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Naviguer vers paramètres
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Sécurité'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Naviguer vers sécurité
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Naviguer vers aide
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onLogout();
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
