package com.cmpe282.lab3.util;

import java.io.IOException;
import java.net.InetSocketAddress;

import com.cmpe282.lab3.model.UserProfile;

import net.spy.memcached.MemcachedClient;

public class MemcacheTest {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String configEndpoint = "localhost";
	       Integer clusterPort = 11211;

	     MemcachedClient client = new MemcachedClient(new InetSocketAddress(configEndpoint, clusterPort)); 
	        //DefaultConnectionFactory cf=new DefaultConnectionFactory();
	       // The client will connect to the other cache nodes automatically

	       // Store a data item for an hour.  The client will decide which cache host will store this item. 
	     // Store a value (async) for one hour
	        System.out.println(client.set("someKey", 3600, new UserProfile()));
	        // Retrieve a value (synchronously).
	       //Object myObject=client.get("someKey");
	      // client.set("Key1111", 10, "This is the data value");
	      //System.out.println("Value is "+client.get("first@second.third").toString());
	      System.out.println("Value is "+client.get("someKey").toString());
	      client.shutdown();
	}

}
