import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();
    
    if (subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }
    
    if (message.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Обращение должно содержать минимум 10 символов')),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ваше обращение отправлено. Мы свяжемся с вами в ближайшее время.'),
        backgroundColor: Colors.green,
      ),
    );
    _subjectController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поддержка'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('main'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Телефон для связи:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8), const Text(
                  '+7 (800) 123-45-67',
                  style: TextStyle(fontSize: 20),),
                const SizedBox(height: 4), const Text(
                  'Работаем с 9:00 до 21:00 ежедневно',
                  style: TextStyle(fontSize: 14, color: Colors.grey),),
                const SizedBox(height: 24), const Divider(),
                const SizedBox(height: 16), const Text('Часто задаваемые вопросы:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12), const Text(
                  'Как оформить заказ?',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 4), const Text(
                  'Выберите продукты в разделе "Выбор продуктов", добавьте их в корзину и оформите заказ.',
                  style: TextStyle(fontSize: 14),),
                const SizedBox(height: 16), const Text(
                  'Как работает подписка?',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 4),
                const Text(
                  'Вы можете выбрать один или несколько вариантов подписки. Каждый месяц вам будет доставляться выбранный набор продуктов.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Как отменить заказ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Свяжитесь с нами по телефону или отправьте обращение через форму ниже.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Отправить обращение',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Краткое описание проблемы',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _messageController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Ваше обращение',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Отправить обращение'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

