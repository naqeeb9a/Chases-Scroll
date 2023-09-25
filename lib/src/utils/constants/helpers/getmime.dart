String getMimeType(String fileName) {
  String mimeType = '';
  if (fileName.endsWith('.png')) {
    mimeType = 'image/png';
  } else if (fileName.endsWith('.jpeg') || fileName.endsWith('.jpg')) {
    mimeType = 'image/jpeg';
  }

  return mimeType;
}
