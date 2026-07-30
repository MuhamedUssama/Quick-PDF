import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../cubit/scanner_cubit.dart';
import '../cubit/scanner_state.dart';
import '../widgets/camera_overlay_widget.dart';
import '../widgets/create_group_dialog.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _promptInitialGroup();
    });
  }

  void _promptInitialGroup() {
    final cubit = context.read<ScannerCubit>();
    if (cubit.state.currentGroup == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => CreateGroupDialog(
          title: 'Start New Session',
          confirmText: 'Start Scanning',
          onSubmit: (initialGroupName) {
            cubit.startNewSession(initialGroupName);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<ScannerCubit, ScannerState>(
        listener: (context, state) {
          if (state.status == ScannerStatus.error && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          } else if (state.status == ScannerStatus.sessionFinished) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Session finished with ${state.sessionGroups.length} groups captured!',
                ),
                backgroundColor: theme.colorScheme.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          return CameraAwesomeBuilder.custom(
            saveConfig: SaveConfig.photo(
              pathBuilder: (sensors) async {
                final dir = await getTemporaryDirectory();
                final filePath =
                    '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                return SingleCaptureRequest(filePath, sensors.first);
              },
            ),
            onMediaCaptureEvent: (event) {
              if (event.status == MediaCaptureStatus.success && event.isPicture) {
                final path = event.captureRequest.when(
                  single: (single) => single.file?.path,
                  multiple: (multiple) =>
                      multiple.fileBySensor.values.first?.path,
                );
                if (path != null) {
                  context.read<ScannerCubit>().capturePhoto(path);
                }
              }
            },
            builder: (cameraState, preview) {
              return CameraOverlayWidget(
                cameraState: cameraState,
              );
            },
          );
        },
      ),
    );
  }
}
