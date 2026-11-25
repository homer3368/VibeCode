package com.example.helloapk

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.helloapk.databinding.ActivityMainBinding

/**
 * Minimal template screen: a counter that survives configuration changes.
 * Replace this with your own screens once the build pipeline is verified.
 */
class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private var counter = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        counter = savedInstanceState?.getInt(KEY_COUNTER) ?: 0
        renderCounter()

        binding.buttonTap.setOnClickListener {
            counter++
            renderCounter()
            if (counter == CLICKS_BEFORE_TOAST) {
                Toast.makeText(this, R.string.toast_enough, Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt(KEY_COUNTER, counter)
    }

    private fun renderCounter() {
        binding.counter.text = getString(R.string.counter_format, counter)
    }

    private companion object {
        const val KEY_COUNTER = "counter"
        const val CLICKS_BEFORE_TOAST = 10
    }
}
