String getText(String key, Map updateData, index) {
  if (updateData.containsKey(key) && index.id == key) {
    final value = updateData[key] ?? null;
    return value.toString();
  }
  return '';
}
