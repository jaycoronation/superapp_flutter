package tvs.mob.excelnet.alpha

import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.core.app.TaskStackBuilder
import investwell.mintSdk.MintSDK
import investwell.utils.AppSession
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONException
import org.json.JSONObject
import io.flutter.embedding.android.FlutterFragmentActivity


class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "mint-android-app"
    private var msession: AppSession? = null

    companion object {
        var sdkInitialized: Boolean? = false
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        showToast("onCreate")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { splashScreenView ->
                splashScreenView.remove()
            }
        }

        msession = AppSession(this@MainActivity)

        super.onCreate(savedInstanceState)
    }

    // ✅ Use this instead of manually accessing flutterEngine
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openMintLib" -> {
                    try {
                        var domain = ""
                        var sso = ""
                        var fcm = ""

                        val tokenResponse = JSONObject(call.arguments.toString())
                        if (tokenResponse.toString().isEmpty()) {
                            val jsonString = call.arguments?.toString()
                            jsonString?.let {
                                try {
                                    val newResponse = JSONObject(it)
                                    domain = newResponse.optString("domain")
                                    sso = newResponse.optString("ssoToken")
                                    fcm = newResponse.optString("fcmToken")
                                } catch (e: Exception) {
                                    e.printStackTrace()
                                }
                            }
                        } else {
                            domain = tokenResponse.optString("domain")
                            sso = tokenResponse.optString("ssoToken")
                            fcm = tokenResponse.optString("fcmToken")
                        }

                        sdkInitialized = true
                        val intentsdk = Intent(this@MainActivity, MintSDKInit::class.java)
                        intentsdk.putExtra("route", "main")
                        intentsdk.putExtra("sso", sso)
                        intentsdk.putExtra("domain", domain)
                        intentsdk.putExtra("fcm", fcm)

                        msession = AppSession(this)
                        msession!!.callFromPackage = "com.example.clientuser.java.MainActivityJ"

                        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
                            TaskStackBuilder.create(this)
                                .addNextIntentWithParentStack(intentsdk)
                                .startActivities()
                        } else {
                            startActivity(intentsdk)
                        }

                        result.success("Success")
                    } catch (e: JSONException) {
                        result.error("JSON Parsing Error", e.message, null)
                    }
                }

                "isValidAuth" -> handleAuthCheck(result)
                "clearSession" -> clearSDK()
                else -> result.notImplemented()
            }
        }
    }

    private fun handleAuthCheck(result: MethodChannel.Result) {
        val mintSdk = MintSDK(this@MainActivity)
        mintSdk.configureSDK(true)
        mintSdk.setIsProduction(!BuildConfig.DEBUG)
        result.success(mintSdk.isAuthValidated)
    }

    private fun clearSDK() {
        val mintSdk = MintSDK(this@MainActivity)
        mintSdk.setIsProduction(!BuildConfig.DEBUG)
        mintSdk.clearSDKData()
    }

    // Debug logs
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

    private fun showToast(message: String?) {
        println("SDK App6--> $message")
        // Toast.makeText(this@MainActivity, "SDK App --> $message", Toast.LENGTH_SHORT).show()
    }
}


//class MainActivity: FlutterFragmentActivity() {
//    private val CHANNEL = "mint-android-app"
//    private var msession: AppSession?= null
//    companion object{
//        var sdkInitialized:Boolean?=false
//    }
//    override fun onCreate(savedInstanceState: Bundle?) {
//        // Aligns the Flutter view vertically with the window.
//        showToast("OnCreate")
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//            // Disable the Android splash screen fade out animation to avoid
//            // a flicker before the similar frame is drawn in Flutter.
//            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
//        }
//        msession = AppSession(this@MainActivity)
//        super.onCreate(savedInstanceState)
//        // mintSDK Invoke
////        invoke()
//        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
//        flutterEngine?.dartExecutor?.binaryMessenger?.let {  MethodChannel(it,CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "openMintLib")
//            {
//                try {
//                    var domain =""
//                    var sso =""
//                    var fcm =""
//                    val argumentsString: String? = call.arguments?.toString()
//                    val tokenResponse = JSONObject(call.arguments.toString())
//                    if (tokenResponse.toString().isEmpty()){
//                        argumentsString.let { jsonString->
//                            try {
//                                val newResponse = JSONObject(jsonString)
//                                domain = newResponse.optString("domain")
//                                sso = newResponse.optString("ssoToken")
//                                fcm = newResponse.optString("fcmToken")
//                            }catch (e:Exception){e.printStackTrace()}
//                        }
//                    }else{
//                        domain = tokenResponse.optString("domain")
//                        sso = tokenResponse.optString("ssoToken")
//                        fcm = tokenResponse.optString("fcmToken")
//                    }
////                    invokeSDK(sso,fcm,domain)
////                    invoke(sso, fcmToken = fcm, domain = domain)
//                    sdkInitialized = true
//                    val taskStackBuilder = TaskStackBuilder.create(this@MainActivity)
//                    val intentsdk = Intent(this@MainActivity, MintSDKInit::class.java)
//                    intentsdk.putExtra("route","main")
////                    intentsdk.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_PREVIOUS_IS_TOP)
//                    intentsdk.putExtra("sso",sso)
//                    intentsdk.putExtra("domain",domain)
//                    intentsdk.putExtra("fcm",fcm)
//                    msession = AppSession(this)
//                    msession!!.callFromPackage = "com.example.clientuser.java.MainActivityJ"
//                    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
//                        // For below Android 12, use TaskStackBuilder to preserve the stack
//                        TaskStackBuilder.create(this)
//                            .addNextIntentWithParentStack(intentsdk)
//                            .startActivities()
//                    } else {
//                        // For Android 12 and above, use the standard startActivity
//                        startActivity(intentsdk)
//                    }
//
//
//                    result.success("Success")
//                }catch (e: JSONException) {
//                    // Handle JSON parsing error
//                    result.error("JSON Parsing Error", e.message, null)
//                }
//            }
//            else if (call.method == "isValidAuth")
//            {
//                handleAuthCheck(result)
//            }
//            else if (call.method == "clearSession"){
//            clearSDK()
//        }
//            else
//            {
//                result.notImplemented()
//            }
//        } }
//    }
//
//    // add this function to handle the existing session
//    private fun handleAuthCheck(result: MethodChannel.Result) {
//        val mintSdk = MintSDK(this@MainActivity)
//        mintSdk.configureSDK(true)
//        mintSdk.setIsProduction(!BuildConfig.DEBUG)
//        result.success(mintSdk.isAuthValidated)
//    }
//    private fun clearSDK(){
//        val mintSdk = MintSDK(this@MainActivity)
//        mintSdk.setIsProduction(!BuildConfig.DEBUG)
//        mintSdk.clearSDKData()
//    }
//
//    override fun onStart() {
//        showToast("onStart")
//        super.onStart()
//    }
//    override fun onResume() {
//        showToast("onResume")
//        super.onResume()
//    }
//    override fun onRestart() {
//        showToast("onRestart")
//        super.onRestart()
//    }
//    override fun onPause() {
//        showToast("onPause")
//        super.onPause()
//    }
//    override fun onStop() {
//        showToast("onStop")
//        super.onStop()
//    }
//    override fun onDestroy() {
//        showToast("onDestroy")
//        super.onDestroy()
//    }
//    fun showToast(message:String?){
//        println("SDK App6--> $message")
////        Toast.makeText(this@MainActivity,"SDK App      --> $message",Toast.LENGTH_SHORT).show()
//    }
//}