package com.women_safety;

import android.Manifest;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_BACKGROUND = "com.women_safety/background";
    private static final String CHANNEL_AUDIO = "com.women_safety/audio";
    MyServiceBackground myService = new MyServiceBackground();
    final int REQUEST_PERMISSION_CODE = 1000;

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
                if(checkPermissionFromDevice()) {
                    startService(new Intent(getApplicationContext(), MyServiceRecordAudio.class));
                } else {
                    requestPermission();
                }
                result.success("Recording");
            } else if(call.method.equals("play")) {
                System.out.println("Playing audio works");
//                if(checkPermissionFromDevice()) {
                    startService(new Intent(getApplicationContext(), MyServicePlayAudio.class));
//                } else {
//                    requestPermission();
//                }
                result.success("Playing");
            }
        });

    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case REQUEST_PERMISSION_CODE:
                if(grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED)
                    Toast.makeText(this, "Permission Granted", Toast.LENGTH_SHORT).show();
                else
                    Toast.makeText(this, "Permission Denied", Toast.LENGTH_SHORT).show();
                break;
        }
    }

    private void requestPermission() {
        ActivityCompat.requestPermissions(this, new String[]{
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.RECORD_AUDIO
        }, REQUEST_PERMISSION_CODE);
    }

    private boolean checkPermissionFromDevice() {
        int write_external_storage_result = ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
        int record_audio_result = ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO);
        System.out.println(record_audio_result);
        return write_external_storage_result == PackageManager.PERMISSION_GRANTED &&
                record_audio_result == PackageManager.PERMISSION_GRANTED;
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
