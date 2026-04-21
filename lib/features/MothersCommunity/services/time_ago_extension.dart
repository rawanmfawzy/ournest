extension TimeAgoExtension on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final diff = now.difference(this);

    // لو التاريخ في المستقبل
    if (diff.isNegative) return "just now";

    if (diff.inHours < 60) {
      return "just now";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours} hr ago";
    }

    if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    }

    final weeks = (diff.inDays / 7).floor();
    if (diff.inDays < 30) {
      return "$weeks week${weeks > 1 ? 's' : ''} ago";
    }

    final months = (diff.inDays / 30).floor();
    if (diff.inDays < 365) {
      return "$months month${months > 1 ? 's' : ''} ago";
    }

    final years = (diff.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }
}