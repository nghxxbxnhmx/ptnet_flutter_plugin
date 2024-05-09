package com.example.ptnet_plugin

import com.ftel.ptnetlibrary.services.*
import com.ftel.ptnetlibrary.dto.*
import com.google.gson.Gson
import java.util.concurrent.*

class LibrariesHandler(
    act: String,
    address: String = "",
    server: String = "",
    timeOut: Int = 225,
    ttl: Int = -1,
    port: Int = -1
) {
    private lateinit var result: String

    init {
        result = CompletableFuture.supplyAsync {
            when (act) {
                "ping" -> pingResult(address)
                "pageLoad" -> pageLoadResult(address)
                "dnsLookup" -> dnsLookUpResult(address, server)
                "portScan" -> portScanResult(address, port, timeOut)
                else -> {}
            }
        }.get().toString()
    }

    private fun pingResult(address: String): String {
        // Mai test lai - ko co may test
        return try {
            val pingdto: PingDTO = PingService().execute(address = address)
            Gson().toJson(pingdto)
        } catch (e: Exception) {
            throw RuntimeException("Failed to load page: ${e.message}")
        }

    }

    private fun pageLoadResult(address: String): String {
        return try {
            val pageLoadService = PageLoadService()
            val time = pageLoadService.pageLoadTimer(address)
            Gson().toJson(mapOf("address" to address, "time" to time))
        } catch (e: Exception) {
            throw RuntimeException("Failed to load page: ${e.message}")
        }
    }

    private fun dnsLookUpResult(address: String, server: String): String {
        return try {
            val dnsLookupService = NsLookupService()
            var dnsResult = ArrayList<AnswerDTO>()
            dnsResult = dnsLookupService.execute(address, server)
            Gson().toJson(dnsResult)
        } catch (e: Exception) {
            throw RuntimeException("Failed to get lookup result: ${e.message}")
        }
    }

    private fun portScanResult(
        address: String,
        port: Int,
        timeOut: Int
    ): String {
        return try {
            val portScanService = PortScanService()
            var scanResult = portScanService.portScan(address, port, timeOut)
            if (scanResult.isNotEmpty()) {
                Gson().toJson(mapOf("address" to address, "port" to port, "open" to true))
            } else {
                Gson().toJson(mapOf("address" to address, "port" to port, "open" to false))
            }
        } catch (e: Exception) {
            throw RuntimeException("Failed to get lookup result: ${e.message}")
        }
    }

    fun getResult(): String {
        return this.result
    }
}