import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/chat_message_model.dart';

class ChatScreen extends StatefulWidget {
  final String hostName;
  final String spotName;

  const ChatScreen({super.key, required this.hostName, required this.spotName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      senderId: 'host_01',
      text: 'Olá! A sua vaga já está autorizada na portaria com o síndico. Pode entrar com o Corolla Preto!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      isFromCurrentUser: false,
    ),
  ];

  void _sendMessage([String? quickText]) {
    final text = (quickText ?? _messageController.text).trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: 'me',
          text: text,
          timestamp: DateTime.now(),
          isFromCurrentUser: true,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.hostName, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
            Text(widget.spotName, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Respostas Rápidas para Portaria
          Container(
            height: 42,
            margin: const EdgeInsets.only(top: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildQuickAction('Cheguei na portaria'),
                _buildQuickAction('Porteiro pediu o nome do morador'),
                _buildQuickAction('Onde fica a vaga?'),
                _buildQuickAction('Carro Corolla Preto - BRA2E19'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isFromCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: message.isFromCurrentUser ? AppColors.primaryBlue : AppColors.cardSurface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Text(
                      message.text,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.cardSurface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Combinar detalhes da portaria...',
                      hintStyle: const TextStyle(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.darkBackground,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.primaryBlue),
                  onPressed: () => _sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        backgroundColor: AppColors.cardSurface,
        label: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        onPressed: () => _sendMessage(label),
      ),
    );
  }
}
