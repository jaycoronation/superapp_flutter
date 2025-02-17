package tvs.mob.excelnet.alpha

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.core.app.TaskStackBuilder
import investwell.utils.AppSession
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONException
import org.json.JSONObject
import java.lang.Exception

class MainActivity: FlutterActivity() {
    private val CHANNEL = "mint-android-app"
    private var msession: AppSession?= null
    companion object{
        var sdkInitialized:Boolean?=false
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
//        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)
        showToast("OnCreate")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }
        msession = AppSession(this@MainActivity)
        super.onCreate(savedInstanceState)
        // mintSDK Invoke
//        invoke()
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        flutterEngine?.dartExecutor?.binaryMessenger?.let {  MethodChannel(it,CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openMintLib") {
                try {
                    var domain =""
                    var sso =""
                    var fcm =""
                    val argumentsString: String? = call.arguments?.toString()
                    val tokenResponse = JSONObject(call.arguments.toString())
                    if (tokenResponse.toString().isEmpty()){
                        argumentsString.let { jsonString->
                            try {
                                val newResponse = JSONObject(jsonString)
                                domain = newResponse.optString("domain")
                                sso = newResponse.optString("ssoToken")
                                fcm = newResponse.optString("fcmToken")
                            }catch (e:Exception){e.printStackTrace()}
                        }
                    }else{
                        domain = tokenResponse.optString("domain")
                        sso = tokenResponse.optString("ssoToken")
                        fcm = tokenResponse.optString("fcmToken")
                    }
//                    invokeSDK(sso,fcm,domain)
//                    invoke(sso, fcmToken = fcm, domain = domain)
                    sdkInitialized = true
                    val taskStackBuilder = TaskStackBuilder.create(this@MainActivity)
                    val intentsdk = Intent(this@MainActivity, MintSDKInit::class.java)
                    intentsdk.putExtra("route","main")
//                    intentsdk.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_PREVIOUS_IS_TOP)
                    intentsdk.putExtra("sso",sso)
                    intentsdk.putExtra("domain",domain)
                    intentsdk.putExtra("fcm",fcm)
                    msession = AppSession(this)
                    msession!!.callFromPackage = "com.example.clientuser.java.MainActivityJ"
                    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
                        // For below Android 12, use TaskStackBuilder to preserve the stack
                        TaskStackBuilder.create(this)
                            .addNextIntentWithParentStack(intentsdk)
                            .startActivities()
                    } else {
                        // For Android 12 and above, use the standard startActivity
                        startActivity(intentsdk)
                    }
                    result.success("Success")
                }catch (e: JSONException) {
                    // Handle JSON parsing error
                    result.error("JSON Parsing Error", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        } }
    }
    override fun onStart() {
        showToast("onStart")
        super.onStart()
    }
    override fun onResume() {
        showToast("onResume")
        super.onResume()
    }
    override fun onRestart() {
        showToast("onRestart")
        super.onRestart()
    }
    override fun onPause() {
        showToast("onPause")
        super.onPause()
    }
    override fun onStop() {
        showToast("onStop")
        super.onStop()
    }
    override fun onDestroy() {
        showToast("onDestroy")
        super.onDestroy()
    }
    fun showToast(message:String?){
        println("SDK App6--> $message")
        Toast.makeText(this@MainActivity,"SDK App      --> $message",Toast.LENGTH_SHORT).show()
    }
}