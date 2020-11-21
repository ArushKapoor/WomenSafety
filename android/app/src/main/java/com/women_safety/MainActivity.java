package com.women_safety;

import android.Manifest;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.os.Build;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import static android.Manifest.permission.RECORD_AUDIO;
import static android.Manifest.permission.WRITE_EXTERNAL_STORAGE;

import java.util.Random;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_BACKGROUND = "com.women_safety/background";
    private static final String CHANNEL_AUDIO = "com.women_safety/audio";
    MyServiceBackground myService = new MyServiceBackground();
    final int REQUEST_PERMISSION_CODE = 1000;

    public static final int RequestPermissionCode = 1;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel("shake", "Shake", NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL_BACKGROUND).setMethodCallHandler((call, result) -> {
            if(call.method.equals("printy")) {
                startService(new Intent(getApplicationContext(), MyServiceBackground.class));
                result.success("Hi from Java");
            }
        });

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL_AUDIO).setMethodCallHandler((call, result) -> {
            if(call.method.equals("record")) {
                System.out.println("Recording channel is called");
                if(checkPermission()) {
                    startService(new Intent(getApplicationContext(), MyServiceRecordAudio.class));
                } else {
                    requestPermission();
                }

                result.success("Recording");
            } else if(call.method.equals("play")) {
                System.out.println("Playing audio works");

                    startService(new Intent(getApplicationContext(), MyServicePlayAudio.class));

                    requestPermission();

                result.success("Playing");
            }
        });

    }

    private void requestPermission() {
        ActivityCompat.requestPermissions(MainActivity.this, new
                String[]{WRITE_EXTERNAL_STORAGE, RECORD_AUDIO}, RequestPermissionCode);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        switch (requestCode) {
            case RequestPermissionCode:
                if (grantResults.length> 0) {
                    boolean StoragePermission = grantResults[0] ==
                            PackageManager.PERMISSION_GRANTED;
                    boolean RecordPermission = grantResults[1] ==
                            PackageManager.PERMISSION_GRANTED;

                    if (StoragePermission && RecordPermission) {
                        Toast.makeText(MainActivity.this, "Permission Granted",
                                Toast.LENGTH_LONG).show();
                    } else {
                        Toast.makeText(MainActivity.this,"Permission Denied",Toast.LENGTH_LONG).show();
                    }
                }
                break;
        }
    }

    public boolean checkPermission() {
        int result = ContextCompat.checkSelfPermission(getApplicationContext(),
                WRITE_EXTERNAL_STORAGE);
        int result1 = ContextCompat.checkSelfPermission(getApplicationContext(),
                RECORD_AUDIO);
        return result == PackageManager.PERMISSION_GRANTED &&
                result1 == PackageManager.PERMISSION_GRANTED;
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
