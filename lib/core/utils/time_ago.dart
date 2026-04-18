extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return "just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else {
      return toLocal().toString().split(' ')[0];
    }
  }
}