# Package Guidelines Registry

This document serves as a central registry of all package guidelines in the project. Each entry links to its detailed documentation.

## Flutter Official Packages

| Package Name | Version | Guidelines Location | Last Updated | Status |
|-------------|---------|---------------------|--------------|---------|
| flutter_bloc | ^8.0.0 | [/package/flutter_bloc.md](package/flutter_bloc.md) | YYYY-MM-DD | ✅ Active |
| 

## Third Party Packages

| Package Name | Version | Guidelines Location | Last Updated | Status |
|-------------|---------|---------------------|--------------|---------|
| dio | ^5.0.0 | [/package/dio.md](package/dio.md) | YYYY-MM-DD | ✅ Active |
| 

## Internal Packages

| Package Name | Version | Guidelines Location | Last Updated | Status |
|-------------|---------|---------------------|--------------|---------|
| 

## Widgets

| Widget Name | Category | Guidelines Location | Last Updated | Status |
|-------------|----------|---------------------|--------------|---------|
| AppDropDownWidget | Input | [/widget/app_dropdown_widget.md](widget/app_dropdown_widget.md) | YYYY-MM-DD | ✅ Active |

## Data Sources

| Source Name | Type | Guidelines Location | Last Updated | Status |
|-------------|------|---------------------|--------------|---------|
| UserDataSource | Remote | [/datasource/user_datasource.md](datasource/user_datasource.md) | YYYY-MM-DD | ✅ Active |

## Status Legend
- ✅ Active: Guidelines are up to date and actively maintained
- 🚧 Draft: Guidelines are being written/reviewed
- ⚠️ Outdated: Guidelines need updating
- 🔄 Updating: Guidelines are being updated
- ❌ Deprecated: Package/Widget is deprecated

## Guidelines Structure
Each component has associated files in these directories:

1. Packages: `b-global-doc/package&widget-guidelines/package/{package_name}.md`
2. Widgets: `b-global-doc/package&widget-guidelines/widget/{widget_name}.md`
3. Data Sources: `b-global-doc/package&widget-guidelines/datasource/{source_name}.md`
4. Tests: `b-global-doc/package&widget-guidelines/test/{component_name}_test.md`

## Contribution
To add new guidelines:
1. Copy templates from respective directories:
   - Package: `template/code_template.md`
   - Widget: `/widget/_template.md`
   - DataSource: `/datasource/_template.md`
   - Test: `/test/_template.md`
2. Fill in the templates
3. Update this registry
4. Submit for review

## Maintenance
- Guidelines should be reviewed every 6 months
- Update version numbers when packages are upgraded
- Mark as ⚠️ Outdated if guidelines don't match current version
- Archive deprecated guidelines in respective `/archived/` folders

---
Last Updated: YYYY-MM-DD 
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->


