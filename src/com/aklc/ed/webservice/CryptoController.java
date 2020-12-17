package com.aklc.ed.webservice;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.aklc.ed.crypto.AES;

@Path("/crypto")
public class CryptoController {

	@POST
	@Path("/encrypt")
	public Response encryptionService(@QueryParam("data") String data, @QueryParam("key") String key) {
		String result = AES.encrypt(data, key);
		return Response.status(Status.OK).entity(result).build();
	}
	
	@POST
	@Path("/decrypt")
	public Response decryptionService(@QueryParam("data") String data, @QueryParam("key") String key) {
		String result = AES.decrypt(data, key);
		return Response.status(Status.OK).entity(result).build();
	}
}
