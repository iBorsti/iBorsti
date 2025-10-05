import 'package:flutter/material.dart';

class PurchaseTicketScreen extends StatefulWidget {
  const PurchaseTicketScreen({
    super.key,
    this.onProceedToPayment,
  });

  final VoidCallback? onProceedToPayment;

  @override
  State<PurchaseTicketScreen> createState() => _PurchaseTicketScreenState();
}

class _PurchaseTicketScreenState extends State<PurchaseTicketScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOrigin;
  String? _selectedDestination;
  String? _selectedDay;
  Departure? _selectedDeparture;
  int _seatCount = 1;

  static const _paletteTurquoise = Color(0xFF1EC6B1);
  static const _paletteCoral = Color(0xFFFF6B6B);
  static const _paletteAmber = Color(0xFFFFC93C);
  static const _paletteNavy = Color(0xFF1B1F3B);

  final List<String> _locations = const [
    'San José',
    'Alajuela',
    'Cartago',
    'Heredia',
    'Puntarenas',
    'Limón',
  ];

  final Map<String, List<Departure>> _weeklyDepartures = const {
    'Lunes': [
      Departure(routeCode: 'SJ-AL-01', busName: 'Turquesa Express', departureTime: '06:00', price: 5200),
      Departure(routeCode: 'SJ-LI-14', busName: 'Coral Line', departureTime: '09:30', price: 6800),
    ],
    'Martes': [
      Departure(routeCode: 'SJ-CA-08', busName: 'Ámbar Prime', departureTime: '07:15', price: 5500),
      Departure(routeCode: 'AL-HR-21', busName: 'Navy Connect', departureTime: '16:20', price: 4300),
    ],
    'Miércoles': [
      Departure(routeCode: 'HR-SJ-19', busName: 'Turquesa Express', departureTime: '11:40', price: 5100),
    ],
    'Jueves': [
      Departure(routeCode: 'SJ-PT-03', busName: 'Coral Line', departureTime: '05:45', price: 7200),
      Departure(routeCode: 'LI-SJ-17', busName: 'Ámbar Prime', departureTime: '18:35', price: 6900),
    ],
    'Viernes': [
      Departure(routeCode: 'CA-SJ-06', busName: 'Navy Connect', departureTime: '07:50', price: 4900),
      Departure(routeCode: 'SJ-AL-25', busName: 'Turquesa Express', departureTime: '20:10', price: 5200),
    ],
    'Sábado': [
      Departure(routeCode: 'PT-LI-11', busName: 'Coral Line', departureTime: '10:15', price: 7800),
      Departure(routeCode: 'SJ-HR-04', busName: 'Ámbar Prime', departureTime: '13:45', price: 5600),
    ],
    'Domingo': [
      Departure(routeCode: 'SJ-PT-09', busName: 'Navy Connect', departureTime: '08:30', price: 7300),
      Departure(routeCode: 'LI-AL-15', busName: 'Turquesa Express', departureTime: '15:00', price: 6200),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paletteNavy.withOpacity(0.02),
      appBar: AppBar(
        backgroundColor: _paletteNavy,
        title: const Text('Compra tus boletos'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.92),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona tu ruta',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: _paletteNavy,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildRouteForm(context),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: _hasValidRoute
                    ? _WeeklyDeparturesPanel(
                        paletteNavy: _paletteNavy,
                        paletteCoral: _paletteCoral,
                        paletteTurquoise: _paletteTurquoise,
                        paletteAmber: _paletteAmber,
                        weeklyDepartures: _weeklyDepartures,
                        selectedDay: _selectedDay,
                        selectedDeparture: _selectedDeparture,
                        onDepartureSelected: _handleDepartureSelected,
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInBack,
                child: _selectedDeparture == null
                    ? const SizedBox.shrink()
                    : _SeatSelectionPanel(
                        paletteNavy: _paletteNavy,
                        paletteCoral: _paletteCoral,
                        paletteTurquoise: _paletteTurquoise,
                        paletteAmber: _paletteAmber,
                        selectedDay: _selectedDay!,
                        seatCount: _seatCount,
                        departure: _selectedDeparture!,
                        onSeatCountChanged: _handleSeatCountChanged,
                        onContinue: _handleContinue,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _hasValidRoute =>
      _selectedOrigin != null &&
      _selectedDestination != null &&
      _selectedOrigin != _selectedDestination;

  Widget _buildRouteForm(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RouteDropdown(
                label: 'Origen',
                hint: 'Selecciona la ciudad de salida',
                value: _selectedOrigin,
                options: _locations,
                onChanged: (value) {
                  setState(() {
                    _selectedOrigin = value;
                    if (_selectedDestination == value) {
                      _selectedDestination = null;
                    }
                    _resetSelectionCascade();
                  });
                },
              ),
              const SizedBox(height: 16),
              _RouteDropdown(
                label: 'Destino',
                hint: 'Selecciona tu destino',
                value: _selectedDestination,
                options: _locations.where((city) => city != _selectedOrigin).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDestination = value;
                    _resetSelectionCascade();
                  });
                },
              ),
              const SizedBox(height: 10),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _hasValidRoute ? 1 : 0.2,
                child: Text(
                  _hasValidRoute
                      ? 'Mostrando salidas disponibles para los próximos 7 días.'
                      : 'Selecciona origen y destino distintos para ver las salidas.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _paletteNavy.withOpacity(0.7),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetSelectionCascade() {
    _selectedDay = null;
    _selectedDeparture = null;
  }

  void _handleDepartureSelected(String day, Departure departure) {
    setState(() {
      _selectedDay = day;
      _selectedDeparture = departure;
    });
  }

  void _handleSeatCountChanged(int count) {
    setState(() => _seatCount = count);
  }

  void _handleContinue() {
    if (_selectedDeparture == null) {
      return;
    }

    if (widget.onProceedToPayment != null) {
      widget.onProceedToPayment!.call();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _paletteTurquoise,
        content: const Text(
          'Implementa aquí la navegación hacia la pasarela de pago.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _RouteDropdown extends StatelessWidget {
  const _RouteDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B1F3B),
              ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          items: options
              .map(
                (location) => DropdownMenuItem(
                  value: location,
                  child: Text(location),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF6F7FB),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF1EC6B1), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeeklyDeparturesPanel extends StatefulWidget {
  const _WeeklyDeparturesPanel({
    required this.paletteNavy,
    required this.paletteCoral,
    required this.paletteTurquoise,
    required this.paletteAmber,
    required this.weeklyDepartures,
    required this.selectedDay,
    required this.selectedDeparture,
    required this.onDepartureSelected,
  });

  final Color paletteNavy;
  final Color paletteCoral;
  final Color paletteTurquoise;
  final Color paletteAmber;
  final Map<String, List<Departure>> weeklyDepartures;
  final String? selectedDay;
  final Departure? selectedDeparture;
  final void Function(String day, Departure departure) onDepartureSelected;

  @override
  State<_WeeklyDeparturesPanel> createState() => _WeeklyDeparturesPanelState();
}

class _WeeklyDeparturesPanelState extends State<_WeeklyDeparturesPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horarios disponibles',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: widget.paletteNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            ...widget.weeklyDepartures.entries.map(
              (entry) => _DayScheduleCard(
                dayLabel: entry.key,
                departures: entry.value,
                paletteNavy: widget.paletteNavy,
                paletteAmber: widget.paletteAmber,
                paletteCoral: widget.paletteCoral,
                paletteTurquoise: widget.paletteTurquoise,
                isSelectedDay: widget.selectedDay == entry.key,
                selectedDeparture: widget.selectedDeparture,
                onDepartureSelected: (departure) =>
                    widget.onDepartureSelected(entry.key, departure),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayScheduleCard extends StatefulWidget {
  const _DayScheduleCard({
    required this.dayLabel,
    required this.departures,
    required this.paletteNavy,
    required this.paletteAmber,
    required this.paletteCoral,
    required this.paletteTurquoise,
    required this.isSelectedDay,
    required this.selectedDeparture,
    required this.onDepartureSelected,
  });

  final String dayLabel;
  final List<Departure> departures;
  final Color paletteNavy;
  final Color paletteAmber;
  final Color paletteCoral;
  final Color paletteTurquoise;
  final bool isSelectedDay;
  final Departure? selectedDeparture;
  final ValueChanged<Departure> onDepartureSelected;

  @override
  State<_DayScheduleCard> createState() => _DayScheduleCardState();
}

class _DayScheduleCardState extends State<_DayScheduleCard> {
  bool _expanded = false;

  @override
  void didUpdateWidget(covariant _DayScheduleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelectedDay && !_expanded) {
      _expanded = true;
    }
    if (!widget.isSelectedDay && _expanded) {
      _expanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        widget.paletteTurquoise.withOpacity(0.18),
        widget.paletteAmber.withOpacity(0.12),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: widget.paletteNavy.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color:
              widget.isSelectedDay ? widget.paletteTurquoise : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: widget.isSelectedDay,
          onExpansionChanged: (expanded) {
            setState(() => _expanded = expanded);
          },
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: widget.paletteNavy,
          collapsedIconColor: widget.paletteNavy,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dayLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: widget.paletteNavy,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: widget.isSelectedDay ? 1 : 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.paletteNavy.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Seleccionado',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
          children: widget.departures
              .map(
                (departure) => _DepartureTile(
                  departure: departure,
                  paletteNavy: widget.paletteNavy,
                  paletteCoral: widget.paletteCoral,
                  paletteTurquoise: widget.paletteTurquoise,
                  selected: widget.selectedDeparture == departure,
                  onTap: () => widget.onDepartureSelected(departure),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _DepartureTile extends StatelessWidget {
  const _DepartureTile({
    required this.departure,
    required this.paletteNavy,
    required this.paletteCoral,
    required this.paletteTurquoise,
    required this.selected,
    required this.onTap,
  });

  final Departure departure;
  final Color paletteNavy;
  final Color paletteCoral;
  final Color paletteTurquoise;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected ? paletteTurquoise.withOpacity(0.16) : Colors.white,
          border: Border.all(
            color: selected ? paletteTurquoise : Colors.white,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? paletteTurquoise : paletteCoral.withOpacity(0.14),
              ),
              child: Icon(
                Icons.directions_bus_filled,
                color: selected ? paletteNavy : paletteCoral,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departure.busName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: paletteNavy,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Código ${departure.routeCode} · ${departure.departureTime} hrs',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: paletteNavy.withOpacity(0.65),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: paletteCoral,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '₡${departure.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeatSelectionPanel extends StatelessWidget {
  const _SeatSelectionPanel({
    required this.paletteNavy,
    required this.paletteCoral,
    required this.paletteTurquoise,
    required this.paletteAmber,
    required this.selectedDay,
    required this.seatCount,
    required this.departure,
    required this.onSeatCountChanged,
    required this.onContinue,
  });

  final Color paletteNavy;
  final Color paletteCoral;
  final Color paletteTurquoise;
  final Color paletteAmber;
  final String selectedDay;
  final int seatCount;
  final Departure departure;
  final ValueChanged<int> onSeatCountChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final totalPrice = seatCount * departure.price;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona tus asientos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: paletteNavy,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: paletteTurquoise.withOpacity(0.15),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${departure.busName} · $selectedDay',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: paletteNavy,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sale a las ${departure.departureTime} hrs — Código ${departure.routeCode}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: paletteNavy.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Cantidad de asientos',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: paletteNavy,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(8, (index) {
                final count = index + 1;
                final selected = count == seatCount;
                return ChoiceChip(
                  label: Text('$count'),
                  selected: selected,
                  onSelected: (_) => onSeatCountChanged(count),
                  selectedColor: paletteAmber,
                  labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: selected ? paletteNavy : paletteNavy.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                  side: BorderSide(color: paletteNavy.withOpacity(0.2)),
                  backgroundColor: Colors.white,
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total a pagar',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: paletteNavy.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₡${totalPrice.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: paletteCoral,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: paletteTurquoise,
                      foregroundColor: paletteNavy,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: onContinue,
                    child: const Text(
                      'Continuar a pagar',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Departure {
  final String routeCode;
  final String busName;
  final String departureTime;
  final double price;

  const Departure({
    required this.routeCode,
    required this.busName,
    required this.departureTime,
    required this.price,
  });
}
