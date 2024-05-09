import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropdownButton extends StatelessWidget {
  final bool enabled;
  final String actionValue;
  final List<String> actionValues;
  final void Function(String?) onChanged;

  const CustomDropdownButton({
    super.key,
    required this.enabled,
    required this.actionValue,
    required this.actionValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return IgnorePointer(
        ignoring: !enabled,
        child: Container(
          decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: enabled ? Colors.blue : Colors.grey[400]!,
              width: 2.0,
            ),
          ),
          child: DropdownButton<String>(
            value: actionValue,
            padding: const EdgeInsets.only(
                left: 16.0, top: 4.0, bottom: 4.0, right: 8.0),
            icon: Icon(Icons.keyboard_arrow_down,
                color: enabled ? Colors.blue : Colors.grey[400]),
            items: actionValues.map((String items) {
              return DropdownMenuItem<String>(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(
                    color: enabled ? Colors.black : Colors.grey[600],
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            style: TextStyle(
              color: enabled ? Colors.black : Colors.grey[600],
              fontSize: 16.0,
            ),
            underline: Container(),
          ),
        ),
      );
    });
  }
}

class IpForm extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;

  const IpForm({super.key, required this.controller, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: enabled ? Colors.grey : Colors.grey[400]!,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter IP/Domain',
            ),
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class TTLForm extends StatelessWidget {
  final bool visible;
  final bool enabled;
  final bool label;
  final ValueNotifier<int?> selectedValue;

  const TTLForm({
    super.key, // Adding Key? key parameter
    required this.visible,
    required this.enabled,
    required this.label,
    required this.selectedValue,
  }); // Passing key to super constructor

  @override
  Widget build(BuildContext context) {
    // Generating a list of dropdown menu items from 0 to 100
    final List<DropdownMenuItem<int>> dropdownItems = List.generate(
      500,
      (int index) => DropdownMenuItem<int>(
        value: index + 1,
        child: Text('${index + 1}'),
      ),
    );

    return Builder(builder: (BuildContext context) {
      return IgnorePointer(
        ignoring: !enabled,
        child: Visibility(
          visible: visible,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: enabled ? Colors.grey : Colors.grey[400]!,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  // Removed 'const' from InputDecoration
                  border: InputBorder.none,
                  labelText: label ? "Time-to-live" : "Timeout",
                ),
                value: selectedValue.value,
                items: dropdownItems,
                onChanged: enabled
                    ? (int? newValue) {
                        selectedValue.value = newValue;
                      }
                    : null,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PortRangeForm extends StatelessWidget {
  final bool visible;
  final bool enabled;
  final ValueNotifier<int?> selectedPortType;

  const PortRangeForm({
    super.key,
    required this.visible,
    required this.enabled,
    required this.selectedPortType,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> portRangeOptionsDisplay = [
      'Well-Known Port: 0 - 1023',
      'Registered Port: 1024 - 49151',
      'Dynamic Port: 49152 - 65565',
    ];

    final List<int> portRangeOptions = [
      0,
      1,
      2
    ]; // Corresponding integer values

    return IgnorePointer(
      ignoring: !enabled,
      child: Visibility(
        visible: visible,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: enabled ? Colors.grey : Colors.grey[400]!,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Port Range',
              ),
              value: selectedPortType.value,
              items: portRangeOptions.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(portRangeOptionsDisplay[value]),
                );
              }).toList(),
              onChanged: enabled
                  ? (int? newValue) {
                      selectedPortType.value = newValue;
                    }
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class DNSServerForm extends StatelessWidget {
  final bool visible;
  final bool enabled;
  final TextEditingController inputServer;

  const DNSServerForm({
    super.key,
    required this.visible,
    required this.enabled,
    required this.inputServer,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'DNS Server',
          ),
          enabled: enabled,
          controller: inputServer,
        ),
      ),
    );
  }
}

class ExecuteButton extends StatelessWidget {
  final bool enabled;
  final String actionValue;
  final void Function(String) onPressed;
  final void Function(String?) stopPressed;

  const ExecuteButton({
    super.key,
    required this.enabled,
    required this.actionValue,
    required this.onPressed,
    required this.stopPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(children: [
            Visibility(
              visible: enabled,
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: enabled ? Colors.blue : Colors.grey[400],
                    textStyle: TextStyle(
                      color: enabled ? Colors.black : Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: enabled ? () => onPressed(actionValue) : null,
                  child: const Text('Execute'),
                ),
              ),
            ),
            Visibility(
                visible: !enabled,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: !enabled ? () => stopPressed("") : null,
                    child: const Text('Stop'),
                  ),
                ))
          ]));
    });
  }
}

class CustomResultWidget extends StatelessWidget {
  final bool visibleProgress;
  final int currentPort;
  final int endPort;
  final String actionValue;
  final String result;

  const CustomResultWidget({
    super.key,
    required this.visibleProgress,
    required this.currentPort,
    required this.endPort,
    required this.actionValue,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: visibleProgress,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: currentPort / endPort, // Calculate progress value
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Progress: $currentPort / $endPort',
                  // Display current progress value
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
            child: Text(
              "$actionValue's Result\n$result",
              textAlign: TextAlign.center,
            ),
          )
        ]);
  }
}
