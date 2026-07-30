import 'package:animate_do/animate_do.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../cubit/scanner_cubit.dart';
import '../cubit/scanner_state.dart';
import 'create_group_dialog.dart';

class CameraOverlayWidget extends StatelessWidget {
  final CameraState cameraState;

  const CameraOverlayWidget({
    super.key,
    required this.cameraState,
  });

  void _showNewGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => CreateGroupDialog(
        title: 'Switch to New Group',
        confirmText: 'Create & Switch',
        onSubmit: (newGroupName) {
          context.read<ScannerCubit>().switchToNewGroup(newGroupName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        final currentGroup = state.currentGroup;
        final groupName = currentGroup?.groupName ?? 'Default Group';
        final imageCount = state.currentGroupImageCount;

        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Bar: Active Group Badge Banner
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconsaxPlusBold.folder_open,
                          color: colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Current: ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          groupName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$imageCount ${imageCount == 1 ? 'image' : 'images'}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Controls Bar
              FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // "New Group" Button
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton.filledTonal(
                            onPressed: () => _showNewGroupDialog(context),
                            icon: Icon(
                              IconsaxPlusBold.folder_add,
                              color: colorScheme.secondary,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: colorScheme.surface.withValues(alpha: 0.2),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'New Group',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // Shutter Capture Button
                      AwesomeCaptureButton(
                        state: cameraState,
                      ),

                      // "Finish & Review" Button
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton.filled(
                            onPressed: () {
                              context.read<ScannerCubit>().finishSession();
                            },
                            icon: const Icon(
                              IconsaxPlusBold.tick_circle,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Finish Session',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
