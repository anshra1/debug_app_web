What is AppTheme?
AppTheme is our custom design system that provides a unified way to manage colors, typography, spacing, and other design tokens across the entire Flutter application. It's built on top of Flutter's theming but offers more structure and type safety.

AppThemeData (tokens) 
    ↓ 
AppTheme widget (provides)
    ↓
Context extensions (access)
    ↓
Components (consume)
    ↓
AppFlutterTheme (converts to Flutter)
    ↓
MaterialApp (applies)