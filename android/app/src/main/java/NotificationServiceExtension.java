package project.macpokhara.adoptme;
  
import android.content.Context;
import android.util.Log;
import org.json.JSONObject;

import com.onesignal.OSNotification;
import com.onesignal.OSMutableNotification;
import com.onesignal.OSNotificationReceivedEvent;
import com.onesignal.OneSignal.OSRemoteNotificationReceivedHandler;

@SuppressWarnings("unused")
public class NotificationServiceExtension implements OSRemoteNotificationReceivedHandler {

    @Override
    public void remoteNotificationReceived(Context context, OSNotificationReceivedEvent notificationReceivedEvent) {
        OSNotification notification = notificationReceivedEvent.getNotification();

        // Example of modifying the notification's accent color
        // OSMutableNotification mutableNotification = notification.mutableCopy();
        // mutableNotification.setExtender(builder -> {
        //     // Sets the accent color to Green on Android 5+ devices.
        //     // Accent color controls icon and action buttons on Android 5+. Accent color does not change app title on Android 10+
        //     builder.setColor(new BigInteger("FF00FF00", 16).intValue());
        //     // Sets the notification Title to Red
        //     Spannable spannableTitle = new SpannableString(notification.getTitle());
        //     spannableTitle.setSpan(new ForegroundColorSpan(Color.RED),0,notification.getTitle().length(),0);
        //     builder.setContentTitle(spannableTitle);
        //     // Sets the notification Body to Blue
        //     Spannable spannableBody = new SpannableString(notification.getBody());
        //     spannableBody.setSpan(new ForegroundColorSpan(Color.BLUE),0,notification.getBody().length(),0);
        //     builder.setContentText(spannableBody);
        //     //Force remove push from Notification Center after 30 seconds
        //     builder.setTimeoutAfter(30000);
        //     return builder;
        // });
        // JSONObject data = notification.getAdditionalData();
        // Log.i("OneSignalExample", "Received Notification Data: " + data);

        // // If complete isn't call within a time period of 25 seconds, OneSignal internal logic will show the original notification
       
        // To omit displaying a notification, pass `null` to complete()
    //    Log.i("noti" "title" + notification.getTitle());
    //    Log.i("noti" "body" + notification.getBody());

        notificationReceivedEvent.complete(notification);
       // notificationReceivedEvent.complete(mutableNotification);

    }
}