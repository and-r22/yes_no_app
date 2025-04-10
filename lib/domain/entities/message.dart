enum FromWho { me, his }

class Message {

  Message({
    required this.text, 
    required this.fromWho, 
    this.imageUrl,
  });
  
  final String text;
  final String? imageUrl;
  final FromWho fromWho;
}
