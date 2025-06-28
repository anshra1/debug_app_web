# 📘 Documentation for `core/widgets/atoms/buttons/text_field_button_with_label.dart`

i make a json file i want you to convert into plain text so that i can know if is correctly created by ai or not {
  "widget_name": "TextFieldButtonWithLabel",
  "type": "HookWidget",
  "description": "A customizable text field with a label and an icon that allows for inline editing and validation.",
  "properties": {
    "config": {
      "type": "TextFieldButtonWithLabelConfig",
      "required": true,
      "description": "Configuration settings for the appearance and behavior of the text field."
    },
    "labelText": {
      "type": "String",
      "required": true,
      "description": "The label text displayed above the text field."
    },
    "iconData": {
      "type": "IconData",
      "required": true,
      "description": "The icon displayed alongside the text field."
    },
    "startingText": {
      "type": "String",
      "required": true,
      "description": "The initial text displayed in the text field."
    },
    "onTextSubmitted": {
      "type": "Function(String)",
      "required": true,
      "description": "Callback function triggered when the text is submitted."
    },
    "validators": {
      "type": "List<ValidatorFunction>",
      "required": false,
      "description": "List of validation functions to validate the input text."
    },
    "inputFormatters": {
      "type": "List<TextInputFormatter>",
      "required": false,
      "description": "List of input formatters to control the input text format."
    },
    "tooltipText": {
      "type": "String",
      "required": false,
      "description": "Tooltip text displayed when hovering over the text field."
    }
  },
  "behavior": {
    "tapToEdit": "Allows the user to tap the text field to enter editing mode.",
    "validation": "Validates the input text based on provided validators.",
    "focusHandling": "Manages focus state for the text field during editing."
  },
  "ui_elements": {
    "card": {
      "style": "RoundedRectangleBorder with border radius and color based on config."
    },
    "label": {
      "style": "TextStyle defined in config.",
      "visibility": "Displayed if labelText is not empty."
    },
    "textField": {
      "style": "TextStyle defined in config.",
      "decoration": "Includes borders and padding based on config."
    },
    "icon": {
      "position": "Left or right based on config.",
      "size": "Defined in config."
    },
    "validationMessage": {
      "style": "TextStyle defined in config or default red color.",
      "visibility": "Displayed if validation fails."
    }
  },
  "callbacks": {
    "onTextSubmitted": "Triggered when the user submits the text.",
    "onTap": "Triggered when the text field is tapped to enter editing mode.",
    "onEditingComplete": "Triggered when the user finishes editing the text."
  },
  "example_usage": "TextFieldButtonWithLabel(\n  config: TextFieldButtonWithLabelConfig.defaultConfig(),\n  labelText: 'Enter your name',\n  iconData: Icons.person,\n  startingText: '',\n  onTextSubmitted: (text) => print('Submitted: $text'),\n)",
  "notes": "The widget uses hooks for state management and requires Flutter Hooks package."
}