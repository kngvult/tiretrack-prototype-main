import 'package:TireTrack/main.dart' as main;
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'alertas_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;

  HomeScreen({required this.isAdmin});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TireTrack',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Cairo',
          ),
        ),
        centerTitle: true,
      ),
      drawer: _buildDrawer(theme),
      body: _buildDashboardBody(context),
    );
  }

  Drawer _buildDrawer(ThemeData theme) {
    final isDark = main.themeNotifier.value;
    final colorScheme = theme.colorScheme;

    String iconPath;
    if (widget.isAdmin) {
      iconPath = 'assets/images/worker.png';
    } else {
      iconPath = 'assets/images/mechanic.png';
    }

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
              ),
              accountName: Text(
                'João Silva',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              accountEmail: Text(
                widget.isAdmin ? 'Gerente' : 'Borracheiro',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colorScheme.surface,
                child: Image.asset(
                  iconPath,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: theme.iconTheme.color,
              ),
              title: Text(
                'Alternar Tema',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              onTap: () {
                setState(() {
                  main.themeNotifier.value = !isDark;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: theme.iconTheme.color),
              title: Text(
                'Alertas',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlertasScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: isDark ? Colors.red[200] : Colors.red),
              title: Text(
                'Sair',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              onTap: () {
                _confirmLogout();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair do aplicativo?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text(
              'Sair',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildCardGrid(),
      ),
    );
  }

  Widget _buildCardGrid() {
    return Column(
      children: [
        if (widget.isAdmin)
          _buildCard(
            context,
            'Solicitar Ordem de Serviço',
            Icons.assignment_rounded,
            Theme.of(context).colorScheme.secondary,
            'Solicite a manutenção em caminhões em nossa frota!',
            '/request-service-order',
          ),
        if (widget.isAdmin) const SizedBox(height: 16),
        _buildCard(
          context,
          'Atender Solicitação',
          Icons.handyman,
          Colors.deepOrange, // Pode ser substituído por `colorScheme.secondary`
          'Informe a manutenção realizada.',
          '/maintenance-record',
        ),
        const SizedBox(height: 16),
        _buildCard(
          context,
          'Histórico de Manutenção',
          Icons.settings_backup_restore,
          Colors.green, // Pode ser ajustado se houver cor específica no tema
          'Verifique todas as manutenções já realizadas.',
          '/maintenance-history',
        ),
        if (widget.isAdmin) const SizedBox(height: 16),
        if (widget.isAdmin)
          _buildCard(
            context,
            'Gerenciar Frota',
            Icons.fire_truck_rounded,
            Colors.red, // Ou `colorScheme.primary`
            'Edite/Modifique a sua frota.',
            '/add-truck-tire',
          ),
        if (widget.isAdmin) const SizedBox(height: 16),
        if (widget.isAdmin)
          _buildCard(
            context,
            'Dashboard',
            Icons.dashboard,
            Colors.purple, // Ou qualquer outro dentro da paleta
            'Visualize métricas e estatísticas.',
            '/dashboard',
          ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    String subtitle,
    String route,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Material(
        color: colorScheme.surface,
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 40),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium!.color!.withOpacity(0.7),
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
