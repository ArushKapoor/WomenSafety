package com.women_safety;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.IBinder;
import android.widget.Toast;

import androidx.core.app.NotificationCompat;

import java.util.Objects;

public class MyService extends Service {
    public MyService() {
    }

    public SensorManager mSensorManager;
    public float mAccel;
    public float mAccelCurrent;
    public float mAccelLast;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId){
        onTaskRemoved(intent);
//        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationCompat.Builder builder = new NotificationCompat.Builder(this, "shake")
//                    .setContentText("This is running in background")
//                    .setContentTitle("Flutter Background")
//                    .setSmallIcon(R.drawable.ic_android_black_24dp);
//
//            startForeground(101, builder.build());
//        }
//        Toast.makeText(getApplicationContext(),"This is a Service running in Background",
//                Toast.LENGTH_SHORT).show();
//        System.out.println(mainActivity.mSensorManager);
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
//        Objects.requireNonNull(mSensorManager).registerListener(mSensorListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER),
//                SensorManager.SENSOR_DELAY_NORMAL);
        mAccel = 10f;
        mAccelCurrent = SensorManager.GRAVITY_EARTH;
        mAccelLast = SensorManager.GRAVITY_EARTH;
        if(mSensorManager != null) {
        Objects.requireNonNull(mSensorManager).registerListener(mSensorListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER),
                SensorManager.SENSOR_DELAY_NORMAL);
        }

        return START_STICKY;
    }
    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }
    @Override
    public void onTaskRemoved(Intent rootIntent) {
        Intent restartServiceIntent = new Intent(getApplicationContext(),this.getClass());
        restartServiceIntent.setPackage(getPackageName());
        startService(restartServiceIntent);
        super.onTaskRemoved(rootIntent);
    }

    public final SensorEventListener mSensorListener = new SensorEventListener() {
        @Override
        public void onSensorChanged(SensorEvent event) {
            float x = event.values[0];
            float y = event.values[1];
            float z = event.values[2];
            mAccelLast = mAccelCurrent;
            mAccelCurrent = (float) Math.sqrt((double) (x * x + y * y + z * z));
            float delta = mAccelCurrent - mAccelLast;
            mAccel = mAccel * 0.9f + delta;
            if (mAccel > 12) {
                Toast.makeText(getApplicationContext(), "Shake event detected", Toast.LENGTH_SHORT).show();
            }
        }
        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
    };

}
