import 'package:flutter/material.dart';
import 'package:rd_investment_platform/Theme/apptheme.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: backgroundLight,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support Tickets',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage and resolve investor support requests',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textGrey,
                  ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _SupportStatCard(
                      value: '2',
                      label: 'Open',
                      icon: Icons.info_outline_rounded,
                      iconColor: Color(0xFF1E63FF),
                      iconBg: Color(0xFFE7F0FF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SupportStatCard(
                      value: '2',
                      label: 'In Progress',
                      icon: Icons.access_time_rounded,
                      iconColor: Color(0xFFFF8A00),
                      iconBg: Color(0xFFFFF1E0),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SupportStatCard(
                      value: '1',
                      label: 'Resolved',
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: Color(0xFF00B167),
                      iconBg: Color(0xFFE6F7EF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SupportStatCard(
                      value: '5',
                      label: 'Total Tickets',
                      icon: Icons.chat_bubble_outline_rounded,
                      iconColor: Color(0xFF6C757D),
                      iconBg: Color(0xFFF1F3F5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: const [
                  Expanded(child: _SearchField()),
                  SizedBox(width: 12),
                  _FilterBox(label: 'All Status'),
                  SizedBox(width: 12),
                  _FilterBox(label: 'All Priority'),
                ],
              ),
              const SizedBox(height: 18),
              Column(
                children: const [
                  _TicketCard(
                    status: _TicketTag(
                      label: 'IN PROGRESS',
                      bg: Color(0xFFFFF1E0),
                      text: Color(0xFFFF8A00),
                    ),
                    priority: _TicketTag(
                      label: 'HIGH',
                      bg: Color(0xFFFFD8D8),
                      text: Color(0xFFE53935),
                    ),
                    category: _TicketTag(
                      label: 'PAYOUT',
                      bg: Color(0xFFDFF7EA),
                      text: Color(0xFF00A15B),
                    ),
                    title: 'Delay in March payout',
                    name: 'Rajesh Kumar',
                    email: 'rajesh.kumar@email.com',
                    createdAt: 'Created: 29 Mar, 10:30 am',
                    messages: '5 messages',
                    assignedTo: 'Assigned to: Support Team',
                    actionLabel: 'Resolve',
                    actionColor: Color(0xFF00B167),
                    actionIcon: Icons.check_rounded,
                  ),
                  SizedBox(height: 16),
                  _TicketCard(
                    status: _TicketTag(
                      label: 'RESOLVED',
                      bg: Color(0xFFDFF7EA),
                      text: Color(0xFF00A15B),
                    ),
                    priority: _TicketTag(
                      label: 'LOW',
                      bg: Color(0xFFF1F3F5),
                      text: Color(0xFF6C757D),
                    ),
                    category: _TicketTag(
                      label: 'CERTIFICATE',
                      bg: Color(0xFFFFF1E0),
                      text: Color(0xFFFF8A00),
                    ),
                    title: 'How to download investment certificate?',
                    name: 'Priya Sharma',
                    email: 'priya.sharma@email.com',
                    createdAt: 'Created: 28 Mar, 03:45 pm',
                    messages: '3 messages',
                    assignedTo: 'Assigned to: Support Team',
                    actionLabel: 'Resolved',
                    actionColor: Color(0xFFDFF7EA),
                    actionIcon: Icons.check_rounded,
                    actionTextColor: Color(0xFF00A15B),
                  ),
                  SizedBox(height: 16),
                  _TicketCard(
                    status: _TicketTag(
                      label: 'OPEN',
                      bg: Color(0xFFE7F0FF),
                      text: Color(0xFF1E63FF),
                    ),
                    priority: _TicketTag(
                      label: 'MEDIUM',
                      bg: Color(0xFFE7F0FF),
                      text: Color(0xFF1E63FF),
                    ),
                    category: _TicketTag(
                      label: 'KYC',
                      bg: Color(0xFFF0E8FF),
                      text: Color(0xFF7B4BFF),
                    ),
                    title: 'KYC verification pending',
                    name: 'Vikram Singh',
                    email: 'vikram.singh@email.com',
                    createdAt: 'Created: 30 Mar, 09:15 am',
                    messages: '1 messages',
                    assignedTo: '',
                    actionLabel: 'Start Working',
                    actionColor: Color(0xFF0B0B1A),
                    actionIcon: Icons.play_arrow_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportStatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _SupportStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textGrey,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search tickets...',
        prefixIcon: Icon(Icons.search, color: textGrey),
      ),
    );
  }
}

class _FilterBox extends StatelessWidget {
  final String label;

  const _FilterBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_down_rounded, color: textGrey),
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final _TicketTag status;
  final _TicketTag priority;
  final _TicketTag category;
  final String title;
  final String name;
  final String email;
  final String createdAt;
  final String messages;
  final String assignedTo;
  final String actionLabel;
  final Color actionColor;
  final Color? actionTextColor;
  final IconData actionIcon;

  const _TicketCard({
    required this.status,
    required this.priority,
    required this.category,
    required this.title,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.messages,
    required this.assignedTo,
    required this.actionLabel,
    required this.actionColor,
    required this.actionIcon,
    this.actionTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedText = actionTextColor ?? Colors.white;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF1E63FF),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    status,
                    priority,
                    category,
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: textDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$name � $email',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textGrey,
                      ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 18,
                  runSpacing: 6,
                  children: [
                    _MetaRow(icon: Icons.access_time, label: createdAt),
                    _MetaRow(icon: Icons.chat_bubble_outline, label: messages),
                    if (assignedTo.isNotEmpty)
                      Text(
                        assignedTo,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: textGrey,
                            ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(actionIcon, size: 18, color: resolvedText),
            label: Text(
              actionLabel,
              style: TextStyle(color: resolvedText, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: actionColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketTag extends StatelessWidget {
  final String label;
  final Color bg;
  final Color text;

  const _TicketTag({
    required this.label,
    required this.bg,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: text,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: textGrey),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textGrey,
              ),
        ),
      ],
    );
  }
}
