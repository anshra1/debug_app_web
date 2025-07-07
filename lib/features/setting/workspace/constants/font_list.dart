import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:google_fonts/google_fonts.dart';

List<SimpleDropdownItem<String>> fontItemsList = [
  // System font
  const SimpleDropdownItem<String>('System', ''),

  // Top 8 Developer Fonts
  SimpleDropdownItem<String>(
    'Inter',
    GoogleFonts.inter().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Roboto',
    GoogleFonts.roboto().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Open Sans',
    GoogleFonts.openSans().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Lato',
    GoogleFonts.lato().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'JetBrains Mono',
    GoogleFonts.jetBrainsMono().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Fira Code',
    GoogleFonts.firaCode().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Source Code Pro',
    GoogleFonts.sourceCodePro().fontFamily ?? '',
  ),
  SimpleDropdownItem<String>(
    'Poppins',
    GoogleFonts.poppins().fontFamily ?? '',
  ),
];
