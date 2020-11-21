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
import java.util.UUID;

public class MyServicePlayAudio extends Service {
    public MyServicePlayAudio() {
    }

    String pathSave = "";
    MediaRecorder mediaRecorder;
    MediaPlayer mediaPlayer;
    private Handler mHandler = new Handler();
    MyServiceRecordAudio myServiceRecordAudio = new MyServiceRecordAudio();

    @Override
    public int onStartCommand(Intent intent, int flags, int startId){
        onTaskRemoved(intent);
        mediaPlayer = new MediaPlayer();
        try{
            System.out.println(myServiceRecordAudio.pathSave);
            System.out.println("Data source is about to be called");
            mediaPlayer.setDataSource(myServiceRecordAudio.pathSave);
            mediaPlayer.prepare();
            mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener(){
                @Override
                public void onPrepared(MediaPlayer mediaPlayer){
                    mediaPlayer.start();
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }

        Toast.makeText(this, "Playing...", Toast.LENGTH_SHORT).show();

        mHandler.postDelayed(mToastRunnable, 15000);

        return START_STICKY;
    }

    private Runnable mToastRunnable = new Runnable() {
        @Override
        public void run() {
            if(mediaPlayer != null) {
                mediaPlayer.stop();
                mediaPlayer.release();
                myServiceRecordAudio.setupMediaRecorder();
            }
        }
    };

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }
}
