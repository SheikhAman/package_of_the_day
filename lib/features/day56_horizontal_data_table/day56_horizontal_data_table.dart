import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:package_of_the_day/features/day56_horizontal_data_table/user_info_model.dart';

const _accent = Color(0xFF6C5CE7);

class Day56HorizontalDataTable extends StatefulWidget {
  const Day56HorizontalDataTable({super.key});

  @override
  State<Day56HorizontalDataTable> createState() =>
      _Day56HorizontalDataTableState();
}

class _Day56HorizontalDataTableState extends State<Day56HorizontalDataTable> {
  final _refreshController = HDTRefreshController();

  static const int _sortName = 0;
  static const int _sortStatus = 1;
  bool _isAscending = true;
  int _sortType = _sortName;

  late List<UserInfo> _users = _generateUsers(60);

  List<UserInfo> _generateUsers(int count) {
    return List.generate(
      count,
      (i) => UserInfo(
        'User_$i',
        i % 3 == 0,
        '+001 9999 9999',
        '2019-01-01',
        'N/A',
      ),
    );
  }

  void _sortByName() {
    setState(() {
      _sortType = _sortName;
      _isAscending = !_isAscending;
      _users.sort((a, b) {
        final aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
        final bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
        return (aId - bId) * (_isAscending ? 1 : -1);
      });
    });
  }

  void _sortByStatus() {
    setState(() {
      _sortType = _sortStatus;
      _isAscending = !_isAscending;
      _users.sort((a, b) {
        if (a.disabled == b.disabled) {
          final aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
          final bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
          return aId - bId;
        }
        return (a.disabled ? 1 : -1) * (_isAscending ? 1 : -1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 56 · Horizontal Data Table',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      // The original set the table's height to
      // MediaQuery.of(context).size.height — the FULL screen height —
      // while already inside a Scaffold with an AppBar, which pushes the
      // table past the visible area and causes an overflow. Wrapping in
      // Expanded lets it correctly fill just the remaining space instead.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'horizontal_data_table freezes a left-hand column while '
                'the rest scrolls horizontally — great for tables with '
                'more columns than fit on screen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 100,
                  rightHandSideColumnWidth: 600,
                  isFixedHeader: true,
                  headerWidgets: _buildHeaderRow(),
                  leftSideItemBuilder: _buildNameCell,
                  rightSideItemBuilder: _buildRowCells,
                  itemCount: _users.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black12,
                    height: 1,
                    thickness: 1,
                  ),
                  leftHandSideColBackgroundColor: Colors.white,
                  rightHandSideColBackgroundColor: Colors.white,
                  verticalScrollbarStyle: ScrollbarStyle(
                    thumbColor: _accent,
                    isAlwaysShown: false,
                    thickness: 4,
                    radius: const Radius.circular(5),
                  ),
                  horizontalScrollbarStyle: ScrollbarStyle(
                    thumbColor: _accent,
                    isAlwaysShown: false,
                    thickness: 4,
                    radius: const Radius.circular(5),
                  ),
                  enablePullToRefresh: true,
                  refreshIndicator: const WaterDropHeader(),
                  refreshIndicatorHeight: 60,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    setState(() => _users = _generateUsers(60));
                    _refreshController.refreshCompleted();
                  },
                  enablePullToLoadNewData: true,
                  loadIndicator: const ClassicFooter(),
                  onLoad: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    setState(() {
                      final more = _generateUsers(20).map((u) {
                        final nextIndex =
                            _users.length +
                            int.parse(u.name.replaceFirst('User_', ''));
                        return UserInfo(
                          'User_$nextIndex',
                          nextIndex % 3 == 0,
                          u.phone,
                          u.registerDate,
                          u.terminationDate,
                        );
                      }).toList();
                      _users = [..._users, ...more];
                    });
                    _refreshController.loadComplete();
                  },
                  htdRefreshController: _refreshController,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  List<Widget> _buildHeaderRow() {
    return [
      _sortableHeaderCell('Name', 100, _sortName, _sortByName),
      _sortableHeaderCell('Status', 100, _sortStatus, _sortByStatus),
      _headerCell('Phone', 200),
      _headerCell('Register', 100),
      _headerCell('Termination', 200),
    ];
  }

  Widget _sortableHeaderCell(
    String label,
    double width,
    int type,
    VoidCallback onTap,
  ) {
    final isActive = _sortType == type;
    final arrow = isActive ? (_isAscending ? ' ↓' : ' ↑') : '';
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onTap,
      child: _headerCell('$label$arrow', width, active: isActive),
    );
  }

  Widget _headerCell(String label, double width, {bool active = false}) {
    return Container(
      width: width,
      height: 52,
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: active ? _accent : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildNameCell(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        _users[index].name,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }

  Widget _buildRowCells(BuildContext context, int index) {
    final user = _users[index];
    return Row(
      children: [
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (user.disabled ? Colors.red : Colors.green).withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              user.disabled ? 'Disabled' : 'Active',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: user.disabled ? Colors.red : Colors.green,
              ),
            ),
          ),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            user.phone,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            user.registerDate,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            user.terminationDate,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
