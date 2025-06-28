String categorizeError(String errorMessage) {
  if (errorMessage.contains('SocketException')) {
    return 'Network Error';
  } else if (errorMessage.contains('MissingPluginException')) {
    return 'Dependency Error';
  } else if (errorMessage.contains('NoSuchMethodError')) {
    return 'Logic Error';
  } else if (errorMessage.contains('DatabaseException')) {
    return 'Database Error';
  } else {
    return 'Uncategorized';
  }
}
