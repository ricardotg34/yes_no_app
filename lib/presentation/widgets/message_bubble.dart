import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment:
          message.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: message.isMine ? colors.primary : colors.secondary,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: message.isMine ? 10 : 5,
        ),
        if (!message.isMine) ...[
          _ImageBubble(
            url: message.imageUrl!,
          ),
          const SizedBox(
            height: 10,
          )
        ]
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String url;
  const _ImageBubble({required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url,
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : Container(
                    width: size.width * 0.7,
                    height: 150,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text('Daniela está mandando un mensaje'),
                  );
          },
        ));
  }
}
