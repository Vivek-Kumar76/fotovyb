class MessageModel {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String text;
  final String time;
  final bool isMe;
  final FileAttachment? attachment;

  const MessageModel({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.text,
    required this.time,
    required this.isMe,
    this.attachment,
  });
}

class FileAttachment {
  final String fileName;
  final String fileSize;
  final String fileType;

  const FileAttachment({
    required this.fileName,
    required this.fileSize,
    required this.fileType,
  });
}