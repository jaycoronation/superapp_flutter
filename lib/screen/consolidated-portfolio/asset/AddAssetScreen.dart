import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAssetScreen extends StatefulWidget {
  final String? userId;

  /// 🔥 NEW
  final Map<String, dynamic>? existingData; // pass data for edit

  const AddAssetScreen({
    Key? key,
    this.userId,
    this.existingData,
  }) : super(key: key);

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final _formKey = GlobalKey<FormState>();

  String showSection = '';
  String? selectedInvestmentType;

  bool isEdit = false;

  Map<String, dynamic> formData = {};
  Map<String, TextEditingController> controllers = {};

  /// ================= INVESTMENT TYPE MAP =================

  final Map<String, String> investmentSectionMap = {
    '1': 'add_asset_1',
    '2': 'add_asset_2',
    '12': 'add_asset_3',
    '23': 'add_asset_4',
    '29': 'add_asset_5',
    '33': 'add_asset_6',
    '34': 'add_asset_7',
  };

  /// ================= FIELD MODEL =================

  /// ================= INIT =================

  @override
  void initState() {
    super.initState();

    if (widget.existingData != null) {
      isEdit = true;

      selectedInvestmentType =
          widget.existingData!["investment_type"]?.toString();

      showSection = investmentSectionMap[selectedInvestmentType] ?? '';

      formData = Map<String, dynamic>.from(widget.existingData!);
    }
  }

  /// ================= FORM CONFIG =================

  List<FieldConfig> getFields(String section) {
    switch (section) {
      case 'add_asset_1':
        return [
          FieldConfig(
              key: "scheme_name",
              label: "Scheme Name",
              type: "text",
              required: true),
          FieldConfig(key: "quantity", label: "Quantity", type: "number"),
          FieldConfig(
              key: "purchase_price", label: "Purchase Price", type: "number"),
          FieldConfig(
              key: "current_value",
              label: "Current Value",
              type: "number",
              required: true),
          FieldConfig(
              key: "transaction_date", label: "Transaction Date", type: "date"),
        ];

      case 'add_asset_2':
        return [
          FieldConfig(
              key: "bank_name",
              label: "Bank Name",
              type: "text",
              required: true),
          FieldConfig(
              key: "amount_invested",
              label: "Amount Invested",
              type: "number",
              required: true),
          FieldConfig(
              key: "interest_rate", label: "Interest Rate", type: "number"),
        ];

      case 'add_asset_3':
        return [
          FieldConfig(
              key: "property_name",
              label: "Property Name",
              type: "text",
              required: true),
          FieldConfig(key: "total_value", label: "Total Value", type: "number"),
          FieldConfig(
              key: "loan_outstanding",
              label: "Loan Outstanding",
              type: "number"),
        ];

      case 'add_asset_4':
        return [
          FieldConfig(
              key: "policy_name",
              label: "Policy Name",
              type: "text",
              required: true),
          FieldConfig(key: "premium", label: "Premium", type: "number"),
          FieldConfig(key: "sum_assured", label: "Sum Assured", type: "number"),
        ];

      case 'add_asset_5':
        return [
          FieldConfig(
              key: "given_to", label: "Given To", type: "text", required: true),
          FieldConfig(
              key: "loan_amount",
              label: "Loan Amount",
              type: "number",
              required: true),
        ];

      case 'add_asset_6':
        return [
          FieldConfig(
              key: "company_name",
              label: "Company Name",
              type: "text",
              required: true),
          FieldConfig(
              key: "number_of_shares",
              label: "Number of Shares",
              type: "number"),
        ];

      case 'add_asset_7':
        return [
          FieldConfig(
              key: "currency_name",
              label: "Currency Name",
              type: "text",
              required: true),
          FieldConfig(
              key: "market_value", label: "Market Value", type: "number"),
        ];

      default:
        return [];
    }
  }

  /// ================= FIELD BUILDER =================

  Widget buildField(FieldConfig field) {
    controllers.putIfAbsent(field.key, () {
      return TextEditingController(
        text: formData[field.key]?.toString() ?? '',
      );
    });

    switch (field.type) {
      case 'text':
        return buildTextField(field);
      case 'number':
        return buildNumberField(field);
      case 'date':
        return buildDateField(field);
      default:
        return const SizedBox();
    }
  }

  Widget buildTextField(FieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controllers[field.key],
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (field.required && (value == null || value.isEmpty)) {
            return "${field.label} is required";
          }
          return null;
        },
        onChanged: (val) => formData[field.key] = val,
      ),
    );
  }

  Widget buildNumberField(FieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controllers[field.key],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (field.required && (value == null || value.isEmpty)) {
            return "${field.label} is required";
          }
          return null;
        },
        onChanged: (val) => formData[field.key] = val,
      ),
    );
  }

  Widget buildDateField(FieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controllers[field.key],
        readOnly: true,
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (picked != null) {
            String formatted = DateFormat('yyyy-MM-dd').format(picked);
            controllers[field.key]!.text = formatted;
            formData[field.key] = formatted;
          }
        },
      ),
    );
  }

  /// ================= SUBMIT =================

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      formData["investment_type"] = selectedInvestmentType;

      if (isEdit) {
        debugPrint("UPDATE API CALL");
        // call update api
      } else {
        debugPrint("ADD API CALL");
        // call add api
      }

      Navigator.pop(context, formData);
    }
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    List<FieldConfig> fields = getFields(showSection);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Asset" : "Add Asset"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (!isEdit)
                DropdownButtonFormField<String>(
                  value: selectedInvestmentType,
                  decoration: const InputDecoration(
                    labelText: "Select Investment Type",
                    border: OutlineInputBorder(),
                  ),
                  items: investmentSectionMap.keys
                      .map((key) => DropdownMenuItem(
                            value: key,
                            child: Text("Investment Type $key"),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        selectedInvestmentType = val;
                        showSection = investmentSectionMap[val] ?? '';
                      });
                    }
                  },
                ),
              const SizedBox(height: 20),
              ...fields.map((field) => buildField(field)).toList(),
              ElevatedButton(
                onPressed: submitForm,
                child: Text(isEdit ? "Update Asset" : "Add Asset"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldConfig {
  final String key;
  final String label;
  final String type;
  final bool required;
  final List<String>? options;

  FieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.options,
  });
}
