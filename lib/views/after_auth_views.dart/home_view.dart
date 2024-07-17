import 'package:comments_app/services/firebase_auth_service.dart';
import 'package:comments_app/services/firebase_remote_config_service.dart';
import 'package:comments_app/view_models/after_auth_view_models/home_view_model.dart';
import 'package:comments_app/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final FirebaseRemoteConfigService _remoteConfig = FirebaseRemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(
        authService: Provider.of<FirebaseAuthService>(context),
        remoteConfigService: _remoteConfig,
        context: context
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: _buildAppBar(context, viewModel),
          body: viewModel.isBusy ? const Center(child: CircularProgressIndicator()): _buildBody(viewModel),
        );
      },
    );
  }

  // Builds the AppBar widget
  AppBar _buildAppBar(BuildContext context, HomeViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Comments',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () async {
            await viewModel.signOut();
          },
        ),
      ],
    );
  }

  // Builds the body of the HomeView widget
  Widget _buildBody(HomeViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: viewModel.comments
            .map((comment) => ProfileCard(comment: comment, remoteConfigService: _remoteConfig,))
            .toList(),
      ),
    );
  }
}
