import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../shared/data/models/employee_model.dart';
import '../widgets/employee_card.dart';

class EmployeeDirectoryPage extends StatefulWidget {
  const EmployeeDirectoryPage({super.key});

  @override
  State<EmployeeDirectoryPage> createState() => _EmployeeDirectoryPageState();
}

class _EmployeeDirectoryPageState extends State<EmployeeDirectoryPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<EmployeeModel> _allEmployees = _generateMockEmployees();
  List<EmployeeModel> _filteredEmployees = [];
  String _selectedDepartment = 'All';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filteredEmployees = _allEmployees;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterEmployees();
  }

  void _filterEmployees() {
    setState(() {
      _filteredEmployees = _allEmployees.where((employee) {
        final matchesSearch =
            employee.name.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            employee.role.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            employee.department.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );

        final matchesDepartment =
            _selectedDepartment == 'All' ||
            employee.department == _selectedDepartment;

        return matchesSearch && matchesDepartment;
      }).toList();
    });
  }

  void _onDepartmentChanged(String? department) {
    if (department != null) {
      setState(() {
        _selectedDepartment = department;
      });
      _filterEmployees();
    }
  }

  void _onEmployeeTap(EmployeeModel employee) {
    _showEmployeeDetails(employee);
  }

  void _showEmployeeDetails(EmployeeModel employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildEmployeeDetails(employee),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshEmployees,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildEmployeeCount(),
          Expanded(
            child: _isLoading
                ? const LoadingWidget(message: 'Loading employees...')
                : _buildEmployeeGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          CustomTextField(
            labelText: 'Search employees...',
            controller: _searchController,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.filter_list, color: AppColors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedDepartment,
                  decoration: InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: _getDepartments().map((department) {
                    return DropdownMenuItem(
                      value: department,
                      child: Text(department),
                    );
                  }).toList(),
                  onChanged: _onDepartmentChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCount() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Text(
        '${_filteredEmployees.length} employee${_filteredEmployees.length == 1 ? '' : 's'} found',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmployeeGrid() {
    if (_filteredEmployees.isEmpty) {
      return _buildEmptyState();
    }

    final crossAxisCount = _getCrossAxisCount(context);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _filteredEmployees.length,
      itemBuilder: (context, index) {
        final employee = _filteredEmployees[index];
        return EmployeeCard(
          employee: employee,
          onTap: () => _onEmployeeTap(employee),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No employees found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter criteria',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeDetails(EmployeeModel employee) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: employee.profilePicture != null
                ? ClipOval(
                    child: Image.network(
                      employee.profilePicture!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDetailAvatar(employee.name);
                      },
                    ),
                  )
                : _buildDetailAvatar(employee.name),
          ),
          const SizedBox(height: 16),
          Text(
            employee.name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            employee.role,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildDetailRow(Icons.business, 'Department', employee.department),
          _buildDetailRow(Icons.email, 'Email', employee.email),
          if (employee.phone != null)
            _buildDetailRow(Icons.phone, 'Phone', employee.phone!),
          _buildDetailRow(
            Icons.calendar_today,
            'Join Date',
            '${employee.joinDate.day}/${employee.joinDate.month}/${employee.joinDate.year}',
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _launchEmail(employee.email),
                  icon: const Icon(Icons.email),
                  label: const Text('Email'),
                ),
              ),
              const SizedBox(width: 12),
              if (employee.phone != null)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchPhone(employee.phone!),
                    icon: const Icon(Icons.phone),
                    label: const Text('Call'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailAvatar(String name) {
    return Text(
      _getInitials(name),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.grey, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    if (context.isDesktop) return 4;
    if (context.isTablet) return 3;
    return 2;
  }

  List<String> _getDepartments() {
    final departments = _allEmployees
        .map((employee) => employee.department)
        .toSet()
        .toList();
    departments.sort();
    return ['All', ...departments];
  }

  String _getInitials(String name) {
    final names = name.trim().split(' ');
    if (names.isEmpty) return 'N/A';
    if (names.length == 1) return names[0].substring(0, 1).toUpperCase();
    return '${names[0].substring(0, 1)}${names[names.length - 1].substring(0, 1)}'
        .toUpperCase();
  }

  void _refreshEmployees() {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        context.showSnackBar('Employee directory refreshed');
      }
    });
  }

  void _launchEmail(String email) {
    context.showSnackBar('Opening email to $email');
    // TODO: Implement email launching
  }

  void _launchPhone(String phone) {
    context.showSnackBar('Calling $phone');
    // TODO: Implement phone call launching
  }

  static List<EmployeeModel> _generateMockEmployees() {
    return [
      EmployeeModel(
        id: 1,
        name: 'Alice Johnson',
        role: 'Senior Software Engineer',
        department: 'Engineering',
        email: 'alice.johnson@company.com',
        phone: '+1 (555) 123-4567',
        joinDate: DateTime(2020, 3, 15),
        profilePicture: 'https://randomuser.me/api/portraits/women/1.jpg',
      ),
      EmployeeModel(
        id: 2,
        name: 'Bob Smith',
        role: 'Product Manager',
        department: 'Product',
        email: 'bob.smith@company.com',
        phone: '+1 (555) 234-5678',
        joinDate: DateTime(2019, 8, 22),
        profilePicture: 'https://randomuser.me/api/portraits/men/2.jpg',
      ),
      EmployeeModel(
        id: 3,
        name: 'Carol Davis',
        role: 'UX Designer',
        department: 'Design',
        email: 'carol.davis@company.com',
        phone: '+1 (555) 345-6789',
        joinDate: DateTime(2021, 1, 10),
        profilePicture: 'https://randomuser.me/api/portraits/women/3.jpg',
      ),
      EmployeeModel(
        id: 4,
        name: 'David Wilson',
        role: 'Marketing Specialist',
        department: 'Marketing',
        email: 'david.wilson@company.com',
        phone: '+1 (555) 456-7890',
        joinDate: DateTime(2022, 5, 18),
      ),
      EmployeeModel(
        id: 5,
        name: 'Eva Martinez',
        role: 'HR Manager',
        department: 'Human Resources',
        email: 'eva.martinez@company.com',
        phone: '+1 (555) 567-8901',
        joinDate: DateTime(2018, 11, 3),
        profilePicture: 'https://randomuser.me/api/portraits/women/5.jpg',
      ),
      EmployeeModel(
        id: 6,
        name: 'Frank Chen',
        role: 'DevOps Engineer',
        department: 'Engineering',
        email: 'frank.chen@company.com',
        phone: '+1 (555) 678-9012',
        joinDate: DateTime(2021, 9, 7),
      ),
      EmployeeModel(
        id: 7,
        name: 'Grace Lee',
        role: 'Data Analyst',
        department: 'Analytics',
        email: 'grace.lee@company.com',
        phone: '+1 (555) 789-0123',
        joinDate: DateTime(2020, 12, 14),
        profilePicture: 'https://randomuser.me/api/portraits/women/7.jpg',
      ),
      EmployeeModel(
        id: 8,
        name: 'Henry Brown',
        role: 'Sales Representative',
        department: 'Sales',
        email: 'henry.brown@company.com',
        phone: '+1 (555) 890-1234',
        joinDate: DateTime(2023, 2, 28),
      ),
    ];
  }
}
