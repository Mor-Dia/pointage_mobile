import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.connectivityplus.ConnectivityPlusPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine() {
        super.configureFlutterEngine()
        ConnectivityPlusPlugin.registerWith(flutterEngine?.dartExecutor)
    }
}
