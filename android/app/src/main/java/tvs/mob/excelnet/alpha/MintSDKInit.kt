package tvs.mob.excelnet.alpha

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Toolbar
import androidx.activity.OnBackPressedCallback
import androidx.core.app.TaskStackBuilder
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.FragmentActivity
import investwell.mintSdk.MintSDK
import io.flutter.embedding.android.FlutterActivity


class MintSDKInit : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Ensure layout fits system windows
        WindowCompat.setDecorFitsSystemWindows(window, true)

        setContentView(R.layout.activity_mint_sdkinit)

        getBundles()
    }

    private fun getBundles(){
        if (intent !=null && intent.hasExtra("route") && MainActivity.sdkInitialized == true){
            val domain :String = intent.getStringExtra("domain")!!
            val fcm :String= intent.getStringExtra("fcm")!!
            val sso :String= intent.getStringExtra("sso")!!
            MainActivity.sdkInitialized = false
            invokeSDK(sso = sso, fcmToken = fcm, domain = domain)
        }else{
            // remove activity
            if(MainActivity.sdkInitialized == false){
                val intent = Intent(this, MainActivity::class.java)
                // Use TaskStackBuilder to maintain the back stack when going back to MainActivityJ
                android.app.TaskStackBuilder.create(this)
                    .addNextIntentWithParentStack(intent)
                    .startActivities()
                finish()
            }else{
                finish()
            }
//           finish()
        }
    }

    private fun invokeSDK(sso: String,fcmToken:String,domain:String,classWithPackage:String= "${this@MintSDKInit.packageName}.MintSDKInit") {
        val mintSdk = MintSDK(this@MintSDKInit)
        mintSdk.configureSDK(true,null)
        mintSdk.setIsProduction(!BuildConfig.DEBUG)
//        mintSdk.invokeMintSDKForFlutter(sso, fcmToken, domain)
        mintSdk.invokeMintSDK(sso, fcmToken,  domain,classWithPackage)
    }

    override fun onBackPressed() {
        super.onBackPressed()
        removeAllKeys()
        finish()
    }

    fun Activity.onBackButtonPressed(callback: (() -> Boolean)) {
        (this as? FragmentActivity)?.onBackPressedDispatcher?.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                if (!callback()) {
                    remove()
                    performBackPress()
                }
            }
        })
    }

    fun Activity.performBackPress() {
        (this as? FragmentActivity)?.onBackPressedDispatcher?.onBackPressed()
    }


    private fun checkBackStack(){
        val taskStackBuilder = TaskStackBuilder.create(this@MintSDKInit)
        taskStackBuilder.addNextIntentWithParentStack(
            Intent(this@MintSDKInit, MainActivity::class.java)
        )
        taskStackBuilder.startActivities()
    }

    override fun onPause() {
        super.onPause()
        removeAllKeys()
    }

    override fun onDestroy() {
        super.onDestroy()
        removeAllKeys()
    }

    private fun removeAllKeys(){
        if (intent.hasExtra("route")){
            intent.removeExtra("route")
//            intent.removeFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        }
    }
}