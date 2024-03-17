# basm allah elman elrhame

# Notification handler when click

--------------------------------------------------------------------------- Document by Abdallah HimSelf

## setup android

### in Manfiest Android 

```

            <!-- abdo : notification -->
            <meta-data
                android:name="com.google.firebase.messaging.default_notification_channel_id"
                android:value="high_importance_channel"/>


            <meta-data
                android:name="com.google.firebase.messaging.default_notification_icon"
                android:resource="@drawable/notification_icon" />
            <meta-data
                android:name="com.google.firebase.messaging.default_notification_color"
                android:resource="@color/notification_icon_color"  />
 
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"         />

            <meta-data
                android:name="firebase_messaging_auto_init_enabled"
                android:value="false" />
            <meta-data
                android:name="firebase_analytics_collection_enabled"
                android:value="false" />
```

### Drawable Resource

image notification size 24 * 24 px

```
//found in android/src/main/res/drawable/notification_icon.png
```


## setup ios
not write yet documtentaiton

## how to call the code of fcm

from any main page like home, login or any page in main tab navigation screens


```

class HomePage extends StatefulWidget { 
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends ResumableState<HomePage> {

 

  @override
  void initState()    {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      await setupFcmFromMainPage(context);  
    });
    
  }
```