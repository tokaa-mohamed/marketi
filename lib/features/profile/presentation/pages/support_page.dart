import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Support')),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSupportTicketCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Support ticket created!')),
              );
              Navigator.pop(context);
            } else if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Have an issue? Send us a message and we will get back to you shortly.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final isLoading = state is ProfileSupportTicketLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ProfileCubit>().createSupportTicket(
                                          subject: _subjectController.text,
                                          message: _messageController.text,
                                        );
                                  }
                                },
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Send Message'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
