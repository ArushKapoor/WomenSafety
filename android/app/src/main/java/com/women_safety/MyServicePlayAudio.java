package com.women_safety;

import android.app.Service;
import android.content.Intent;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.widget.Toast;

import androidx.annotation.Nullable;

import java.io.IOException;
import java.util.Random;
import java.util.UUID;

public class MyServicePlayAudio extends Service {
    public MyServicePlayAudio() {
    }

    public static final int RequestPermissionCode = 1;
    MediaPlayer mediaPlayer ;
    Handler mHandler;
    MyServiceRecordAudio myServiceRecordAudio = new MyServiceRecordAudio();


    @Override
    public int onStartCommand(Intent intent, int flags, int startId){

        mediaPlayer = new MediaPlayer();
        try {
            mediaPlayer.setDataSource(myServiceRecordAudio.AudioSavePathInDevice);
            mediaPlayer.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        }

        mediaPlayer.start();
        Toast.makeText(this, "Recording Playing",
                Toast.LENGTH_LONG).show();

        mHandler.postDelayed(mToastRunnable, 5000);

        return START_STICKY;
    }

    private Runnable mToastRunnable = new Runnable() {
        @Override
        public void run() {
            if(mediaPlayer != null){
                mediaPlayer.stop();
                mediaPlayer.release();
                myServiceRecordAudio.MediaRecorderReady();
            }
            Toast.makeText(MyServicePlayAudio.this, "Recording Completed",
                    Toast.LENGTH_LONG).show();
        }
    };

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }
}
