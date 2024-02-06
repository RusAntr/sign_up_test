import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_test/features/auth/domain/bloc/user_cubit/user_cubit.dart';

/// Defines possible editing types
enum EditType {
  name,
  lastName;
}

class ChangeFieldScreen extends StatefulWidget {
  const ChangeFieldScreen({super.key, required this.editType});

  /// Edit type to know if we are editing first name or last name
  final EditType editType;

  @override
  State<ChangeFieldScreen> createState() => _ChangeFieldScreenState();
}

class _ChangeFieldScreenState extends State<ChangeFieldScreen> {
  late UserCubit _cubit;
  late final _editingController = TextEditingController();

  /// Text in app bar and field hint
  String get _titleText {
    switch (widget.editType) {
      case EditType.name:
        return 'Ваше Имя';
      case EditType.lastName:
        return 'Ваша Фамилия';
    }
  }

  @override
  void initState() {
    _cubit = context.read<UserCubit>();
    super.initState();
  }

  /// Updates user
  void _updateUser() async {
    switch (widget.editType) {
      case EditType.name:
        return await _cubit.updateUser(
          _cubit.state.copyWith(name: _editingController.text),
        );
      case EditType.lastName:
        return await _cubit.updateUser(
          _cubit.state.copyWith(lastName: _editingController.text),
        );
    }
  }

  /// Initial text in the field
  String get _initialText {
    switch (widget.editType) {
      case EditType.name:
        return _cubit.state.name ?? _titleText;
      case EditType.lastName:
        return _cubit.state.lastName ?? _titleText;
    }
  }

  /// Disposes text editing controller and cubit
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,

        /// App bar
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leadingWidth: 150,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                Text(
                  'Аккаунт',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            ),
          ),
          title: Text(_titleText),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Divider(
              thickness: 0.6,
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),

            /// Text form field
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: TextFormField(
                  controller: _editingController,
                  onFieldSubmitted: (_) => _updateUser(),
                  decoration: InputDecoration(
                      hintText: _initialText,
                      isDense: true,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
