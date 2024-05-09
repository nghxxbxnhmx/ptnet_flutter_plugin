import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropdownButton extends StatelessWidget {
  final bool executeEnable;
  final String actionValue;
  final List<String> actionValues;
  final void Function(String?) onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.executeEnable,
    required this.actionValue,
    required this.actionValues,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return IgnorePointer(
        ignoring: !executeEnable,
        child: Container(
          decoration: BoxDecoration(
            color: executeEnable ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: executeEnable ? Colors.blue : Colors.grey[400]!,
              width: 2.0,
            ),
          ),
          child: DropdownButton<String>(
            value: actionValue,
            padding: const EdgeInsets.only(
                left: 16.0, top: 4.0, bottom: 4.0, right: 8.0),
            icon: Icon(Icons.keyboard_arrow_down,
                color: executeEnable ? Colors.blue : Colors.grey[400]),
            items: actionValues.map((String items) {
              return DropdownMenuItem<String>(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(
                    color: executeEnable ? Colors.black : Colors.grey[600],
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            style: TextStyle(
              color: executeEnable ? Colors.black : Colors.grey[600],
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
  final TextEditingController controller;

  const IpForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter IP/Domain',
        ),
        controller: controller,
      ),
    );
  }
}

class TTLForm extends StatelessWidget {
  final bool visible;
  final bool enabled;
  final TextEditingController controller;

  const TTLForm({
    Key? key,
    required this.visible,
    required this.enabled,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Time-to-live (ttl)',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          enabled: enabled,
          controller: controller,
        ),
      ),
    );
  }
}

class PortRangeForm extends StatelessWidget {
  final bool visible;
  final bool enabled;
  final bool editEnable;
  final TextEditingController inputPortStart;
  final TextEditingController inputPortEnd;

  const PortRangeForm({
    Key? key,
    required this.visible,
    required this.enabled,
    required this.editEnable,
    required this.inputPortStart,
    required this.inputPortEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: IgnorePointer(
          ignoring: !editEnable,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: editEnable ? Colors.white : Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Start',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    enabled: enabled,
                    controller: inputPortStart,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: editEnable ? Colors.white : Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'End',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    enabled: enabled,
                    controller: inputPortEnd,
                  ),
                ),
              ),
            ],
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
    Key? key,
    required this.visible,
    required this.enabled,
    required this.inputServer,
  }) : super(key: key);

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
  final bool executeEnable;
  final String actionValue;
  final void Function(String) onPressed;
  final void Function(String?) stopPressed;

  const ExecuteButton({
    Key? key,
    required this.executeEnable,
    required this.actionValue,
    required this.onPressed,
    required this.stopPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(children: [
            Visibility(
              visible: executeEnable,
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        executeEnable ? Colors.blue : Colors.grey[400],
                    textStyle: TextStyle(
                      color: executeEnable ? Colors.black : Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed:
                      executeEnable ? () => onPressed(actionValue) : null,
                  child: const Text('Execute'),
                ),
              ),
            ),
            Visibility(
                visible: !executeEnable,
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
                    onPressed: !executeEnable ? () => stopPressed("") : null,
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
    Key? key,
    required this.visibleProgress,
    required this.currentPort,
    required this.endPort,
    required this.actionValue,
    required this.result,
  }) : super(key: key);

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
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Text(
            "$actionValue's Result\n$result",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
