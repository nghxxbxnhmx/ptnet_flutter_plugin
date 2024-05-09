package com.example.ptnet_plugin

import com.ftel.ptnetlibrary.services.*
import com.ftel.ptnetlibrary.dto.*
import com.google.gson.Gson
import java.util.concurrent.*
class LibrariesHandler(
    act: String,
    address: String = "",
    server: String = "",
    ttl: Int = -1,
    port: Int = -1
) {
    private lateinit var result: String

    init {
        when (act) {
            "ping" -> result = pingResult(address)
            "pageLoad" -> result = pageLoadResult(address).get()
            "dnsLookup" -> result = dnsLookUpResult(address,server).get()
        }
    }

    private fun pingResult(address: String): String {
        val pingdto: PingDTO = PingService().execute(address = address)
        return Gson().toJson(pingdto)
    }

    private fun pageLoadResult(address: String): CompletableFuture<String> {
        return CompletableFuture.supplyAsync {
            val pageLoadService = PageLoadService()
            try {
                val time = pageLoadService.pageLoadTimer(address)
                Gson().toJson(mapOf("address" to address, "time" to time))
            } catch (e: Exception) {
                throw RuntimeException("Failed to load page: ${e.message}")
            }
        }
    }

    private fun dnsLookUpResult(address: String,server: String): CompletableFuture<String> {
        return CompletableFuture.supplyAsync {
            val dnsLookupService = NsLookupService()
            try {
//                Log.d("Plugins - LookupService", "${dnsLookupService.toString()}")
                var dnsResult = ArrayList<AnswerDTO>()
                // Cannot find source class for androidx.compose.runtime.SnapshotMutableStateImpl - dnsResponseDTO
                dnsResult = dnsLookupService.execute(address, server)
                Gson().toJson(dnsResult)
            } catch (e: Exception) {
                throw RuntimeException("Failed to load page: ${e.message}")
            }
        }
    }
	
	fun getResult(): String{
		return this.result
	}
}