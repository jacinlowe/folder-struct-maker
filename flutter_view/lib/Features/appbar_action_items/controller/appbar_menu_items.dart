enum AppbarMenuItemEnum {
  file('File'),
  edit('Edit'),
  settings('Settings'),
  help('Help'),
  about('About');

  final String value;
  const AppbarMenuItemEnum(this.value);

  String get name {
    switch (this) {
      case AppbarMenuItemEnum.file:
        return 'File';
      case AppbarMenuItemEnum.edit:
        return 'Edit';
      case AppbarMenuItemEnum.settings:
        return 'Settings';
      case AppbarMenuItemEnum.help:
        return 'Help';
      case AppbarMenuItemEnum.about:
        return 'About';
      default:
        return 'File';
    }
  }
}
