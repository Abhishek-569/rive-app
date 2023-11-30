part of 'app_pages.dart';


abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const FACE_DETECTOR_GALLERY = _Paths.FACE_DETECTOR_GALLERY;
  static const RIVE = _Paths.RIVE;
  static const SPEECH = _Paths.SPEECH;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const FACE_DETECTOR_GALLERY = '/face-detector-gallery';
  static const RIVE = '/rive';
  static const SPEECH = '/speech';
}
