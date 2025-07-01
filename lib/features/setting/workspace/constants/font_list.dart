import 'package:debug_app_web/core/widgets/atoms/inputs/app_drop_down_widget.dart';
import 'package:google_fonts/google_fonts.dart';

List<SimpleDropdownItem> fontItemsList = [
  // System font
  const SimpleDropdownItem('System', ''),

  // Top 8 Developer Fonts
  SimpleDropdownItem(
    'Inter',
    GoogleFonts.inter().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Roboto',
    GoogleFonts.roboto().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Open Sans',
    GoogleFonts.openSans().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Lato',
    GoogleFonts.lato().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'JetBrains Mono',
    GoogleFonts.jetBrainsMono().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Fira Code',
    GoogleFonts.firaCode().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Source Code Pro',
    GoogleFonts.sourceCodePro().fontFamily ?? '',
  ),
  SimpleDropdownItem(
    'Poppins',
    GoogleFonts.poppins().fontFamily ?? '',
  ),
];
