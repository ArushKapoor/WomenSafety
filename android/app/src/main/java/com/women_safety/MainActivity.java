package com.women_safety;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.women_safety/background";
    MyService myService = new MyService();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationChannel channel = new NotificationChannel("shake", "Shake", NotificationManager.IMPORTANCE_DEFAULT);
//            NotificationManager manager = getSystemService(NotificationManager.class);
//            manager.createNotificationChannel(channel);
//        }

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if(call.method.equals("printy")) {
                    startService(new Intent(getApplicationContext(),MyService.class));
                    result.success("Hi from Java");
                }
            }
        });

    }

    @Override
    protected void onResume() {
        if(myService.mSensorManager != null) {
            myService.mSensorManager.registerListener(myService.mSensorListener, myService.mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER),
                    SensorManager.SENSOR_DELAY_NORMAL);
        }
        super.onResume();
    }
    @Override
    protected void onPause() {
        if(myService.mSensorManager != null) {
            myService.mSensorManager.unregisterListener(myService.mSensorListener);
        }
        super.onPause();
    }
}
