import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:ecobin/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final double iconSize;
  const UserAvatar({super.key, this.size = 100, this.iconSize = 50});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: _buildAvatarContent(state),
        );
      },
    );
  }

  Widget _buildAvatarContent(ProfileState state) {
    if (state is ProfileLoading) {
      return Skeletonizer(
        enabled: true,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.kAntiFlashWhite,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      );
    }

    if (state is ProfileLoaded && state.user.avatar != null) {
      return Image.network(
        state.user.avatar!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
            ? child
            : Skeletonizer(
                enabled: true,
                child: Container(
                  width: size,
                  height: size,
                  color: AppColors.kAntiFlashWhite,
                ),
              ),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.kAntiFlashWhite,
        borderRadius: BorderRadius.circular(size),
      ),
      child: Icon(Icons.person, size: 50, color: AppColors.kPayneGray),
    );
  }
}
